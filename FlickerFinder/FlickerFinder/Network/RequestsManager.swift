//
//  NetworkClass.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 30/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//


import Foundation
import Alamofire

class RequestsManager: NSObject {

    static func getPhotos(search: String, startIndex:Int, completion:@escaping (Photos?)->Void) {
        let index = String(startIndex)
        AF.request(APIRouter.getPhotos(search: search, startIndex: index)).responseDecodable(of: Photos.self) { (response) in
                completion(response.value)
            }
        }
        
    static func getSizes(photoId:String, completion:@escaping (Sizes?)->Void) {
        AF.request(APIRouter.getSizes(id: photoId)).responseDecodable(of: Sizes.self) { (response) in
            completion(response.value)
        }
    }
    
}







