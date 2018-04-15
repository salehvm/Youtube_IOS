//
//  File.swift
//  Youtube
//
//  Created by Saleh Majıdov on 4/15/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
   
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) * \(numberFormatter.string(from: numberOfViews)! ) * 2 years ago"
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: option, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstarints?.constant = 44
                }
                else {
                    titleLabelHeightConstarints?.constant = 20
                }
            }
            
            
           
        }
    }
    
    func setupProfileImage() {
        
        if let profileImageUrl = video?.channel?.profileImageName {
            
            
            let url = URL(string: profileImageUrl)
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if error != nil {
                    
                    return
                }
                
                
                DispatchQueue.main.sync {
                    self.userProfileImageView.image = UIImage(data: data!)
                    
                }
                
                }.resume()
            
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {


            let url = URL(string: thumbnailImageUrl)
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if error != nil {
                    
                    return
                }
               
               
                DispatchQueue.main.sync {
                    self.thumbnailImageView.image = UIImage(data: data!)
                    
                }
                
            }.resume()
 
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "saleh2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "saleh3")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Saleh Majidov - Swift MVC"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "SalehMajidovVEVO - 1,900,000,000 views - 1 years ago"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = .gray
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var titleLabelHeightConstarints: NSLayoutConstraint?
    
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView, seperatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //top constraints
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraints
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraints
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraints
        
        titleLabelHeightConstarints = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstarints!)
        
        
        //top constraints
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraints
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraints
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraints
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
        //        addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        //        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        
        
    }
  
}

