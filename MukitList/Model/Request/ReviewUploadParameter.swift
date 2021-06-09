//
//  requestReview.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/10.
//

import UIKit

struct ReviewUploadParameter {
    var address_name : String
    var kakao_id : String
    var phone : String
    var place_name : String
    var place_url : String
    var road_address_name : String
    var longitude : String
    var latitude : String
    var reviewContent : String
    
    init(address_name : String, kakao_id : String, phone : String, place_name : String, place_url : String, road_address_name : String, longitude : String, latitude : String, reviewContent : String){
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
    
    var toDictionary : [String : String] {
        let dict : [String : String] = [
                "address_name" : address_name,
                "kakao_id":kakao_id,
                "phone":phone,
                "place_name":place_name,
                "place_url":place_url,
                "road_address_name":road_address_name,
                "longitude":longitude,
                "latitude":latitude,
                "reviewContent":reviewContent]

        return dict
    }
}
