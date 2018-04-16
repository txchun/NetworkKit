//
//  XCPlugin.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

public protocol XCPlugin {
    /// Modify the SLRequest before sending
    ///
    /// - Parameter request: SLRequest
    func willSend(request: XCRequest)
    
    
    /// Modify the SLResponse after response
    ///
    /// - Parameter response: SLResponse
    func didReceive(response: XCResponse)
}


public extension XCPlugin {
    func willSend(request: XCRequest) {}
    func didReceive(response: XCResponse) {}
}
