//
//  DataController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/1/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let managedObjectContext: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        print("+++> DCntrlr init")
        self.managedObjectContext = moc
    }
    
    convenience init?() {
        print("+++> DCntrlr convenience init?")
        guard let modelURL = NSBundle.mainBundle().URLForResource("DataModel", withExtension: "momd") else {
            return nil
        }
        print("+++> DCntrlr convenience init? modelURL: \(modelURL)")
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            return nil
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let persistantStoreFileURL = urls[0].URLByAppendingPathComponent("Bookmarks.sqlite")
        
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistantStoreFileURL, options: nil)
        } catch {
            fatalError("Error adding store.")
        }
        self.init(moc: moc)
    }
    
    func tagFeedItem(tagTitle: String, feedItem: FeedItem) {
        print("+++> DCntrlr tagFeedItem")
        let tagsFetch = NSFetchRequest(entityName: "Tag")
        tagsFetch.predicate = NSPredicate(format: "title == %@", tagTitle)
        
        var fetchedTags: [Tag]!
        do {
            fetchedTags = try self.managedObjectContext.executeFetchRequest(tagsFetch) as! [Tag]
        } catch {
            fatalError("fetch failed")
        }
        
        var tag: Tag
        if fetchedTags.count == 0 {
            tag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: self.managedObjectContext) as! Tag
            tag.title = tagTitle
        } else {
            tag = fetchedTags[0]
        }
        
        let newImage = NSEntityDescription.insertNewObjectForEntityForName("Image", inManagedObjectContext: self.managedObjectContext) as! Image
        
        newImage.title = feedItem.title
        newImage.imageURL = feedItem.imageURL.absoluteString
        newImage.tag = tag
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("couldn't save context")
        }
    }
}
