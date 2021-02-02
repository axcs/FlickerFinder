//
//  APIRouter.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 30/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    case getPhotos(search:String,startIndex:String)
    case getSizes(id:String)
    
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        case .getSizes:
            return .get
        }
    }
    // MARK: - Parameters
    var parameters: RequestParams {
        let apikey = Constants.ProductionServer.flickrKey
        switch self {
        case .getPhotos(let search, let startIndex):
            return .url(["method": "flickr.photos.search", "api_key": apikey,"tags":search,"page":startIndex, "format":  "json", "nojsoncallback":"1"])
        case .getSizes(let id):
             return .url(["method": "flickr.photos.getSizes", "api_key": apikey,"photo_id":id, "format":  "json", "nojsoncallback":"1"])
        }
    }
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        switch parameters {
            
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
             
        case .url(let params):
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string:url.absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
}


