//
//  UIImage+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
import Foundation
extension UIImage {
    //:return Base65 String
    public var base64: String {
        return (UIImageJPEGRepresentation(self , 1.0)?.base64EncodedString())!
    }
    
    //:return compressImage rate
    public func compressImage(rate: CGFloat) ->Data? {
       return UIImageJPEGRepresentation(self, rate)
    }
    
    //retrn: image size in bytes
    public func getSizeAsBytes() -> Int {
        return UIImageJPEGRepresentation(self, 1)?.count ?? 0
    }
    
    //return height:compress width with heigth
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    //return width:compress width with heigth
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    //change image size
    func mm_scaledImage(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func mm_scaleImageWithoutCliped(to maxSize: CGSize) -> UIImage? {
        guard maxSize != CGSize.zero else { return nil }
        let widthScale = maxSize.width / size.width
        let heightScale = maxSize.height / size.height
        let targetScale = min(widthScale, heightScale)
        if widthScale > 1 && heightScale > 1 { return self }
        let displaySize = CGSize(width: ceil(size.width * targetScale), height: ceil(size.height * targetScale))
        return mm_scaledImage(to: displaySize)
        
    }
}
