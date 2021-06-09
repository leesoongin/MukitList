//
//  HomeViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/01/28.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import CoreLocation
import NMapsMap


class HomeViewController: MapViewController {

    let serviceAccessTokenManager = ServiceAccessTokenManager.shared
    let keywordViewModel = KeywordViewModel.shared
    
    @IBOutlet weak var headView: UIView!
    
    var locationManager = CLLocationManager()
    var photoData : Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !requestGPSPermission(){
            locationManager.requestAlwaysAuthorization()
        }
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            //위치정보 가져오는게 네트워킹이라 좀 느림 그래서 메인 큐에서 해야함
            self.mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: self.mapView.locationOverlay.location.lat, lng: self.mapView.locationOverlay.location.lng), zoom: 15)))
        }
    }
    
    func initViews(){
        headView.layer.cornerRadius = 10
        headView.layer.masksToBounds = true
        headView.layer.shadowOpacity = 0.4
        headView.layer.shadowOffset = CGSize(width: 0.3, height: 1.0)
        headView.layer.shadowRadius = 2.0
        headView.layer.masksToBounds = false
        
        naverMapView.showLocationButton = true
        mapView.positionMode = .compass
    }
    
    @IBAction func nearBySearch(_ sender: Any) {
        let x = mapView.locationOverlay.location.lng
        let y = mapView.locationOverlay.location.lat
        let param = KeywordParameter(query: "맛집", x: "\(x)", y: "\(y)", radius: 20000, page: 1)
        
        KakaoAPIManager().requestKeyword(param: param) { response in
            self.keywordViewModel.fetchRestaurants(keyword: response)
            DispatchQueue.main.async {
                //UI작업은 mainQueue
                self.showRestaurants(documents : self.keywordViewModel.restaurants)
            }
        }
    }
    
    func showRestaurants(documents : [Document]){
        for document in documents {
            let marker = NMFMarker(position: NMGLatLng(lat: Double(document.y)!, lng: Double(document.x)!))
            marker.iconImage = NMF_MARKER_IMAGE_BLUE
            marker.captionText = document.place_name
            marker.touchHandler = { overlay in
                //TODO : 해당 가게에 대한 리뷰리스트 띄워보자 floating panel에
                //1.  Notification center를 이용해 패널에 음식점id전송
                //2. contentViewController에서 해당 음식점id에 존재하는 리뷰리스트를 읽어와 collectionView에 뿌리기
                let storyboard = UIStoryboard(name: "Review", bundle: nil)
                let vc = storyboard.instantiateInitialViewController() as! ReviewViewController
                self.presentPanModal(vc)
                
                NotificationCenter.default.post(name: NSNotification.Name("restaurantInfo"), object: nil, userInfo: ["info":document.toDictionary])
                return true
            }
            marker.mapView = mapView
        }
    }
    
    func requestGPSPermission() -> Bool {
          switch CLLocationManager.authorizationStatus() {
          case .authorizedAlways, .authorizedWhenInUse:
            print("GPS: 권한 있음")
            return true
          case .restricted, .notDetermined:
            print("GPS: 아직 선택하지 않음")
            return false
          case .denied:
              print("GPS: 권한 없음")
            return false
          default:
              print("GPS: Default")
            return false
        }
    }
}
