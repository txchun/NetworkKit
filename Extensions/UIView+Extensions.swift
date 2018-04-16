//
//  UIView+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

extension UIView {
    var mm_width: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.width
        }
    }
    
    var mm_heigth: CGFloat {
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.size.height
        }
    }
    
    var mm_right: CGFloat {
         return self.frame.size.width + self.frame.origin.x
    }
    
    func mm_setViewCornerRadius(_ radius: CGFloat? = nil) {
        var radius =  radius
        if radius == nil {
            radius = self.bounds.size.height*0.5
        }
        self.layer.cornerRadius = radius!
        self.layer.masksToBounds = true
        
    }
    
    func mm_setBorder(_ borderWith: CGFloat = 1, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWith
    }
    
    func mm_clearSubViews(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    
}


extension UIView {
    @discardableResult
    func mm_addTapGestureTarget(_ target: AnyObject?, action: Selector) -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        return tapGesture
    }
    
    @discardableResult
    func mm_addLongPressGesture(_ target: AnyObject?, action: Selector) -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        addGestureRecognizer(longPress)
        return longPress
    }
    
    @discardableResult
    func mm_addPanGestureTarget(_ target: AnyObject?, action: Selector) -> UIPanGestureRecognizer {
        let panGesture = UIPanGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        addGestureRecognizer(panGesture)
        return panGesture
    }
}


extension UIView {
 
}
