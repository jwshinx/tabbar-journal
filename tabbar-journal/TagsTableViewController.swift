//
//  TagsTableViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/2/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit
import CoreData

class TagsTableViewController: UITableViewController {
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewWillAppear(animated: Bool) {
        print("+++> TTVC viewWillAppear")
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("tags fetch failed")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // print("+++> TTVC numberOfSectionsInTableView")
        return self.fetchedResultsController.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("+++> TTVC tableView numberOfRowsInSection")
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // print("+++> TTVC tableView cellForRowAtIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath)
        let tag = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Tag
        cell.textLabel?.text = tag.title
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("+++> TTVC prepareForSegue")
        if segue.identifier == "showImages" {
            let indexPath = self.tableView.indexPathForSelectedRow!
            let destination = segue.destinationViewController as! ItalyImageFeedTableViewController
            
            let tag = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Tag
            if let images = tag.images?.allObjects as? [Image] {
                var feedItems = [FeedItem]()
                for image in images {
                    let imageURL = NSURL(string: image.imageURL ?? "") ?? NSURL()
                    let newFeedItem = FeedItem(title: image.title ?? "(no title)" , imageURL: imageURL)
                    feedItems.append(newFeedItem)
                }
                let feed = ItalyFeed(items: feedItems, sourceURL: NSURL())
                destination.feed = feed
            }
        }
    }
}
