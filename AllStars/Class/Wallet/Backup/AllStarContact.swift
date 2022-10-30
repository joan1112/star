//
//  AllStarContact.swift
//  CoinBull
//
//  Created by hu Jack on 2021/9/24.
//  Copyright © 2021 Joe. All rights reserved.
//

import UIKit

enum AllStarApi{
    case starBox
    case starShop
    var name:String {
        
        var str = ""
        
        switch self {
        case .starBox:
            
            str = "0xC29d3b44cb293728DaF9b6781164b69c1aA219D5"
        case .starShop:
            str = "0x3e7630926bAD3A405f96F2A995D67F1f7EfB6348"
        }
        return str
    }
}
enum AllStarMethod{
    case getBoxPrice
    case buyBox

    var name:String {
        
        var str = ""
        
        switch self {
        case .getBoxPrice:
            
            str = "getBoxPriceAndPayToken"
        case .buyBox:
            
            str = "buyBox"

        }
        return str
    }
}
