//
//  XCUploadRequest.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/9.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit

open class XCUploadRequest: XCRequest {
    public typealias MultipartFormDataClosure = (MultipartFormData) ->Void
    //文件类型
    var mimeType :String?
    //服务器接收参数名
    var name:String?
     // 文件名
    var fileName:String?
    //文件数据
    public var data: Data?
    /// uploading the `file`.
    public var filePath: String?
    // 上传inputStream`.
    public var inputStream: (intputStream: InputStream, length: Int)?
    public var encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold
    //multipartFormData
    init(imageData: NSData,name: String,fileName:String?,mimeType:String = "image/jpeg",addTimeToFileName: Bool = false) {
        self.data = imageData as Data
        self.name = name
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: NSDate() as Date)
        if let fn = fileName {
            if addTimeToFileName {
                self.fileName = dateString + "_" + fn
            } else {
                self.fileName = fn
            }
        } else {
            self.fileName = dateString + ".png"
        }
        
        self.mimeType = mimeType
    }
    //InputStream
    init(inputStream:(intputStream: InputStream, length: Int)?) {
        self.inputStream = inputStream
    }
    //Data
    init(filePath: String?,data: Data?) {
        self.filePath = filePath
        self.data = data
    }
}


extension XCNetwork {
    // MARK: multipartFormData 上传
    func uploadMultipartFromData(request: XCUploadRequest,completionClosure:@escaping CompletionClosure) {
        sessionManager.upload(multipartFormData: { (multipartFormData) in
            if let param = request.parameters {
                for (key, value) in param {
                    multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName:key)
                    }
                multipartFormData.append(request.data! , withName: request.name!, fileName: request.fileName! , mimeType: request.mimeType!)
            }
        }, usingThreshold: request.encodingMemoryThreshold, to: request.URLString, method: request.method, headers: request.headers) { [weak self] (encodingResult) in
            guard let strongSelf = self else {return}
            switch encodingResult {
            case .success(let uploadRequest, _, _):
                strongSelf.uploadResponse(with: request, uploadRequest: uploadRequest, completionClosure: completionClosure)
                break
            case .failure(let error):
                let response =  XCResponse(request: request, urlRequest: nil, httpUrlResponse: nil)
                response.error = error as NSError
                completionClosure(response)
            }
        }
    }
    
    // MARK: InputStream
    func updataInputStream(request: XCUploadRequest) {
        if let intputStream = request.inputStream {
            if request.headers == nil {
                request.headers = ["Content-Length" : "\(intputStream.length)"]
            }
            else {
                request.headers!["Content-Length"] = "\(intputStream.length)"
            }
            sessionManager.upload(intputStream.intputStream, to: request.URLString, method: request.method, headers:request.headers)
        }
        
    }
    
    // MARK: Data
    func updateData(request: XCUploadRequest,completionClosure:@escaping CompletionClosure) {
        var uploadRequest: UploadRequest
        if let filePath = request.filePath, let fileURL = URL(string: filePath) {
            uploadRequest = sessionManager.upload(fileURL,
                                                  to: request.URLString,
                                                  method: request.method,
                                                  headers: request.headers)
        }else if let data = request.data {
            uploadRequest = sessionManager.upload(data,
                                                  to: request.URLString,
                                                  method: request.method,
                                                  headers: request.headers)
        }else {
            return
        }
        uploadResponse(with: request, uploadRequest: uploadRequest, completionClosure: completionClosure)
    }
    
}


// MARK:上传结果处理
extension XCNetwork {
    private func uploadResponse(with request:XCRequest, uploadRequest: UploadRequest, progressClosure: ProgressClosure? = nil,  completionClosure: @escaping CompletionClosure) {
        if let credential = request.credential {
            uploadRequest.authenticate(usingCredential: credential)
        }
        var progress: XCProgress?
        if let _ = progressClosure {
            progress = XCProgress(request: request)
        }
        uploadRequest.uploadProgress(closure: { (originalProgress) in
            if let progressClosure = progressClosure, let progress = progress {
                progress.originalProgress = originalProgress
                debugPrint(progress)
                progressClosure(progress)
            }
        })
        uploadRequest.responseData(queue: target.responseQueue ?? responseQueue) { [weak self] (originalResponse) in
            guard let strongSelf = self else { return}
            strongSelf.dealResponseData(request: request, originalResponse: originalResponse, completionClosure: completionClosure)
        }
        
    }
}
