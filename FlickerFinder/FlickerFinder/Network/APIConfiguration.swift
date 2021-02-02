//
//  APIConfiguration.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 30/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
}
