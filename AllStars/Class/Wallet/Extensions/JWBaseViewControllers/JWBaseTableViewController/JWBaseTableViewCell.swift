//
//  JWBaseTableViewCell.swift
//  CoinBull
//
//  Created by WuQiaoqiao on 2020/5/18.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit

class JWBaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .white
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        };
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData<T>(model:T) {
        
      
        
    }

    func addShadow(toView theView:UIView, withColor theColor:UIColor) {
           // 阴影颜色
           theView.layer.shadowColor = theColor.cgColor;
           // 阴影偏移，默认(0, -3)
           theView.layer.shadowOffset = CGSize(width: 0, height: 0)
           // 阴影透明度，默认0
           theView.layer.shadowOpacity = 0.12;
           // 阴影半径，默认3
           theView.layer.shadowRadius = 2;
       }
}
