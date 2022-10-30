//
//  RLMnemonicBackupController.swift
//  RLMnemonicBackupDemo
//
//  Created by iOS on 2020/5/22.
//  Copyright © 2020 beiduofen. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

extension RLMnemonicBackupController: PassStatusViewDelegate{
    func statusDoneAction(_ status: Bool) {
        
        let fileManager = FileManager.default
        let filePath:String = NSHomeDirectory() + "/Documents/account.txt"
        let exist = fileManager.fileExists(atPath: filePath)
        if !exist{
          let createSuccess = fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
          if createSuccess{
              let dic1 = ["address":userModel.address,"privteKey":userModel.privteKey,"publickKey":userModel.publickKey,"mnemonics":userModel.mnemonics,"pass":userModel.pass]
              
                let array = NSArray(objects: dic1)
                array.write(toFile: filePath, atomically: true)
          }
        }else{
            guard let originResult = NSArray(contentsOfFile:filePath) else { return }
            let arr = NSMutableArray(array:originResult)
            let dic1 = ["address":userModel.address,"privteKey":userModel.privteKey,"publickKey":userModel.publickKey,"mnemonics":userModel.mnemonics,"pass":userModel.pass]
            arr.add(dic1)
            arr.write(toFile: filePath, atomically: true)
            print(arr)
        }
        
//        let result = NSArray(contentsOfFile:filePath)
            
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}

class RLMnemonicBackupController: JWBaseViewController {
    
    var mnemonicItems:[String] = [String]()
    private var selectedMnenicItems = Array(repeating: "", count: 12)
    private var randomMnenicItems = [String]()
    var userModel:UserInfoModel = UserInfoModel()
    var countValue:NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftNaviItemWithTitle(imageName: "nav_back_white")
        navigationItem.title = NSLocalizedString("备份助记词", comment: "")
        view.backgroundColor = GSColor.bgColor.color
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let zip = [
            titleLabel,
            contentLabel,
            showContainerView,
            showCollectionView,
            handlerCollectionView,
            commitBtn,
            titleL
        ]
        titleL.numberOfLines = 4
        zip.forEach { scrollView.addSubview($0) }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(30)
        }
        
//        contentLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(15)
//            make.right.equalToSuperview().offset(-15)
//            make.top.equalTo(titleLabel.snp.bottom).offset(20)
//        }
//        contentLabel.numberOfLines = 0
        
        showContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(UIScreen.main.bounds.width-30)
            make.height.equalTo(200)
        }
        showCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(showContainerView).offset(15)
            make.center.equalTo(showContainerView)
            make.width.equalTo(UIScreen.main.bounds.width-30-30)
            make.height.equalTo(175)
        }
        
        handlerCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(showCollectionView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(175)
        }
        
        commitBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(43)
            make.top.equalTo(handlerCollectionView.snp.bottom).offset(20)
        }
        titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(80)
            make.top.equalTo(commitBtn.snp.bottom).offset(5)
        }
        
        showCollectionView.type = .show
        handlerCollectionView.type = .handle
        showCollectionView.backgroundColor = .clear
        handlerCollectionView.backgroundColor = .clear
        randomMnenicItems = mnemonicItems.shuffled()
        handlerCollectionView.items = randomMnenicItems
        handlerCollectionView.removeHandler = { [weak self] (text, index, view) in
            guard let self = self else { return }
            self.randomMnenicItems.remove(at: index)
            if let index = self.selectedMnenicItems.firstIndex(of: ""){
                self.selectedMnenicItems.remove(at: index)
                self.selectedMnenicItems.insert(text, at: index)
            }
            view.items = self.randomMnenicItems
            self.showCollectionView.items = self.selectedMnenicItems
            self.countValue += 1
            if self.countValue == 12 {
                guard self.selectedMnenicItems.elementsEqual(self.mnemonicItems) else {
                    SVProgressHUD.showInfo(withStatus:NSLocalizedString("助记词输入错误", comment: "") )
                    return
                }
                self.commitBtn.isEnabled = true
                self.commitBtn.backgroundColor = GSColor.themeColor.color;
                self.commitBtn.setTitleColor(GSColor.navColor.color, for: .normal)
            }else{
                self.commitBtn.isEnabled = false
                self.commitBtn.backgroundColor = GSColor.navColor.color;
                self.commitBtn.setTitleColor(GSColor.themeColor.color, for: .normal)
            }
        }
        
        showCollectionView.items = selectedMnenicItems
        showCollectionView.removeHandler = { [weak self] (text, index, view) in
            guard let self = self else { return }
            self.selectedMnenicItems.remove(at: index)
            self.selectedMnenicItems.insert("", at: index)
            self.randomMnenicItems += [text]
            view.items = self.selectedMnenicItems
            self.handlerCollectionView.items = self.randomMnenicItems
            if self.countValue>0 {
                self.countValue -= 1
                self.commitBtn.isEnabled = false
                self.commitBtn.backgroundColor = GSColor.navColor.color;
                self.commitBtn.setTitleColor(GSColor.themeColor.color, for: .normal)
            }
        }
        
        
        commitBtn.addTarget(self, action: #selector(commitBtnTapped), for: .touchUpInside)
    }
    
    override func leftItemTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func commitBtnTapped() {
        
        let info:UserInfoConfig = UserInfoConfig.shareManager()
        info.saveUserInfo(userModel)
    
        self.resultView.titleS = NSLocalizedString("创建成功", comment: "")
        self.resultView.success = true
        self.resultView.showPop()

    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        scrollView.isPagingEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var titleLabel = UILabel(
        title:NSLocalizedString("请输入您的助记词", comment: "") ,
        color: UIColor.white,
        fontSize: UIFont.boldSystemFont(ofSize: 12)
    )
    
    private lazy var contentLabel = UILabel(
        title: "",
        color: UIColor.red,
        fontSize: UIFont.boldSystemFont(ofSize: 14),
        alignment: .center
    )
    
    private lazy var commitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle(NSLocalizedString("完成", comment: ""), for: .normal)
        btn.setTitleColor(GSColor.themeColor.color, for: .normal)
        btn.backgroundColor = GSColor.navColor.color
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.layer.borderColor = GSColor.themeColor.color.cgColor
        btn.layer.borderWidth = 1
        btn.isEnabled = false
        return btn
    }()
    lazy var titleL: UILabel = {
        return UILabel.label(text:NSLocalizedString("１.獲得助記詞，相當于獲得錢包資産所有權，請妥善保管；\n２.請勿用拍照的方式備份助記詞，防止被第三方軟件泄露。", comment: "") , textColor:GSColor.titleColor.color, font: .dinFont(12), alignment: .left)
    }()
    private lazy var resultView: PassStatusView = {
        let view = PassStatusView(frame: CGRect(x: 35,y: (kScreenHeight-300)/2, width: kScreenWidth-70,height: 300))
        view.delegate = self
        return view
    }()
    private lazy var showContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = GSColor.navColor.color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var showCollectionView: RLBackupMnemonicView = RLBackupMnemonicView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout(),
        showBorder: true,
        rowHeight: 35,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10
    )
    
    private lazy var handlerCollectionView: RLBackupMnemonicView = RLBackupMnemonicView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout(),
        showBorder: true,
        rowHeight: 35,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10
    )
}
