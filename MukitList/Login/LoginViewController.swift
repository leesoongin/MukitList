//
//  LoginViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/01/28.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loginViewContoller 나옴")
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    @IBAction func login(_ sender: Any) {
        AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                //TODO: 서버로 id 등 데이터 전송
                //TODO: Master로 이동
                self.moveToMainController()
                print("tlfgod")
            }
        }
    }
   
    func moveToMainController() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}
