//
//  Color+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0x0000FF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class var mm_randomColor:UIColor {
        let hue = CGFloat(arc4random() % 256) / 256.0
        let saturation = CGFloat(arc4random() % 128) / 256.0 + 0.5
        let brightness: CGFloat = CGFloat(arc4random() % 128) / 256.0 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    var m_image: UIImage {
        let theColor = self
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context!.setFillColor(theColor.cgColor)
        context!.fill(rect)
        let targetImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return targetImage!
    }
    
     convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }else {
            return nil
        }
    }
}
