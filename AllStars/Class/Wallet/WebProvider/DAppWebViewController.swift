// Copyright © 2017-2020 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit
import WebKit
import BigInt
import web3swift
//import WebViewJavascriptBridge

extension DAppWebViewController: CoinPayViewDelegate{
    func cancelAction() {
        webview.sendError("Canceled", to: tranferID)
    }
    
    func payAction() {
        
        DispatchQueue.global().async { [self] in
            var transactionJSON = jsonDic["object"] as! Dictionary<String, String>
            transactionJSON["value"] = "0"
        
            guard var transaction = EthereumTransaction.fromJSON(transactionJSON) else {return }
            guard let options = TransactionOptions.fromJSON(transactionJSON) else {return }
            var transactionOptions = TransactionOptions()
            transactionOptions.from = options.from
            transactionOptions.to = options.to
            transactionOptions.value = options.value != nil ? options.value! : BigUInt(0)
            let limtS =  try? self.web3.eth.estimateGas(transaction, transactionOptions: options);
            transactionOptions.gasLimit = .manual(limtS ?? BigUInt(4_300_000))
            transaction.gasLimit = limtS ?? BigUInt(4_300_000)
            let dict: Dictionary < String, String > = self.jsonDic["object"] as! Dictionary<String, String>
            let fromAddress = EthereumAddress(dict["from"]!)!
            let nonceS = try! self.web3.eth.getTransactionCount(address: fromAddress)
            transactionOptions.nonce = .manual(nonceS)
            transaction.nonce = nonceS
            
            transactionOptions.gasPrice = options.gasPrice != nil ? options.gasPrice! : .automatic
           
            //1 通过助记词生成keyStore   2 通过私钥生成keystore
            let mnemonic = UserDefaults.standard.value(forKey: "mnemonics")as!String
            let password = UserDefaults.standard.value(forKey: "pass")as!String
            let privateKey = UserDefaults.standard.value(forKey: "privateKey")as!String
            let address = UserDefaults.standard.value(forKey: "address")as!String
            if mnemonic .isEmpty {
                let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
                let dataKey = Data.fromHex(formattedKey)!
                let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
                let keystoreManager = KeystoreManager([keystore])
                self.web3.addKeystoreManager(keystoreManager)
                
    //            let sign = try! web3.browserFunctions.signTransaction(transaction, transactionOptions: transactionOptions, password: password) ?? nil
            
                let ethereumAddress = EthereumAddress(address)!
                let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress)
                
                guard let hash = transaction.hashForSignature(chainID: nil) else {return }
                let signature  = SECP256K1.signForRecovery(hash: hash, privateKey: pkData, useExtraEntropy: false)
                guard let serializedSignature = signature.serializedSignature else {return}
                guard let unmarshalledSignature = SECP256K1.unmarshalSignature(signatureData: serializedSignature) else {
                    return
                }
                let originalPublicKey = SECP256K1.privateToPublic(privateKey: pkData)
                var d = BigUInt(0)
                var a = BigUInt(0)
                if unmarshalledSignature.v >= 0 && unmarshalledSignature.v <= 3 {
                    d = BigUInt(27)
                } else if unmarshalledSignature.v >= 31 && unmarshalledSignature.v <= 34 {
                    a = BigUInt(4)
                } else if unmarshalledSignature.v >= 35 && unmarshalledSignature.v <= 38 {
                    a = BigUInt(8)
                }
                transaction.v = BigUInt(unmarshalledSignature.v) + d - a
                transaction.r = BigUInt(Data(unmarshalledSignature.r))
                transaction.s = BigUInt(Data(unmarshalledSignature.s))
                let results = try! self.web3.eth.sendRawTransaction(transaction)
                self.webview.sendResult(results.hash , to: self.tranferID )
                

            }else{
                let keystore = try! BIP32Keystore(
                    mnemonics: mnemonic,
                    password: password,
                    mnemonicsPassword: "",
                    language: .english)!
                let keystoreManager = KeystoreManager([keystore])
                self.web3.addKeystoreManager(keystoreManager)
                
                let sign = try! self.web3.browserFunctions.signTransaction(transaction, transactionOptions: transactionOptions, password: password) ?? nil
            
                let ethereumAddress = EthereumAddress(address)!
                let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress)
                
                guard let hash = transaction.hashForSignature(chainID: nil) else {return }
                let signature  = SECP256K1.signForRecovery(hash: hash, privateKey: pkData, useExtraEntropy: false)
                guard let serializedSignature = signature.serializedSignature else {return}
                guard let unmarshalledSignature = SECP256K1.unmarshalSignature(signatureData: serializedSignature) else {
                    return
                }
//                let originalPublicKey = SECP256K1.privateToPublic(privateKey: pkData)
                var d = BigUInt(0)
                var a = BigUInt(0)
                if unmarshalledSignature.v >= 0 && unmarshalledSignature.v <= 3 {
                    d = BigUInt(27)
                } else if unmarshalledSignature.v >= 31 && unmarshalledSignature.v <= 34 {
                    a = BigUInt(4)
                } else if unmarshalledSignature.v >= 35 && unmarshalledSignature.v <= 38 {
                    a = BigUInt(8)
                }
                transaction.v = BigUInt(unmarshalledSignature.v) + d - a
                transaction.r = BigUInt(Data(unmarshalledSignature.r))
                transaction.s = BigUInt(Data(unmarshalledSignature.s))
                do{
                    let results = try self.web3.eth.sendRawTransaction(transaction)
                    DispatchQueue.main.async {
                        self.webview.sendResult(results.hash , to: self.tranferID )

                       }

                }catch{
                    DispatchQueue.main.async {
                        TRToast.toast(message: "error");
                        webview.sendError("Canceled", to: tranferID)

                       }

                }
               
                
        }
       
//            let paramS: Dictionary < String, String > = ["address":dict["from"]!,"hash":results.hash,"status":"1"]
//            CSNetworkTool.shareManager().postMethodName("/v2/star/hash/add", parameter: paramS, images: nil) { responseObject, loadSuccess in
//                DLog(message: "result::\(responseObject)")
//            } failure: { error in
//          }
        }
    }
}

