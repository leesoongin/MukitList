//
//  ReviewParameter.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit

struct ReviewParameter {
    var kakaoId : String
    
    init(kakaoId : String){
        self.kakaoId = kakaoId
    }
    
    var toDictionary : [String:Any] {
        let dict = ["restaurantKakaoId":self.kakaoId]
        
        return dict
    }
}
