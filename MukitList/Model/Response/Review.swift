//
//  Review.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit

struct Reviews : Codable {
    var data : [Review]
}

struct Review : Codable {
    var nickName : String
    var reviewContent : String
    var imageUrl : String
}
