//
//  ViewController.swift
//  Youtube
//
//  Created by Saleh Majıdov on 4/15/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import UIKit
import Foundation

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
//    var videos: [Video] = {
//
//        var salehChannel = Channel()
//        salehChannel.name = "saleh majidov vevo 2"
//        salehChannel.profileImageName = "saleh2"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - blank space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = salehChannel
//        blankSpaceVideo.numberOfViews = 12311231
//
//        var salehMajidovVideo = Video()
//        salehMajidovVideo.title = "Saleh Majidov - Swift MVC"
//        salehMajidovVideo.thumbnailImageName = "saleh2"
//        salehMajidovVideo.channel = salehChannel
//        salehMajidovVideo.numberOfViews = 19212131211
//
//        return [blankSpaceVideo, salehMajidovVideo]
//    }()
    var videos: [Video]?
    
    func fetchVideos() {
       
        
        
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                return
            }
          
            do {
                 let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()

                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    channel.name = channelDictionary["profile_image_name"] as? String
                   
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
                
                
            }
            
            catch let jsonError {
                print(jsonError)
            }
           
           
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Home"
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellid")
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        collectionView?.backgroundColor = .white

        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        
        let searchBatButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBatButtonItem]
    }
    let settingsLauncher = SettingsLauncher()
    
    @objc func handleMore() {
        // show menu
        
        settingsLauncher.showSetting()
    }
    
    @objc func handleSearch() {
        
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
        
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
        return videos?.count ?? 0
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}



