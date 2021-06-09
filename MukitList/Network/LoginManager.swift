//
//  Login.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/08.
//

import UIKit
import Alamofire

private let requestUrl : String = "http://54.180.8.26:8080/accounts/api/login"

class LoginManager {
    
    func login(access_token : String, completion : @escaping (String) -> (Void)){
        print("accessTOken __>\(access_token)")
        let params = ["access_token" : access_token]
        
        AF.request(requestUrl, method: .post, parameters: params,encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(ServiceAccessToken.self, from: jsonData)
                    completion(json.value)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    
}
