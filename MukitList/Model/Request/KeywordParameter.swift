//
//  KeywordParameter.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/21.
//

import UIKit

struct KeywordParameter {
    var query : String
    var x : String
    var y : String
    var radius : Int
    var page : Int
    
    init(query : String, x : String, y : String, radius : Int, page : Int){
        self.query = query
        self.x = x
        self.y = y
        self.radius = radius
        self.page = page
    }
    
    var toDictionary : [String : Any] {
        let dict : [String : Any] = ["query":self.query,"x":self.x,"y":self.y,"radius":self.radius,"page":self.page]
        
        return dict
    }
    
}
