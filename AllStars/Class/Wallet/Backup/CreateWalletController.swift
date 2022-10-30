//
//  CreateWalletController.swift
//  CoinBull
//
//  Created by hu Jack on 2021/9/19.
//  Copyright © 2021 Joe. All rights reserved.
//

import UIKit
import web3swift

@objcMembers
class CreateWalletController: JWBaseViewController {
    
    var passWord:String = ""
    
    
    lazy var doneBtn:UIButton = {
        let btn = UIButton.button(rect: .zero, text:NSLocalizedString("开始备份", comment: ""), textColor: GSColor.navColor.color, backColor: GSColor.themeColor.color, font: .dinFont(15), target: self, sel: #selector(doneClick), superView: nil)
        _ = btn.cornerRadius(r: 5)
        
        return btn
    }()
   @objc func doneClick() {
    
    let bitsOfEntropy: Int = 128 // Entropy is a measure of password strength. Usually used 128 or 256 bits.
    // 生成助记词
    let mnemonics = try! BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy)!
    let keystore = try! BIP32Keystore(
        mnemonics: mnemonics,
        password: passWord,
        mnemonicsPassword: "",
        language: .english)!
//    let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
    //地址
    let address = keystore.addresses!.first!.address
    //生成私钥
    let ethereumAddress = EthereumAddress(address)!
    let keystoreManager = KeystoreManager([keystore])
    let privateKey = try! keystoreManager.UNSAFE_getPrivateKeyData(password: passWord, account: ethereumAddress).toHexString()
    //生成公钥
    let publicKey = SECP256K1.privateToPublic(privateKey: try!keystoreManager.UNSAFE_getPrivateKeyData(password: passWord, account: ethereumAddress))?.toHexString()
       
    let userModel:UserInfoModel = UserInfoModel()
       userModel.address = address
       userModel.pass = passWord
       userModel.privteKey = privateKey
       userModel.mnemonics = mnemonics
       userModel.publickKey = publicKey!
    
    let mnemonicsArray:[String] = mnemonics.components(separatedBy: " ")
    let vc = RlGetMnemonicViewController()
    vc.mnemonicItems = mnemonicsArray
    vc.userModel = userModel
    self.navigationController?.pushViewController(vc, animated: true)
    
    
    }
    
    lazy var nameLabel: UILabel = {
        return UILabel.label(text: NSLocalizedString("备份助记词", comment: ""), textColor: .white, font: .dinFont(15), alignment: .center)
    }()
    
    lazy var iconV: UIImageView = {
        let bg = UIImageView()
        bg.backgroundColor = .clear
        _ = bg.cornerRadius(r: 3)
        bg.contentMode = .scaleAspectFill
        bg.image = imageNamed("禁止")
        return bg
    }()
    lazy var bgView:UIView = {
    
        let bg = UIView()
        bg.backgroundColor = GSColor.navColor.color
        _ = bg.cornerRadius(r: 3)
        
        return bg
    }()
    lazy var notiV: UIImageView = {
        let bg = UIImageView()
        bg.backgroundColor = .clear
        _ = bg.cornerRadius(r: 3)
        bg.contentMode = .scaleAspectFill
        bg.image = imageNamed("形状 1")
        return bg
    }()
    lazy var titleL1: UILabel = {
        return UILabel.label(text:NSLocalizedString("注意:", comment: ""), textColor: GSColor.titleColor.color, font: .dinFont(12), alignment: .left)
    }()
    lazy var titleL2: UILabel = {
        return UILabel.label(text: NSLocalizedString("１.獲得助記詞，相當于獲得錢包資産所有權，請妥善保管；\n２.請勿用拍照的方式備份助記詞，防止被第三方軟件泄露。", comment: ""), textColor:GSColor.titleColor.color, font: .dinFont(12), alignment: .left)
    }()
  
       
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("创建钱包", comment: "")
        
        view.addSubview(nameLabel)
        view.addSubviews(iconV)
        view.addSubview(bgView)
        bgView.addSubviews(notiV)
        bgView.addSubviews(titleL1)
        bgView.addSubviews(titleL2)
        titleL2.numberOfLines = 4
        view.addSubview(doneBtn)
        nameLabel.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.left.equalTo(15)
            make.top.equalTo(100)
            make.centerX.equalTo(self.view.centerX)
        }
        iconV.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self.view.centerX)
            make.width.equalTo(72)
            make.height.equalTo(72)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.bottom.equalTo(doneBtn.snp.top).offset(-20)
            make.right.equalTo(-20)
            make.height.equalTo(140)
        }
        notiV.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(bgView.snp.top).offset(30)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        titleL1.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(bgView.snp.top).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(12)
        }
        titleL2.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(bgView.snp.top).offset(40)
            make.width.equalTo(kScreenWidth-70)
            make.height.equalTo(100)
        }
        doneBtn.snp.makeConstraints { make in
            
            make.left.equalTo(100)
            make.right.equalTo(-100)
            make.top.equalTo(self.view.snp.bottom).offset(-150)
            make.height.equalTo(43)
        }
    }

    
}