class DAppWebViewController: JWBaseViewController {
    
    var jsonDic: Dictionary < String, Any > = [:]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @objc var homepage: String = ""
    @objc var fromS: String = ""
    var balanceStr:String = ""
    var tranferID:Int64 = 0
    lazy var web3:web3 = {
        return try! Web3.new(URL(string: rpcURL)!) 
    }()

//    var bridge: WebViewJavascriptBridge?
    
    lazy var backBtn:UIButton = {
       
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(imageNamed("nav_back_white"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(GSColor.themeColor.color, for: .selected)
        btn.addTarget(self, action: #selector(backClick(but:)), for: .touchUpInside)
        return btn
    }()
    @objc func backClick(but:UIButton) {
        self.navigationController?.popViewController(animated: true)//返回父级
    }
//    var homepage: String {
//        return magicBox
//    }

    lazy var address: String = {
//        return "0x914E99d483da28Dc8206773E9C664fd70581AA66"
        return UserDefaults.standard.value(forKey:"address") as! String
    }()
    
    lazy var scriptConfig: WKUserScriptConfig = {
        return WKUserScriptConfig(
            address: address,
            chainId: Int(chainID),
            rpcUrl: rpcURL
        )
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    lazy var webview: WKWebView = {
        let config = WKWebViewConfiguration()

        let controller = WKUserContentController()
        controller.addUserScript(scriptConfig.providerScript)
        controller.addUserScript(scriptConfig.injectedScript)
        controller.add(self, name: "_tw_")
        controller.add(self, name: "backWeb")
        controller.add(self, name: "backApp")

        config.userContentController = controller

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.uiDelegate = self
        webview.navigationDelegate = self
        webview.scrollView.bounces = false;
        webview.backgroundColor = UIColor.mainColor();
        webview.scrollView.backgroundColor = UIColor.mainColor();

        return webview
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if fromS.ns_String.intValue == 1{
            self.tabBarController?.tabBar.isHidden = true;
            appDelegate.allowRotation = true
            self.setNewOrientation(fullScreen: true)
        }
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        if fromS.ns_String.intValue == 1{
            appDelegate.allowRotation = false
            //判断退出时是否是横屏
            if UIApplication.shared.statusBarOrientation.isLandscape {
                //是横屏让变回竖屏
                self.setNewOrientation(fullScreen: false)
            }
            self.tabBarController?.tabBar.isHidden = false;
        }
       
        super.viewWillDisappear(animated)

    }
    override var shouldAutorotate: Bool
    {
        if fromS.ns_String.intValue == 1{
            return true;
        }
        return false;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscape;
    }
    //横竖屏
    func setNewOrientation(fullScreen: Bool) {
            if fullScreen { //横屏
                let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
                UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
                
                let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeLeft.rawValue)
                UIDevice.current.setValue(orientationTarget, forKey: "orientation")
                
            }else { //竖屏
                let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
                UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
                
                let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
                UIDevice.current.setValue(orientationTarget, forKey: "orientation")
            }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = UIColor.mainColor()
        setupSubviews()
//        registerHandler()
        navigate(to: homepage)
  

        let  web3 = try! Web3.new(URL(string: rpcURL)!)
        let walletAddress = EthereumAddress(address)! // Address which balance we want to know
        //获取余额
        let balanceResult = try! web3.eth.getBalance(address: walletAddress)
        balanceStr = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
      
    }
  /*
    func registerHandler() {
            func parameterValid(with data: Any?) -> (result: Bool, data: [String: Any]) {
                if let parameter = data, parameter is NSDictionary {
                    let dic = parameter as! NSDictionary
                    if let params = dic as? [String: Any] {
                        return (true, params)
                    }
                }
                
                return (false, [:])
            }
            
            func callback(with closure: WVJBResponseCallback?, data: [String: Any]) {
                if let call = closure {
                    call(data as NSDictionary)
                }
            }
            
            self.bridge = WebViewJavascriptBridge(forWebView: webview)
            self.bridge?.registerHandler("fetchSellOut", handler: { (data, responseCallback) in
                let params = parameterValid(with: data)
                var result: [[String: String]] = []
                //判断参数是否有效
                if params.result, let unicode = params.data["ids"], let unicodeStr = unicode as? String {
                // 拿到数据操作
                }
                // 给H5传值
                callback(with: responseCallback, data: ["result":result])
            })
    }
   */
    func setupSubviews() {
    
        view.addSubview(webview)
        if #available(iOS 11.0, *) {
            webview.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
          // Earlier version of iOS
        }
//        webview.backgroundColor = UIColor.mainColor()
//        webview.scrollView.frame.size.height = self.view.mj_h-kStatusBarHeight;
        if fromS.ns_String.intValue == 1{
            webview.snp.makeConstraints { make in
                make.right.equalTo(0)
                make.left.equalTo(0)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
            }
        }else{
            webview.snp.makeConstraints { make in
                make.right.equalTo(0)
                make.left.equalTo(0)
                make.top.equalTo(kNavigationBarHeight)
                make.bottom.equalTo(0)
            }
        }
        
    }

    func navigate(to url: String) {
        guard let url = URL(string: url) else { return }
        webview.load(URLRequest(url: url))
    }
}

extension DAppWebViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("document.body.scrollHeight") { [unowned self] (result, error) in
//
//            DispatchQueue.main.async { [unowned self] in
//                           var tempFrame: CGRect = webView.frame
//                print(tempFrame.size.height)
//                print(self.view.size.height)
//                       }
//
//           }
    }
  
}

extension DAppWebViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigate(to: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}

extension DAppWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "backWeb"{
            self.navigationController?.popViewController(animated: true)//返回父级
        }
        if message.name == "backApp"{
            self.navigationController?.popViewController(animated: true)//返回父级
        }
        let json = message.json
        print(json)
        guard let name = json["name"] as? String,
            let method = DAppMethod(rawValue: name),
            let id = json["id"] as? Int64 else {
            return
        }
        switch method {
        case .requestAccounts:
//            handleRequestAccounts(id: id)
            let address = scriptConfig.address
            webview.evaluateJavaScript("window.ethereum.setAddress(\"\(address)\");", completionHandler: nil)
            webview.sendResults([address], to: id)
        case .signTransaction:
            guard extractMessage(json: json) != nil else {
                print("data is missing")
                return
            }
            tranferID = id //交易ID
//            handleSignMessage(id: id, data: data, addPrefix: false)
            jsonDic = json
            let value = balanceStr.doubleValue
            let dict1 = jsonDic["object"] as! Dictionary<String, String>
            var transactionJSON = jsonDic["object"] as! Dictionary<String, String>
            transactionJSON["value"] = "0"

            guard var transaction = EthereumTransaction.fromJSON(transactionJSON) else {return }
            
            let gas:String = transactionJSON["gas"]!;
            transaction.gasLimit = Web3.Utils.hexToBigUInt(gas)!
            let total = (transaction.gasPrice) * (transaction.gasLimit)+transaction.value
            
            let totalS = Web3.Utils.formatToEthereumUnits(total, toUnits: .eth, decimals: 6)!
            if value == 0 || totalS.doubleValue>value{
                TRToast.toast(message: Bundle.mj_localizedString(forKey: "BNB不足", value: nil))
                webview.sendError("Canceled", to: id)
                return
            }
         
            
            let payView = CoinPayView(frame: CGRect(x: 0,y: (kScreenHeight-400), width: kScreenWidth,height: 400))
            payView.delegate = self
            payView.valueS = String(totalS);
            payView.dataDic = dict1
            payView.showPop()
            
        default:
            break
        }
    }
    
    func handleRequestAccounts(id: Int64) {
        let alert = UIAlertController(
            title: webview.title,
            message: "\(webview.url?.host! ?? "Website") would like to connect your account",
            preferredStyle: .alert
        )
        let address = scriptConfig.address
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak webview] _ in
            webview?.sendError("Canceled", to: id)
        }))
        alert.addAction(UIAlertAction(title: "Connect", style: .default, handler: { [weak webview] _ in
            webview?.evaluateJavaScript("window.ethereum.setAddress(\"\(address)\");", completionHandler: nil)
            webview?.sendResults([address], to: id)
        }))
        present(alert, animated: true, completion: nil)
    }

    func handleSignMessage(id: Int64, data: Data, addPrefix: Bool) {
        let alert = UIAlertController(
            title: "Sign Message",
            message: addPrefix ? String(data: data, encoding: .utf8) ?? "" : data.hexString,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak webview] _ in
            webview?.sendError("Canceled", to: id)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak webview] _ in
