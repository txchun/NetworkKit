//
//  XCDownLoadRequest.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

 open class XCDownLoadRequest: XCRequest {
    private var isResume: Bool = false
    internal var hasResume: Bool = false
    public var destinationURL: URL?
    public var downloadOptions: DownloadOptions = [.removePreviousFile, .createIntermediateDirectories]
    
}
