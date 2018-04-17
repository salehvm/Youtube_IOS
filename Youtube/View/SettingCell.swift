//
//  SettingCell.swift
//  Youtube
//
//  Created by Saleh Majıdov on 4/17/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconimageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconimageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconimageView.tintColor = UIColor.darkGray
            }
            
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
       
        addSubview(nameLabel)
        addSubview(iconimageView)
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconimageView,nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconimageView)
        
        
        addConstraint(NSLayoutConstraint(item: iconimageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