//            let signed = self.signMessage(data: data, addPrefix: addPrefix)
//            webview?.sendResult("0x" + signed.hexString, to: id)
        }))
        present(alert, animated: true, completion: nil)
        
    }

//    func handleSignTypedMessage(id: Int64, data: Data, raw: String) {
//        let alert = UIAlertController(
//            title: "Sign Typed Message",
//            message: raw,
//            preferredStyle: .alert
//        )
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak webview] _ in
//            webview?.sendError("Canceled", to: id)
//        }))
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak webview] _ in
//            let signed = self.signMessage(data: data, addPrefix: false)
//            webview?.sendResult("0x" + signed.hexString, to: id)
//        }))
//        present(alert, animated: true, completion: nil)
//    }

//    func alert(title: String, message: String) {
//        let alert = UIAlertController(
//            title: title,
//            message: message,
//            preferredStyle: .alert
//        )
//        alert.addAction(.init(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }

    private func extractMessage(json: [String: Any]) -> Data? {
        guard
            let params = json["object"] as? [String: Any],
            let string = params["data"] as? String,
            let data = Data(hexString: string)
        else {
            return nil
        }
        return data
    }

//    private func extractSignature(json: [String: Any]) -> (signature: Data, message: Data)? {
//        guard
//            let params = json["object"] as? [String: Any],
//            let signature = params["signature"] as? String,
//            let message = params["message"] as? String
//        else {
//            return nil
//        }
//        return (Data(hexString: signature)!, Data(hexString: message)!)
//    }

    private func extractChainInfo(json: [String: Any]) ->(chainId: String, name: String, rpcUrls: [String])? {
        guard
            let params = json["object"] as? [String: Any],
            let string = params["chainId"] as? String,
            let name = params["chainName"] as? String,
            let urls = params["rpcUrls"] as? [String]
        else {
            return nil
        }
        return (chainId: string, name: name, rpcUrls: urls)
    }

    private func extractRaw(json: [String: Any]) -> String? {
        guard
            let params = json["object"] as? [String: Any],
            let raw = params["raw"] as? String
        else {
            return nil
        }
        return raw
    }

