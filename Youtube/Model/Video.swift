//
//  Video.swift
//  Youtube
//
//  Created by Saleh Majıdov on 4/15/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSData?
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
}
