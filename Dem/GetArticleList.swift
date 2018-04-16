//
//  GetArticleList.swift
//  MagicMirror
//
//  Created by 田小椿 on 2018/4/10.
//  Copyright © 2018年 yihong. All rights reserved.
//

import UIKit
import EVReflection
class GetArticleList: XCRequest {
    init(page: Int? , page_size: Int?) {
        super.init()
        self.paremeterEncoding = URLEncoding.default
        self.method = HTTPMethod.get
        self.URLString = articles
        self.parameters = [
            "page" : page as  AnyObject,
            "page_size" : page_size as AnyObject,
            "is_index"  : "1" as AnyObject
        ]
    }
}

final class  ArticlesModle: BaseModel {
    var count = ""
    var next = ""
    var previous = ""
    var results:[ArticlesBaseModle] = []
    
}


final class  ArticlesBaseModle: EVObject {
    var channel: ChannelItem?
    var channel_id = ""
    var clicks = ""
    var comments = ""
    var content_url = ""
    var country = ""
    var cover_url = ""
    var created = ""
    var id = ""
    var info_type = ""
    var is_fav = ""
    var large_url = ""
    var likes = ""
    var publish_date = ""
    var school = ""
    var simple_content_url = ""
    var summary = ""
    var timeline_id = ""
    var timeline_type = ""
    var title = ""
    var type = ""
    var un_likes = ""
    var author_id = ""
    var author = Author()
}


final class  Author: EVObject {
    var avatar = ""
    var created_at = ""
    var id = ""
    var intro = ""
    var name = ""
    var updated_at = ""
    var website = ""
    var avatar_url = ""
    var large_url = ""
}

final class ChannelItem: EVObject {
    var enable:Bool = false
    var id = ""
    var name = ""
    var sort = ""

}

