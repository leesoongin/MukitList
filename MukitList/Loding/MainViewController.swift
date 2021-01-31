//
//  MainViewController.swift
//  MukitList
//
//  Created by 이숭인 on 2021/01/31.
//

import UIKit
import KakaoSDKAuth

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        //TODO : 만약 서비스 로그인 토큰을 확인해야 한다면 여기서 하자 ㅇㅇ
  
        if AuthApi.hasToken(){
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false, completion: nil)
        }
        sleep(1)
    }
}
