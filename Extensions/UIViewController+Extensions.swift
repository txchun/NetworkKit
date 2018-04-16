//
//  UIViewController+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/2/28.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

extension UIViewController {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func createDefaultNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        configNavigationController(navigationController)
        navigationController.pushViewController(self, animated: false)
        return navigationController
    }
    
    func configNavigationController(_ navigationController: UINavigationController) {
//        navigationController.navigationBar.isTranslucent = false
//        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: mainSoftwareColor]
//        navigationController.navigationBar.tintColor = subSoftwareColor
//        navigationController.navigationBar.barTintColor = .white
//        navigationController.view.backgroundColor = UIColor.white
//        navigationController.navigationBar.setBackgroundImage(UIColor.clear.jx_image, for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
//        navigationController.navigationBar.shadowImage = UIImage(named: "qq_navdivide")
    }
}
