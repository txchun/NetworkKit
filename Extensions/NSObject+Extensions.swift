//
//  NSObject+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/3/3.
//  Copyright © 2018年 yihong. All rights reserved.
//

import Foundation
extension NSObject {
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return String(describing: self)
    }
    
}
