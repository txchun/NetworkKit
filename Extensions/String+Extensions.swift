//
//  String+Extensions.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/3/1.
//  Copyright © 2018年 yihong. All rights reserved.
//

import Foundation
enum JudgeIllegelType{
    case success
    case failed(String)
}


extension String {
    var mm_length: Int {
        return self.count
    }
    
    var  mm_trimed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var jx_trimedBlank: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /**
     计算字符串字节数，一个汉字算两个字符
     
     - returns: 字节长度
     */
    var mm_byteCount: Int {
        var byteCount = 0
        for i in 0..<self.mm_length {
            let a = (self as NSString).substring(with: NSRange.init(location: i, length: 1))
            if a.lengthOfBytes(using: String.Encoding.utf8) != 1 {
                byteCount += 2
            } else {
                byteCount += 1
            }
        }
        return byteCount
    }
    
    func mm_substring(_ location: Int, length: Int) -> String {
        
        guard location + length <= self.count else { return "" }
        
        let start = self.index(self.startIndex, offsetBy: location)
        let end = self.index(self.startIndex, offsetBy: location + length)
        return String(self[start..<end])
    }
    
    
}

extension String {
    var isPhoneNumberValid: Bool {
        if self.count != 11 {
            return false
        }
        if !self.hasPrefix(""){
            return false
        }
        return true
    }
    
}

extension String {
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
//        result.deinitialize()
        return String(format: hash as String)
    }
}
