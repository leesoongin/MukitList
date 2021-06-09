//
//  UploadViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit
import YPImagePicker

class UploadViewController: UIViewController {

    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var config = YPImagePickerConfiguration()
    var restaurantInfo : [String: String] = [String: String]()
    
    var testImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        initViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeNotification()
    }
    
    func initViews(){
        textView.delegate = self
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(getRestaurantInfo(notification:)), name: NSNotification.Name("reviewParamInfo"), object: nil)
    }
    func removeNotification(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("reviewParamInfo"), object: nil)
    }
    
    @objc func getRestaurantInfo(notification : Notification){
        let info = notification.userInfo!["info"] as! [String : String]
        self.restaurantInfo = info
        print("restuarntInfo --> \(self.restaurantInfo)")
        
    }
    @IBAction func tabGesture(_ sender: Any) {
        textView.resignFirstResponder()
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        config.library.maxNumberOfItems = 3
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
                return
            }
            if let photo = items.singlePhoto {
                self.testImage = photo.image
                self.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func uploadReview(_ sender: Any) {
        let param = ReviewUploadParameter(address_name: restaurantInfo["address_name"]!, kakao_id: restaurantInfo["id"]!, phone: restaurantInfo["phone"]!, place_name: restaurantInfo["place_name"]!, place_url: restaurantInfo["place_url"]!, road_address_name: restaurantInfo["road_address_name"]!, longitude: restaurantInfo["x"]!, latitude: restaurantInfo["y"]!, reviewContent: textView.text)
        
        ServiceAPIManager().uploadReview(param: param, image: testImage) { response in
            //TODO : response true or false여부에 따라 성공,실패 alert띄우기
            if response {
                //성공 alert -> dismiss
                self.uploadResultAlert(isComplete: response)
            }else{
                //실패 alert
                self.uploadResultAlert(isComplete: response)
            }
        }
    }
    
    func uploadResultAlert(isComplete : Bool){
        let alert : UIAlertController?
        
        if isComplete {
            alert = UIAlertController(title: "업로드", message: "업로드 완료",     preferredStyle: UIAlertController.Style.alert)
        }else{
            alert = UIAlertController(title: "업로드", message: "업로드 실패",     preferredStyle: UIAlertController.Style.alert)
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert!.addAction(okAction)
        
        present(alert!, animated: false, completion: nil)
    }
}

//MARK: - textView Delegate
extension UploadViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        //올리고
        self.view.frame.origin.y -= 120
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // 내리고 하면될듯?
        self.view.frame.origin.y = 0
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
     
        return changedText.count <= 300
    }
}
