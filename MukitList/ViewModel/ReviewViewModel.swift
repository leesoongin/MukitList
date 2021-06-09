//
//  ReviewViewModel.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/30.
//

import UIKit

class ReviewViewModel {
    static let shared = ReviewViewModel()
    
    var reviews : [Review] = [Review]()
    
    func addReview(review : Review){
        self.reviews.append(review)
    }
    
    func clearReview(){
        self.reviews.removeAll()
    }
    
}
