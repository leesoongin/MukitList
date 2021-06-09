//
//  KeywordViewModel.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit

class KeywordViewModel {
    static let shared = KeywordViewModel()
    
    var restaurants = [Document]()
    
    func fetchRestaurants(keyword : Keyword){
        for document in keyword.documents {
            self.restaurants.append(document)
        }
    }
}
