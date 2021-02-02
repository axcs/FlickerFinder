//
//  Photos.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 27/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//

import Foundation

struct Photos: Codable {
    let photos: PhotosClass
}

struct PhotosClass: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Codable, PhotoURL {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

protocol PhotoURL {}

extension PhotoURL where Self == Photo{
    func getImagePath() -> URL?{
        var farmFix:Int = self.farm
        if (self.farm == 0){
            farmFix = 6
        }
           let path = "https://farm\(farmFix).static.flickr.com/\(self.server)/\(self.id)_\(self.secret)_q.jpg"
        return URL(string: path)
    }
}

