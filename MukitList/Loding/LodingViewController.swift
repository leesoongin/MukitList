//
//  MainViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/01/31.
//

import UIKit
import KakaoSDKAuth
import Lottie

class LodingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Lottie AnimationView 생성
        let animationView = AnimationView(name:"LodingAnimation")
        
        view.backgroundColor =  #colorLiteral(red: 0.9384295344, green: 0.9403647184, blue: 0.7551119924, alpha: 1)
        view.addSubview(animationView)
        animationView.frame = animationView.superview!.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 2.0
        //애니메이션 재생(애니메이션 재생모드 미 설정시 1회)
        animationView.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let time = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.moveToLogin()
        }
    }
    
    func moveToLogin(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false, completion: nil)
    }
}
