//
//  LikeRequestParameter.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/31.
//

import UIKit

struct LikeRequestParameter {
    var address_name : String
    var kakao_id : String
    var phone : String
    var place_name : String
    var place_url : String
    var road_address_name : String
    var longitude : String
    var latitude : String
    var reviewContent : String
    
    var toDictionary : [String : Any] {
        let dict : [String : Any] = ["address_name":self.address_name, "kakao_id":self.kakao_id,
                                     "phone":self.phone, "place_name":self.place_name,
                                     "place_url":self.place_url, "road_address_name":self.road_address_name,
                                     "longitude":self.longitude, "latitude":self.latitude,
                                     "reviewContent":self.reviewContent]
        
        return dict
    }
    
    init(){
        self.address_name = ""
        self.kakao_id = ""
        self.phone = ""
        self.place_name = ""
        self.place_url = ""
        self.road_address_name = ""
        self.longitude = ""
        self.latitude = ""
        self.reviewContent = ""
    }
    
    mutating func fetchParam(_ address_name : String,_ kakao_id : String,_ phone : String, _ place_name : String,_ place_url : String, _ road_address_name : String, _ longitude : String,_ latitude : String,_ reviewContent : String){
        self.address_name = address_name
        self.kakao_id = kakao_id
        self.phone = phone
        self.place_name = place_name
        self.place_url = place_url
        self.road_address_name = road_address_name
        self.longitude = longitude
        self.latitude = latitude
        self.reviewContent = reviewContent
    }
}
//
//"address_name": "서울 강남구 역삼동 824-29",
//   "kakao_id": "1863534623",
//   "phone": "02-6014-1245",
//   "place_name": "보슬보슬",
//   "place_url": "http://place.map.kakao.com/1863534623",
//   "road_address_name": "서울 강남구 테헤란로8길 22",
//   "longitude": "127.0316074527639",
//   "latitude": "37.49739976085793",
//   "reviewContent": "리뷰!!!"
