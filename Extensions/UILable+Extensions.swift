//
//  UILable+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

extension UILabel {
    /**
     * 计算字符串长度
     */
    func sizeWithText(text: String, font: UIFont, size: CGSize) -> CGRect {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = NSString(string: text).boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect
    }
}
