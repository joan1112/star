//
//  ImPortWalletViewController.swift
//  CoinBull
//
//  Created by hu Jack on 2021/9/21.
//  Copyright © 2021 Joe. All rights reserved.
//

import UIKit
import web3swift

@objcMembers
class ImPortWalletViewController: JWBaseViewController {

    var password : String = ""
    var selectIndex = 0
    
    lazy var topView:UIView = {
       
        let topView = UIView()
        topView.backgroundColor = UIColor.hex(0x4F5C6F)
        _ = topView.cornerRadius(r: 5)
        return topView
    }()
    lazy var topBtBgView:UIView = {
       
        let topView = UIView()
        
        topView.backgroundColor = GSColor.navColor.color
        
        _ = topView.cornerRadius(r: 5)
        
        return topView
    }()
    lazy var btn1:UIButton = {
       
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle(Bundle.mj_localizedString(forKey: "助記詞"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(GSColor.themeColor.color, for: .selected)
        btn.isSelected = true
        btn.addTarget(self, action: #selector(btn1Click(but:)), for: .touchUpInside)
        
        return btn
    }()
    @objc func btn1Click(but:UIButton) {
        
        btn1.isSelected = true
        btn2.isSelected = false
        nameLabel.text = Bundle.mj_localizedString(forKey: "助记词输入")
        selectIndex = 0;
        topBtBgView.snp.updateConstraints { make in
            
            make.left.equalTo(3)
            
        }
        
        feild1.placeholder = Bundle.mj_localizedString(forKey: "请输入您的助记词")
        feild1.text = ""
    }
    lazy var btn2:UIButton = {
       
        let btn = UIButton()
        
        btn.backgroundColor = .clear
        btn.setTitle(Bundle.mj_localizedString(forKey: "私钥"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(GSColor.themeColor.color, for: .selected)
        btn.addTarget(self, action: #selector(btn2Click(but:)), for: .touchUpInside)

        return btn
    }()
    @objc func btn2Click(but:UIButton) {
        btn1.isSelected = false
        btn2.isSelected = true
        topBtBgView.snp.updateConstraints { make in
            
            make.left.equalTo(3 + 125)
            
        }
        selectIndex = 1;
        nameLabel.text = Bundle.mj_localizedString(forKey: "私钥导入")
        feild1.placeholder = Bundle.mj_localizedString(forKey: "请输入私钥")
        feild1.text = ""

    }
    lazy var nameLabel: UILabel = {
        return UILabel.label(text: Bundle.mj_localizedString(forKey: "助記詞"), textColor: .white, font: .dinFont(15), alignment: .center)
    }()
    lazy var bgView:UIView = {
    
        let bg = UIView()
        bg.backgroundColor = GSColor.navColor.color
        _ = bg.cornerRadius(r: 3)
        
        return bg
    }()
   
    lazy var feild1:UITextField = {
       
        let feild = UITextField()
        feild.textColor = .white
        feild.placeholder = Bundle.mj_localizedString(forKey: "请输入您的助记词")
        return feild
    }()
   
    lazy var doneBtn:UIButton = {
        let btn = UIButton.button(rect: .zero, text:  Bundle.mj_localizedString(forKey: "导入"), textColor: UIColor.hex(0x1E2934), backColor: GSColor.themeColor.color, font: .dinFont(15), target: self, sel: #selector(doneClick), superView: nil)
        _ = btn.cornerRadius(r: 5)
        
        return btn
    }()
    lazy var counts:UIButton = {
        let btn = UIButton.button(rect: .zero, text:  Bundle.mj_localizedString(forKey: "测试账号"), textColor: UIColor.hex(0x1E2934), backColor: GSColor.themeColor.color, font: .dinFont(15), target: self, sel: #selector(doneClick1), superView: nil)
        _ = btn.cornerRadius(r: 5)
        
        return btn
    }()
    
       @objc func doneClick1() {
//59e4e38e0bbfbc9bc585e5b55cd7807b81972c171e0cbc9b810a9dce8379eab0
//6bfdbda4c2cd834b2873a01863624761d0a70b1bf0312ccfa8e66fb30f608dfd
//206dc6bb118536908feb543c3eba433ba002dfa08404e636e1fe7f043ba80349
           feild1.text = "206dc6bb118536908feb543c3eba433ba002dfa08404e636e1fe7f043ba80349"
       }
   @objc func doneClick() {
        
 
    if feild1.text?.count == 0 {
        
        if selectIndex == 0 {
            TRToast.toast(message: Bundle.mj_localizedString(forKey: "请输入您的助记词"))

        }
        else {
            TRToast.toast(message: Bundle.mj_localizedString(forKey: "请输入私钥"))

        }
        return
    }
    
    
    if selectIndex == 0 {
        importWithMnemonic()
    }
    else {
        importWithPrivateKey()

    }
   }
    
    // 助记词
    func importWithMnemonic() {
        
        let mnemonics = feild1.text!
        
        let keystore = try? BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            mnemonicsPassword: "",
            language: .english)
        if keystore == nil{
            TRToast.toast(message: Bundle.mj_localizedString(forKey: "助记词输入错误"))
            return
        }else{
          let keystore = try! BIP32Keystore(
                mnemonics: mnemonics,
                password: password,
                mnemonicsPassword: "",
                language: .english)!
            let address:String = keystore.addresses!.first!.address
            if UserDefaults.standard.object(forKey: address) != nil {
                TRToast.toast(message: Bundle.mj_localizedString(forKey: "已經导入"))
//                self.navigationController?.popToRootViewController(animated: true)
            }
            else {
                //生成私钥
                DispatchQueue.global().async { [self] in
                    let ethereumAddress = EthereumAddress(address)!
                    let keystoreManager = KeystoreManager([keystore])
                    let privateKey = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress).toHexString()
                    //生成公钥
                    let publicKey = SECP256K1.privateToPublic(privateKey: try!keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress))?.toHexString()
                    // 保存数据
                    let userInfo:UserInfoModel = UserInfoModel()
                    userInfo.mnemonics = mnemonics
                    userInfo.pass = password
                    userInfo.address = address
                    userInfo.privteKey = privateKey
                    userInfo.publickKey = publicKey!
                    let info:UserInfoConfig = UserInfoConfig.shareManager()
                    info.saveUserInfo(userInfo)
                    
                    let fileManager = FileManager.default
                    let filePath:String = NSHomeDirectory() + "/Documents/account.txt"
                    let exist = fileManager.fileExists(atPath: filePath)
                    if !exist{
                      let createSuccess = fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
                      if createSuccess{
                          let dic1 = ["address":userInfo.address,"privteKey":userInfo.privteKey,"publickKey":userInfo.publickKey,"mnemonics":userInfo.mnemonics,"pass":userInfo.pass]
                          
                            let array = NSArray(objects: dic1)
                            array.write(toFile: filePath, atomically: true)
                      }
                    }else{
                        guard let originResult = NSArray(contentsOfFile:filePath) else { return }
                        let arr = NSMutableArray(array:originResult)
                        let dic1 = ["address":userInfo.address,"privteKey":userInfo.privteKey,"publickKey":userInfo.publickKey,"mnemonics":userInfo.mnemonics,"pass":userInfo.pass]
                        arr.add(dic1)
                       
                        for dic in originResult{
                            let dics:Dictionary<String,String>  = dic as! Dictionary<String, String>
                            if(dics["address"] == userInfo.address){
                                TRToast.toast(message: Bundle.mj_localizedString(forKey: "已經导入"))
                                return;
                            }
                        }
                            arr.write(toFile: filePath, atomically: true)
                       
                       
                    }
                    DispatchQueue.main.async {
                        TRToast.toast(message: Bundle.mj_localizedString(forKey: "导入成功"))
                        self.navigationController?.popToRootViewController(animated: true)
                        NotificationCenter.default.post(name: NSNotification.Name("getBanlanceDataNotice"), object: nil, userInfo: ["post":"NewTest"])
                                            
    }

                    
                }
                
        
            }
        }
        
    }
    func importWithPrivateKey() {
        
        let key = feild1.text! // Some private key
        let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let userInfo:UserInfoModel = UserInfoModel()

        let dataKey = Data.fromHex(formattedKey)
        if dataKey == nil{
            TRToast.toast(message: Bundle.mj_localizedString(forKey: ""))
            return
        }else{
            
            let dataKey = Data.fromHex(formattedKey)!
            let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)
            if keystore == nil{
                TRToast.toast(message: Bundle.mj_localizedString(forKey: "私钥输入错误"))
                return
            }else{
                let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
                let address = keystore.addresses!.first!.address
                if let string = UserDefaults.standard.object(forKey: "address"),string as! String==address {
                    TRToast.toast(message: Bundle.mj_localizedString(forKey: "已經导入"))
                    self.navigationController?.popToRootViewController(animated: true)
                }
                else {
                    //生成私钥
                    DispatchQueue.global().async { [self] in
                        let ethereumAddress = EthereumAddress(address)!
                        let keystoreManager = KeystoreManager([keystore])
    //                    let privateKey = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress).toHexString()
                        //生成公钥
                        let publicKey = SECP256K1.privateToPublic(privateKey: try!keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress))?.toHexString()
                        
                        userInfo.privteKey = key
                        userInfo.pass = self.password
                        userInfo.address = address
                        userInfo.mnemonics = ""
                        userInfo.publickKey = publicKey!
                        let info:UserInfoConfig = UserInfoConfig.shareManager()
                        info.saveUserInfo(userInfo)
                        let fileManager = FileManager.default
                        let filePath:String = NSHomeDirectory() + "/Documents/account.txt"
                        let exist = fileManager.fileExists(atPath: filePath)
                        if !exist{
                          let createSuccess = fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
                          if createSuccess{
                              let dic1 = ["address":userInfo.address,"privteKey":userInfo.privteKey,"publickKey":userInfo.publickKey,"mnemonics":userInfo.mnemonics,"pass":userInfo.pass]
                              
                                let array = NSArray(objects: dic1)
                                array.write(toFile: filePath, atomically: true)
                          }
                        
                        }else{
                            guard let originResult:NSArray = NSArray(contentsOfFile:filePath) else { return }
                            let arr:NSMutableArray = NSMutableArray(array:originResult)
                            
                            for dic in originResult{
                                let dics:Dictionary<String,String>  = dic as! Dictionary<String, String>
                                if(dics["address"] == userInfo.address){
                                    TRToast.toast(message: Bundle.mj_localizedString(forKey: "已經导入"))
                                    return;
                                }
                            }
                            let dic1:Dictionary<String,String> = ["address":userInfo.address,"privteKey":userInfo.privteKey,"publickKey":userInfo.publickKey,"mnemonics":userInfo.mnemonics,"pass":userInfo.pass]
                            arr.add(dic1)
                            arr.write(toFile: filePath, atomically: true)

                        }
                                            DispatchQueue.main.async {
                                                TRToast.toast(message: Bundle.mj_localizedString(forKey: "导入成功"))
                                                self.navigationController?.popToRootViewController(animated: true)
                                                NotificationCenter.default.post(name: NSNotification.Name("getBanlanceDataNotice"), object: nil, userInfo: ["post":"NewTest"])
                            }
                   
                            }
                   
                    // 保存数据

                   
                    
                    
                
                    
                }
            }
            
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
//
//    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Bundle.mj_localizedString(forKey: "导入钱包")
        view.addSubviews(topView,nameLabel,bgView,doneBtn)
        
        backRoot = true;
        topView.addSubview(topBtBgView)
        topView.addSubview(btn1)
        topView.addSubview(btn2)
        bgView.addSubview(feild1)
       

        topView.snp.makeConstraints { make in
            
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(256)
            make.height.equalTo(34)
            
        }
        topBtBgView.snp.makeConstraints { make in
            
            make.left.equalTo(3)
            make.width.equalTo(125)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
        }
        btn1.snp.makeConstraints { make in
            
            make.left.equalTo(3)
            make.width.equalTo(125)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        btn2.snp.makeConstraints { make in
            
            make.right.equalTo(-3)
            make.width.equalTo(125)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(topView.snp.bottom).offset(20)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.right.equalTo(-15)
            make.height.equalTo(140)
        }
        
        feild1.snp.makeConstraints { make in
            
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.right.equalTo(-15)
        }
            
        doneBtn.snp.makeConstraints { make in
            make.left.equalTo(100)
            make.right.equalTo(-100)
            make.top.equalTo(bgView.snp.bottom).offset(40)
            make.height.equalTo(43)
        }
        if KisDebugNet == 1{
            view.addSubviews(counts);
            counts.snp.makeConstraints { make in
                make.left.equalTo(100)
                make.right.equalTo(-100)
                make.top.equalTo(doneBtn.snp.bottom).offset(40)
                make.height.equalTo(43)
            }

        }
        
        
    }

   }
  
