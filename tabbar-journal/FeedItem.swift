//
//  FeedItem.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/28/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation

class FeedItem: NSObject, NSCoding {
    let title: String
    let imageURL: NSURL
    
    init (title: String, imageURL: NSURL) {
        self.title = title
        self.imageURL = imageURL
        super.init()
    }

    func encodeWithCoder(aCoder: NSCoder) {
        // print("+++> FeedItem encodeWithCoder")
        aCoder.encodeObject(self.title, forKey: "itemTitle")
        aCoder.encodeObject(self.imageURL, forKey: "itemURL")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // print("+++> FeedItem required convenience init?")
        let storedTitle = aDecoder.decodeObjectForKey("itemTitle") as? String
        let storedURL = aDecoder.decodeObjectForKey("itemURL") as? NSURL
        
        guard storedTitle != nil && storedURL != nil else {
            return nil
        }
        self.init(title: storedTitle!, imageURL: storedURL!)
    }

}