//    private func signMessage(data: Data, addPrefix: Bool = true) -> Data {
//        let message = addPrefix ? Hash.keccak256(data: ethereumMessage(for: data)) : data
//        var signed = privateKey.sign(digest: message, curve: .secp256k1)!
//        signed[64] += 27
//        return signed
//    }

//    private func ecRecover(signature: Data, message: Data) -> String? {
//        let data = ethereumMessage(for: message)
//        let hash = Hash.keccak256(data: data)
//        guard let publicKey = PublicKey.recover(signature: signature, message: hash),
//            PublicKey.isValid(data: publicKey.data, type: publicKey.keyType) else {
//            return nil
//        }
//        return CoinType.ethereum.deriveAddressFromPublicKey(publicKey: publicKey).lowercased()
//    }

    private func ethereumMessage(for data: Data) -> Data {
        let prefix = "\u{19}Ethereum Signed Message:\n\(data.count)".data(using: .utf8)!
        return prefix + data
    }

}

extension DAppWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard navigationAction.request.url != nil else {
           return nil
        }
        _ = webView.load(navigationAction.request)
        return nil
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { _ in
            completionHandler()
        }))
        present(alert, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: { _ in
            completionHandler(true)
        }))
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: { _ in
            completionHandler(false)
        }))
        present(alert, animated: true, completion: nil)
    }
}


