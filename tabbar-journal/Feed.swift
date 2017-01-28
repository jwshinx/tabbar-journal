//
//  Feed.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/28/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation

func fixJsonData (data: NSData) -> NSData {
    var dataString = String(data: data, encoding: NSUTF8StringEncoding)!
    dataString = dataString.stringByReplacingOccurrencesOfString("\\'", withString: "'")
    return dataString.dataUsingEncoding(NSUTF8StringEncoding)!
    
}


class Feed {
    
    let items: [FeedItem]
    let sourceURL: NSURL
    
    init (items newItems: [FeedItem], sourceURL newURL: NSURL) {
        print("+++> Feed init: \(newURL)")
        self.items = newItems
        self.sourceURL = newURL
    }
    
    // JWS takes json data and url and processes it
    convenience init? (data: NSData, sourceURL url: NSURL) {
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
        
        print("+++> Feed convenience init: \(items.count)")
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
