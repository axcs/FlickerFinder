//
//  ExString.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 27/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//

import Foundation

protocol SearchTextSpaceRemover{}

extension String: SearchTextSpaceRemover {
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension SearchTextSpaceRemover where Self == String {
    
    //MARK: - Removing space from String
    var removeSpace: String {
        if self.isNotEmpty {
           return self.components(separatedBy: .whitespaces).joined()
        }else{
           return ""
        }
    }
}
