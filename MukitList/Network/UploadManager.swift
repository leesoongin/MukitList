////
////  UploadManager.swift
////  MukitList
////
////  Created by 이숭인 on 2021/03/10.
////
//
//import UIKit
//import Alamofire
//
//private let requestUrl = "http://54.180.8.26:8080/api/restaurant-review"
//private let HEADER : String = "Authorization"
//
//class UploadManager {
//    static let shared = UploadManager()
//    
//    func upload(image : UIImage, service_token : String){
//        print("업로드부분서비스 토큰 --> \(service_token)")
//        let photoData : Data = image.jpegData(compressionQuality: 0.8)!
//        
//        var info : ReviewParameter = ReviewParameter()
//        info.fetchParameters(address_name: "서울 성북구 안암동3가 9", kakao_id: "8200919", phone: "010-9073-4141", place_name: "한상차림밥상", place_url: "http://place.map.kakao.com/2108354197", road_address_name: "서울 성북구 고려대로8길 35", longitude: "127.021837311481", latitude: "37.5843412491316", reviewContent: "리뷰콘텐트 22")
//        let params : [String:Any] = ["reviewInfo":info.toDictionary]
//        
//        for (key,value) in params {
//            print("테스트 프린팅 --> \(value) /// \(key)")
//            
//        }
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(photoData, withName: "uploadImage", fileName: "testFileName1", mimeType: "image/jpeg")
//            for (key,value) in params {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!,withName: key)
//            }
//        }, to: requestUrl, method: .post,headers: [HEADER:service_token]).validate(statusCode: 200..<300).responseJSON { response in
//            print("respomse --> \(response.result)")
//        }
//
//    }
//}
