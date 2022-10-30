//
//  RlGetMnemonicViewController.swift
//  CoinBull
//
//  Created by hu Jack on 2021/9/18.
//  Copyright © 2021 Joe. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class RlGetMnemonicViewController: JWBaseViewController {

    var mnemonicItems:[String] = [String]()
    var userModel:UserInfoModel = UserInfoModel()

    private var selectedMnenicItems = Array(repeating: "", count: 12)
    private var randomMnenicItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftNaviItemWithTitle(imageName: "nav_back_white")
        navigationItem.title = NSLocalizedString("备份助记词", comment: "")
        view.backgroundColor = GSColor.bgColor.color
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        titleL.numberOfLines = 4;
        
        let zip = [
            titleLabel,
            showContainerView,
            handlerCollectionView,
            commitBtn,
            titleL
        ]
        
        zip.forEach { scrollView.addSubview($0) }
        
        
        showContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(30)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(UIScreen.main.bounds.width-30)
            make.height.equalTo(300)
        }
      
        handlerCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(showContainerView).offset(15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(270)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(showContainerView.snp.bottom).offset(20)
        }
        
        commitBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(43)
            make.top.equalTo(titleLabel.snp.bottom).offset(70)
        }
        titleL.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(80)
            make.top.equalTo(commitBtn.snp.bottom).offset(10)
        }
        
        handlerCollectionView.type = .handle
        handlerCollectionView.backgroundColor = .clear
        handlerCollectionView.items = mnemonicItems

        commitBtn.addTarget(self, action: #selector(commitBtnTapped), for: .touchUpInside)
    }
    
    override func leftItemTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func commitBtnTapped() {
        let vc  = RLMnemonicBackupController()
        vc.mnemonicItems = mnemonicItems
        vc.userModel = userModel
        self.navigationController?.pushViewController(vc, animated: true)
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
        title:NSLocalizedString("请牢记上面的助记词", comment: "") ,
        color: UIColor.gray,
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
        btn.setTitle(NSLocalizedString("下一步", comment: ""), for: .normal)
        btn.setTitleColor(GSColor.navColor.color, for: .normal)
        btn.backgroundColor = GSColor.themeColor.color
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    
    private lazy var showContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    lazy var titleL: UILabel = {
        return UILabel.label(text:NSLocalizedString("１.獲得助記詞，相當于獲得錢包資産所有權，請妥善保管；\n２.請勿用拍照的方式備份助記詞，防止被第三方軟件泄露。", comment: "") , textColor:GSColor.titleColor.color, font: .dinFont(12), alignment: .left)
    }()
    
    private lazy var showCollectionView: RLBackupMnemonicView = RLBackupMnemonicView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout(),
        showBorder: true,
        rowHeight: 60,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10
    )
    
    private lazy var handlerCollectionView: RLBackupMnemonicView = RLBackupMnemonicView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout(),
        showBorder: true,
        rowHeight: 60,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10
    )
}
