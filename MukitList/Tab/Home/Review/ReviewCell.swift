//
//  ReviewCellCollectionViewCell.swift
//  MukitList
//
//  Created by 이숭인 on 2021/03/30.
//

import UIKit
import Kingfisher

class ReviewCell : UICollectionViewCell {
    
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var content: UILabel!
    
    func configure(name : String?,content : String?, imageUrl : URL?){
        self.nickName.text = name
        self.content.text = content
        self.imageView.kf.setImage(with: imageUrl)
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        
    }
}
