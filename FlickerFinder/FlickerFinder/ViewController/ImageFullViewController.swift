//
//  ImageFullViewController.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 27/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//

import UIKit

class ImageFullViewController: UIViewController {
    
    //MARK: - IBOutlet Section
    @IBOutlet weak var imgFull: UIImageView!
    
    //MARK: - var Section
    var imageId: String!
    
    
    override func viewDidLoad() {
        self.title = "Full Photo"
        super.viewDidLoad()
        executeService()
    }
    
    //MARK: - Func Section
    func executeService(){
        RequestsManager.getSizes(photoId: imageId) { result in
            if result != nil {
                
                for sizeObj in (result?.sizes.sizeArray) ?? [] {
                    if  (sizeObj.label == "Large"){
                        self.imgFull.af.setImage(withURL: URL(string: sizeObj.source)!)
                    }
                }
            }
        }
    }
    
}
