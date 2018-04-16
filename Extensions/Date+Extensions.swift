//
//  Date+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
enum mmDateFormat {
    static let standard = "yyyy-MM-dd HH:mm:ss"
    static let simple = "yyyy-MM-dd"
}

extension Date {
    func mm_toString( format: String = mmDateFormat.standard) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        df.locale = Locale(identifier: "zh_CN")
        let timeStr = df.string(from: self)
        return timeStr
    }
}
