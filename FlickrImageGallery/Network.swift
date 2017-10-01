//
//  Network.swift
//  FlickrImageGallery
//
//  Created by Avie on 01/10/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation
import Alamofire

class Network {
    
    func fetch(url: String, completion: @escaping (Data?) -> Void) {
        Alamofire.request(url).response { response in
            completion(response.data)
        }
    }
}
