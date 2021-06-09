//
//  ReviewViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit
import PanModal

class ReviewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    var reviewParamInfo : [String:String]!
    
    let reviewViewModel = ReviewViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeNotification()
        reviewViewModel.clearReview()
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(getRestaurantInfo(notification:)), name: NSNotification.Name("restaurantInfo"), object: nil)
    }
    
    func removeNotification(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("restaurantInfo"), object: nil)
    }
    
    @objc func getRestaurantInfo(notification : Notification){
        //여기서 레스토랑의 리뷰정보 불러오자
        let info = notification.userInfo!["info"] as! [String:String]
        print("info --> \(info)")
        self.reviewParamInfo = info
        restaurantNameLabel.text = info["place_name"]
        let param = ReviewParameter(kakaoId: info["id"]!)
        
        ServiceAPIManager().loadReview(param: param) { response in
            self.reviewViewModel.clearReview()
            
            for item in response.data {
                self.reviewViewModel.addReview(review: item)
            }
            self.collectionView.reloadData()
        }
    }
    
    func initViews(){
        headView.layer.cornerRadius = 10
        headView.layer.masksToBounds = true
        headView.layer.shadowOpacity = 0.4
        headView.layer.shadowOffset = CGSize(width: 0.3, height: 1.0)
        headView.layer.shadowRadius = 2.0
        headView.layer.masksToBounds = false
        
    }
    
    @IBAction func like(_ sender: Any) {
        print("like눌림")
        var params = LikeRequestParameter()
        params.fetchParam("서울 강남구 역삼동 824-29", "1863534623", "02-6014-1245", "보슬보슬", "http://place.map.kakao.com/1863534623", "서울 강남구 테헤란로8길 22", "127.0316074527639", "37.49739976085793", "리뷰!")
        ServiceAPIManager().likeRequest(params: params)
    }
    
    @IBAction func moveToUploadView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Upload", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false) {
            NotificationCenter.default.post(name: NSNotification.Name("reviewParamInfo"), object: nil, userInfo: ["info":self.reviewParamInfo])
        }        
    }
    
}

extension ReviewViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return reviewViewModel.reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCell else {
            return UICollectionViewCell()
        }
        
        let url = URL(string: reviewViewModel.reviews[indexPath.row].imageUrl)
        
        cell.configure(name: reviewViewModel.reviews[indexPath.row].nickName, content: reviewViewModel.reviews[indexPath.row].reviewContent,imageUrl: url)
        
        
        
        return cell
    }
    //delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    //flowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing : CGFloat = 16
        let margin : CGFloat = 16
        let width : CGFloat = (collectionView.bounds.width-itemSpacing - margin*2)
        let height : CGFloat = width + 120
        print("width -> \(width), heifght --> \(height)")
        return CGSize(width: width, height: height)
    }
}

//MARK: - panModal Presentable
extension ReviewViewController : PanModalPresentable {
    var panScrollable: UIScrollView? {
            return nil
        }
    
    // 접힌 상태
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    //펼쳐진 상태
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    //true -> 최상단까지 펼쳐지지 않음 , false -> 최상단까지 펼쳐짐
    var anchorModalToLongForm: Bool {
        return false
    }
}
