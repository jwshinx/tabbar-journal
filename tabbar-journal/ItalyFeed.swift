//
//  ItalyFeed.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/1/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation

/* JWS already defined in Feed.swift
func fixJsonData (data: NSData) -> NSData {
    var dataString = String(data: data, encoding: NSUTF8StringEncoding)!
    dataString = dataString.stringByReplacingOccurrencesOfString("\\'", withString: "'")
    return dataString.dataUsingEncoding(NSUTF8StringEncoding)!
}
*/

class ItalyFeed :NSObject {
    let items: [FeedItem]
    let sourceURL: NSURL
    
    init (items newItems: [FeedItem], sourceURL newURL: NSURL) {
        print("+++> ItalyFeed init")
        self.items = newItems
        self.sourceURL = newURL
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        print("+++> ItalyFeed encodeWithCoder")
        print("+++> ItalyFeed encodeWithCoder: lets call 20x FeedItem encodeWithCoder")
        aCoder.encodeObject(self.items, forKey: "feedItems")
        aCoder.encodeObject(self.sourceURL, forKey: "feedSourceURL")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        print("+++> ItalyFeed required convenience init?")
        let storedItems = aDecoder.decodeObjectForKey("feedItems") as? [FeedItem]
        let storedURL = aDecoder.decodeObjectForKey("feedSourceURL") as? NSURL
        guard storedItems != nil && storedURL != nil  else {
            return nil
        }
        self.init(items: storedItems!, sourceURL: storedURL! )
    }
    
    convenience init? (data: NSData, sourceURL url: NSURL) {
        print("+++> ItalyFeed convenience init?")
        print("+++> ItalyFeed convenience init? lets call 20x FeedItem encodeWithCoder")
        var newItems = [FeedItem]()
        let fixedData = fixJsonData(data)
        var jsonObject: Dictionary<String, AnyObject>?
        
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(fixedData, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String,AnyObject>
        } catch {
        }
        guard let feedRoot = jsonObject else {
            return nil
        }
        guard let items = feedRoot["items"] as? Array<AnyObject>  else {
            return nil
        }
        for item in items {
            guard let itemDict = item as? Dictionary<String,AnyObject> else {
                continue
            }
            guard let media = itemDict["media"] as? Dictionary<String, AnyObject> else {
                continue
            }
            
            guard let urlString = media["m"] as? String else {
                continue
            }
            
            guard let url = NSURL(string: urlString) else {
                continue
            }
            
            let title = itemDict["title"] as? String
            newItems.append(FeedItem(title: title ?? "(no title)", imageURL: url))
        }
        self.init(items: newItems, sourceURL: url)
    }
}
