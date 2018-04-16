//
//  Double+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
extension Double {
    // 钱数，小数点之后保留两位有效数字
    var mm_moneyString: String {
        return String(format: "%.2f", self)
    }
}
