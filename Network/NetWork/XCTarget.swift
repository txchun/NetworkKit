//
//  XCTarget.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

public protocol  XCTarget {
    /// The target's baseURLString.
    var baseURLString: String { get }
    /// The target's URLSessionConfiguration.
    var configuration: URLSessionConfiguration { get }
    
    /// The target's serverTrustPolicies
    var policies: [String : ServerTrustPolicy]? { get }
    
    /// The target's ResponseQueue
    var responseQueue: DispatchQueue? { get }
    
    /// The target's Plugins
  //  var plugins: [SLPlugin]? { get }
    
    /// The target's Reachability
    var reachability: Listener? { get }
    
    /// The target's Host.
    var host: String { get }
    
    /// The target's Response Status
    var status: (codeKey: String, successCode: Int, messageKey: String?, dataKeyPath: String?)? { get }
    
    /// The target's Response JSONDecoder
    var decoder: JSONDecoder { get }
}

public extension XCTarget {
    
    
    var configuration: URLSessionConfiguration { return URLSessionConfiguration.default }
    var policies: [String : ServerTrustPolicy]? { return nil }
    
    var responseQueue: DispatchQueue? { return nil }
    var reachability: Listener? { return nil }
    
    var host: String {
        if let URL = URL(string: baseURLString), let host = URL.host {
            return host
        }
        return ""
    }
    
    var status: (codeKey: String, successCode: Int, messageKey: String?, dataKeyPath: String?)? { return nil }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
