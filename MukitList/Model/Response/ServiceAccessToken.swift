//
//  ServiceAccessToken.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/06.
//

import UIKit

struct ServiceAccessToken : Codable{
    let key : String
    let value : String
}

class ServiceAccessTokenManager {
    static let shared = ServiceAccessTokenManager()
    
    var serviceToken : String {
        return UserDefaults.standard.value(forKey: "serviceToken") as! String
    }
    
    func setServiceToken(serviceToken : String){
        UserDefaults.standard.set(serviceToken, forKey: "serviceToken")
    }
}
