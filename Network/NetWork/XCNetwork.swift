//
//  XCNetwork.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import EVReflection
private let XCNetworkResponseQueue: String = "com.XCNetwork.ResponseQueue"
private let XCNetworkFolderPath: String             = "XCNetwork"
private let XCNetworkDestinationFolderPath: String  = "Destination"
private let XCNetworkResumeFolderPath: String       = "Resume"
private let XCNetworkTempFileNameKey: String        = "NSURLSessionResumeInfoTempFileName"
private let XCNetworkTempFileDataCountKey: String   = "NSURLSessionResumeBytesReceived"
private let XCNetworkTempFilePathKey: String        = "NSURLSessionResumeInfoLocalPath"//iOS8 emulator resumeTempFilePath
public class XCNetwork {
    public typealias ProgressClosure = (XCProgress) -> Void
    public typealias CompletionClosure = (_ data: Any) -> Void
    public var target: XCTarget
    public let sessionManager: SessionManager
    public var serverTrustPolicyManager: ServerTrustPolicyManager?
    public lazy var responseQueue = {
        return DispatchQueue(label: XCNetworkResponseQueue)
    }()
    
    private lazy var reachabilityManager: NetworkReachabilityManager? = {
        let reachabilityManager = NetworkReachabilityManager(host: self.target.host)
        return reachabilityManager
    }()
    
    private lazy var XCNetworkFolderURL: URL = { return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(XCNetworkFolderPath) }()
    private lazy var XCNetworkDestinationFolderURL: URL = { return XCNetworkFolderURL.appendingPathComponent(XCNetworkDestinationFolderPath) }()
    private lazy var XCNetworkResumeFolderURL: URL = { return XCNetworkFolderURL.appendingPathComponent(XCNetworkResumeFolderPath) }()
    private lazy var XCNetworkTempFolderPath: String = { return NSTemporaryDirectory() }()
    
    public init(_ target: XCTarget) {
        self.target = target
        let configuration = target.configuration
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        var policyManager: ServerTrustPolicyManager?
        if let policies = target.policies {
            policyManager = ServerTrustPolicyManager(policies: policies)
            self.serverTrustPolicyManager = policyManager
        }
        self.sessionManager = SessionManager(configuration: configuration, serverTrustPolicyManager:policyManager)
        if let reachability = target.reachability {
            self.reachabilityManager?.listener = reachability
            self.reachabilityManager?.startListening()
        }
    }

}

// MARK: 请求网络数据
extension XCNetwork {
    public func request(_ request: XCRequest,completionClosure: @escaping CompletionClosure){
         request.target = target
        let  dataRequest = sessionManager.request(getUrl(url: request.URLString), method: request.method, parameters: request.parameters, encoding: request.paremeterEncoding!, headers: request.headers)
        if let credential = request.credential {
            dataRequest.authenticate(usingCredential: credential)
        }
        
        dataRequest.responseData(queue: target.responseQueue ?? responseQueue) { [weak self] (originalResponse) in
              guard let strongSelf = self else { return }
              strongSelf.dealResponseData(request: request, originalResponse: originalResponse, completionClosure: completionClosure)
        }
    }
}

// MARK:自定义参数加密参
extension XCNetwork {
    private func getUrl(url:String) -> String{
        return "\(url)/?format=json&" + getApiTokenQueryParamsString()
    }
    
    private func getApiTokenQueryParamsString() -> String{
        let (token,nonce) = getToken()
        return "token=\(token)&nonce=\(nonce)"
    }
    
    private func getToken() -> (String, String) {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let md5 = "\(timestamp)\(getK())".md5()
        return (md5,String(timestamp))
    }
    
   
    private func getK() -> String{
        return "5xkG(9&x1@;4xpj455dfsbfq_xxxx-z_9mu*9r(p=-n(";
    }
}


// MARK: 处理请求结果
extension XCNetwork {
    
    func dealResponseData(request: XCRequest, originalResponse:DataResponse<Data> ,completionClosure: @escaping CompletionClosure){
        let respons = XCResponse(request: request, urlRequest: originalResponse.request, httpUrlResponse: originalResponse.response)
        switch originalResponse.result {
        case .failure(let error):
            respons.error = error as NSError
        case .success(let data):
            respons.data  = data
        if let _ = respons.data {
            toJsonObject(response: respons)
         }
        DispatchQueue.global().async {
            completionClosure(respons.data!)
        }}
    }
    
    private func toJsonObject(response: XCResponse) {
        var tempData: Data?
        if let string = response.data as? String {
            tempData = string.data(using: .utf8)
        }
        else if let data = response.data as? Data {
            tempData = data
        }
        if let data = tempData, data.count > 0 {
            do {
                response.data = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            }
            catch {
                response.error = error as NSError
            }
        }
    }
    
}
