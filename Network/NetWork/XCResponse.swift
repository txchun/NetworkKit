//
//  XCResponse.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
 public class XCResponse{
    public var urlRequest:URLRequest?
    public let httpURLResponse: HTTPURLResponse?
    public weak var request: XCRequest?
    public var data: Any?
    public var error:NSError?
    public var message: String?
    public var destinationURL: URL?
    init(request: XCRequest, urlRequest: URLRequest? ,httpUrlResponse: HTTPURLResponse?) {
       self.request = request
       self.urlRequest = urlRequest
       self.httpURLResponse = httpUrlResponse
    }
    
    
    func dataDictionary() -> [String: Any]? {
        if let dataDictionary = data as? [String: Any] {
            return dataDictionary
        }
        return nil
    }
    
    func dataArray() -> [String: Any]?{
        if let dataArray = data as? [String: Any] {
            return dataArray
        }
        return nil
    }
    
    public func decode<T: Decodable>(to Model: T.Type) -> T? {
        var decodeData: Data = Data()
        do {
            if let data = self.data as? Data {
                decodeData = data;
            }
            else {
                if let data = self.data {
                    decodeData = try JSONSerialization.data(withJSONObject: data)
                }
            }
            if let target = self.request?.target {
                let data: T = try target.decoder.decode(Model.self, from: decodeData)
                return data
            }
        } catch {
            self.error = error as NSError
            debugPrint(error)
        }
        return nil
    }
}
