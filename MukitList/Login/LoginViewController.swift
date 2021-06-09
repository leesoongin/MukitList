//
//  LoginViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/01/28.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import Lottie

class LoginViewController: UIViewController {
    let loginManager = LoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name:"LogoAnimation")
        
        view.backgroundColor =  #colorLiteral(red: 0.9384295344, green: 0.9403647184, blue: 0.7551119924, alpha: 1)
        view.addSubview(animationView)
        animationView.frame = CGRect(x: 0, y: 0, width: 250, height: 250) // 애니메이션뷰의 크기 설정
        animationView.center = self.view.center // 애니메이션뷰의 위치설정
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.0
        animationView.loopMode = .loop
        //애니메이션 재생(애니메이션 재생모드 미 설정시 1회)
        animationView.play()
    }
    
    @IBAction func login(_ sender: Any) {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                self.loginManager.login(access_token: oauthToken!.accessToken) { response in
                    print("response --> \(response)")
                    ServiceAccessTokenManager().setServiceToken(serviceToken: response)
                }
                self.moveToMainController()
            }
        }
    }
  
    
    func moveToMainController() {
        let storyboard = UIStoryboard(name: "Master", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}
