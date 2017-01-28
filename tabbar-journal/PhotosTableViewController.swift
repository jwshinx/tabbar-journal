//
//  PhotosTableViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/28/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import Foundation
import UIKit

class PhotosTableViewController : UITableViewController {
    
    // let colors = ["white", "yellow", "black"]
    
    var feed: Feed? {
        didSet {
            print("ooo> self: \(self)")
            print("ooo> self.tableView: \(self.tableView)")
            self.tableView.reloadData()
        }
    }
    
    var urlSession: NSURLSession!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // JWS init urlSession
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)
        
    }
    
    // JWS stop downloads when pass by or app closes, etc
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }
    
    override func viewDidLoad() {
        print("+++> AD.viewDidLoad start")
        
        // JWS it calls updateFeed and passes in "completion" block to run after done.
        //   it finds IFTVC and see that when feed called, it calls reloadData
        
        let italyUrlString = "https://api.flickr.com/services/feeds/photos_public.gne?tags=pantheon&format=json&nojsoncallback=1"
        print("+++> AD italyUrlString: \(italyUrlString)")
        // if let url = NSURL(string: foundURLString) {
        if let url = NSURL(string: italyUrlString) {
            print("+++> AD lets call updateFeed: \(url)")
            
            self.updateFeed(url, completion: { (feed) -> Void in
                // let viewController = application.windows[0].rootViewController as? PhotosTableViewController
                print("+++> AD running completion block \(self)")
                // JWS when iftvc.feed set, reloadData happens. see iftvc
                self.feed = feed
            })
        }
        print("+++> AD.viewDidLoad end")
    }
    
    // JWS loads feed and feeditems via api url
    // after feed item loaded, completion block is called
    func updateFeed(url: NSURL, completion: (feed: Feed?) -> Void) {
        print("+++> AD.updateFeed start url: \(url)")
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            print("+++> AD.updateFeed response: \(response)")
            if error == nil && data != nil {
                let feed = Feed(data: data!, sourceURL: url)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    print("+++> AD.updateFeed lets call completion")
                    completion(feed: feed)
                })
            }
        }
        
        task.resume()
        print("+++> AD.updateFeed end")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return colors.count
        return self.feed?.items.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
         let cell = tableView.dequeueReusableCellWithIdentifier("PhotosTableViewCell")
         guard let thisCell = cell else {
         print("---> Error. Cell is missing!")
         return UITableViewCell()
         }
         thisCell.textLabel?.text = colors[indexPath.row]
         return thisCell
         */
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotosTableViewCell", forIndexPath: indexPath) as! PhotosTableViewCell
        let item = self.feed!.items[indexPath.row]
        cell.itemLabel.text = item.title
        
        let request = NSURLRequest(URL: item.imageURL)
        
        // JWS a task is like a downl of a single image
        cell.dataTask = self.urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            // JWS must call on main thread since change to ui
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if error == nil && data != nil {
                    let image = UIImage(data: data!)
                    cell.itemImageView.image = image
                }
            })
        }
        cell.dataTask?.resume()
        return cell
    }
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PhotosSegue") {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? HuesTableViewController {
                dest.title = colors[selectedRow!]
                // dest.monthNumber = selectedRow! + 1
            }
        }
    }*/
}

