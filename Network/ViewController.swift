//
//  ViewController.swift
//  Network
//
//  Created by 田小椿 on 2018/4/11.
//  Copyright © 2018年 com.Network.tx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestdata()
    }
    //请求数据
    func requestdata()  {
        httpKit.request(GetArticleList(page: 1, page_size: 4)) { (data) in
            print(data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

