//
//  JWBaseTableViewController.swift
//  CoinBull
//
//  Created by WuQiaoqiao on 16/2/29.
//  Copyright © 2016年 Joe. All rights reserved.
//

import UIKit
//import MJRefresh

enum RefreshActionType : UInt {
    case refresh = 1001
    case loadMore
}

class JWBaseTableViewController: JWBaseViewController  {

    private(set) var currentPage : Int = 1
    let pageCount : Int = 10
//    private lazy var cellModels : [Any] = []
    
    lazy var baseTableView : UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = GSColor.bgColor.color
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = FitHightCGFloatAuto(100)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    func resetPage() {
        currentPage = 1
    }
     
    /**
     添加一个下拉刷新控件
     */
    func addHeaderRefreshControl<T:UIScrollView>(tableView: T? = nil, block:@escaping MJRefreshComponentAction) {
        
        let mTableView = tableView ?? baseTableView
        let header = MJRefreshNormalHeader{[weak self] in
            guard let `self` = self else {return}
            self.currentPage = 1
            block()
        }
//            header.beginRefreshing()
            header.stateLabel?.font = UIFont.systemFont(ofSize: 12.0)
            header.lastUpdatedTimeLabel?.font = UIFont.systemFont(ofSize: 12.0)
            mTableView.mj_header = header
        
    }
    
    
    /**
     添加一个上拉加载控件
     */
    
    func addFooterLoadControl(tableView: UITableView? = nil, block:@escaping MJRefreshComponentAction) {
        
        let mTableView = tableView ?? baseTableView
        let footer = MJRefreshAutoFooter{[weak self] in
            guard let `self` = self else {return}
            self.currentPage += 1
            block()
        }
//            footer.setTitle("上拉加载", for: .idle)
//            footer.setTitle("正在加载", for: .refreshing)
//            footer.setTitle("已加载全部", for: .noMoreData)
//            footer.stateLabel?.font = UIFont.systemFont(ofSize: 14)
            
            mTableView.mj_footer = footer
    }
    /**
     更新Tableview 数据 并 结束刷新
     */
    func tableViewEndRefreshing<T:UIScrollView>(tableView: T? = nil) {
        
        let mTableView = tableView ?? baseTableView
        
        if let header = mTableView.mj_header {
            header.endRefreshing()
        }
        
        if let footer = mTableView.mj_footer {
            footer.endRefreshing()
        }
        
        if mTableView is UITableView {
            
            let tabView = mTableView as! UITableView
            
            tabView.reloadData()
        }
    }
}
