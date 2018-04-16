//
//  XCRequest.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
import EVReflection
open class XCRequest {
    init() {}
    //私有属性
    private var storeMethod: HTTPMethod?
    private var storeURLString: String?
    private var storeParameters: Parameters?
    private var storeParameterEncoding: ParameterEncoding?
    private var storeTarget: XCTarget?
    public var path: String?
    public var dataKeyPath: String?
    public var headers: [String: String]?
    public var credential: URLCredential?
    public var method: HTTPMethod {
        get {
            return storeMethod ?? .get
        }
        set {
            storeMethod = newValue
        }
    }
    public var URLString: String {
        get {
            return  OtherApi + storeURLString!
        }
        set {
            storeURLString = newValue
        }
    }
    
    public var parameters: Parameters? {
        get {
            if let parameters = storeParameters {
                return parameters
            }
            return nil
        }
        set {
            storeParameters = newValue
        }
    }
    
    
    public var paremeterEncoding: ParameterEncoding?{
        get {
            return storeParameterEncoding ?? URLEncoding.default
        }
        set {
            storeParameterEncoding = newValue
        }
    }
    
    public var basicAuthentication: (user: String, password: String)? {
        get {
            return nil
        }
        set {
            if let user = newValue?.user, let password = newValue?.password {
                if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
                    if headers == nil {
                        headers = [authorizationHeader.key : authorizationHeader.value]
                    }
                    else {
                        headers![authorizationHeader.key] = authorizationHeader.value
                    }
                }
            }
        }
    }
    
    
    public var target: XCTarget? {
        get {
            return storeTarget
        }
        set {
            storeTarget = newValue
        }
    }
}


extension XCRequest: CustomDebugStringConvertible {
    public var debugDescription: String {
        return """
        ------------------------ XCRequest -----------------------
        URL:\(URLString)
        headers:\(String(describing: headers))
        parameters:\(String(describing: parameters))
        ------------------------ XCRequest -----------------------
        """
    }
}


