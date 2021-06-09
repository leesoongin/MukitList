//
//  ServiceAPIManager.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit
import Alamofire

private let REVIEW_REQUEST_URL : String = "http://54.180.8.26:8080/api/restaurant-review"
private let UPLOAD_REQUEST_URL : String = "http://54.180.8.26:8080/api/restaurant-review"
private let LIKE_REQUEST_URL : String = "http://54.180.8.26:8080/api/likeIt"

private let HEADER_KEY : String = "Authorization"

class ServiceAPIManager {
    let serviceTokenManager = ServiceAccessTokenManager.shared
    
    func loadReview(param : ReviewParameter,completion : @escaping (Reviews)->(Void)){
        let headerValue = serviceTokenManager.serviceToken
        
        AF.request(REVIEW_REQUEST_URL,method: .get, parameters: param.toDictionary,headers: [HEADER_KEY : headerValue]).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Reviews.self, from: jsonData)
                    completion(json)
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
    
    func uploadReview(param :ReviewUploadParameter, image : UIImage, completion : @escaping (Bool)->(Void)){
        let headerValue = serviceTokenManager.serviceToken

        let photoData : Data = image.jpegData(compressionQuality: 0.8)!
        
        let params : [String:Any] = ["reviewInfo":param.toDictionary]
        
        for (key,value) in params {
            print("테스트 프린팅 --> \(value) /// \(key)")
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(photoData, withName: "uploadImage", fileName: "foodReviewImage", mimeType: "image/jpeg")
            for (key,value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!,withName: key)
            }
        }, to: UPLOAD_REQUEST_URL, method: .post,headers: [HEADER_KEY:headerValue]).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
            }
        }
    }
    
    func likeRequest(params : LikeRequestParameter){
        let headerValue = serviceTokenManager.serviceToken
        print("토큰 -> \(headerValue)")
        AF.request(LIKE_REQUEST_URL, method: .post, parameters: params.toDictionary, encoding: JSONEncoding.default, headers: [HEADER_KEY:headerValue]).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: response.value!, options: .prettyPrinted)
//                    let json = try JSONDecoder().decode(ServiceAccessToken.self, from: jsonData)
                    let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
                    print("좋아요 response --> \(jsonString)")
                }catch let error {
                    print("parsing error -> \(error.localizedDescription)")
                }
            case .failure:
                print("fail , statusCode --> \(response.result)")
            }
        }
    }
}


