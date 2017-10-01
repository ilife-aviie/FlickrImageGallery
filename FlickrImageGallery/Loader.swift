//
//  Loader.swift
//  FlickrImageGallery
//
//  Created by Avie on 01/10/17.
//  Copyright © 2017 xyz. All rights reserved.
//

import Foundation

struct FeedData {
    var imageUrl: String
    var title: String
    
    static var feedURL = "https://api.flickr.com/services/feeds/photos_public.gne"
}

class Loader {
    
    func loadFeeds(completion: @escaping ([FeedData]) -> Void) {
        Network().fetch(url: FeedData.feedURL, completion: { data in
            if let data = data {
                    Parser(parser: XMLParser(data: data)).parse(completion: { feeds in
                        completion(feeds)
                    })
            } else {
                print("Unable to fetch feeds. Fatal error.")
            }
        })
    }
}
