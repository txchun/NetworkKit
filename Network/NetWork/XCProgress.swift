//
//  XCProgress.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
 public class XCProgress {
    public weak var request: XCRequest?
    public var originalProgress: Progress?
    public var currentProgress: Double {
          return originalProgress?.fractionCompleted ?? 0
    }
    
    /// The Request's progress: 0% - 100%
    public var currentProgressString: String {
        if let fractionCompleted = originalProgress?.fractionCompleted {
            return String(format: "%.0lf%%", fractionCompleted * 100)
        }
        return ""
    }
    
    init(request: XCRequest) {
        self.request = request
    }
}

extension XCProgress: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """
        ------------------------ XCProgress ----------------------
        URL:\(request?.URLString ?? "")
        Progress:\(currentProgressString)
        ------------------------ XCProgress ----------------------
        
        """
    }
}
