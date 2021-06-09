//
//  Keyword.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit

struct Keyword: Codable {
    var documents : [Document]
}

struct Document : Codable {
    let place_name : String
    let distance : String
    let place_url : String
    let category_name : String
    let address_name : String
    let road_address_name : String
    let id : String
    let phone : String
    let category_group_code : String
    let category_group_name : String
    let x : String
    let y : String
    
    var toDictionary : [String : Any]{
        let dict : [String : Any] = [
            "place_name":self.place_name,
            "distance":self.distance,
            "place_url":self.place_url,
            "category_name":self.category_name,
            "address_name":self.address_name,
            "road_address_name":self.road_address_name,
            "id":self.id,
            "phone":self.phone,
            "category_group_code":self.category_group_code,
            "category_group_name":self.category_group_name,
            "x":self.x,
            "y":self.y]
        
        return dict
    }
}
//
//"place_name": "카카오프렌즈 코엑스점",
//      "distance": "418",
//      "place_url": "http://place.map.kakao.com/26338954",
//      "category_name": "가정,생활 > 문구,사무용품 > 디자인문구 > 카카오프렌즈",
//      "address_name": "서울 강남구 삼성동 159",
//      "road_address_name": "서울 강남구 영동대로 513",
//      "id": "26338954",
//      "phone": "02-6002-1880",
//      "category_group_code": "",
//      "category_group_name": "",
//      "x": "127.05902969025047",
//      "y": "37.51207412593136"
