//
//  KakaoAPIManager.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit
import Alamofire

private let keywordRequestURL : String = "https://dapi.kakao.com/v2/local/search/keyword.json"
private let HEADER_KEY : String = "Authorization"
private let HEADER_VALUE : String = "KakaoAK 4d27640b59df7c07ae902a2cb443aad6"

class KakaoAPIManager {
    func requestKeyword(param : KeywordParameter,completion : @escaping (Keyword)->(Void)){
        
        AF.request(keywordRequestURL,method: .get, parameters: param.toDictionary,headers: [HEADER_KEY : HEADER_VALUE]).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Keyword.self, from: jsonData)
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}

