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
        print("+++> PTVC viewWillAppear")
        super.viewWillAppear(animated)
        
        // JWS init urlSession
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)
        
    }
    
    // JWS stop downloads when pass by or app closes, etc
    override func viewWillDisappear(animated: Bool) {
        print("+++> viewWillDisappear")
        super.viewWillDisappear(animated)
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }
    
    override func viewDidLoad() {
        print("+++> PTVC.viewDidLoad start")
        
        // JWS it calls updateFeed and passes in "completion" block to run after done.
        //   it finds IFTVC and see that when feed called, it calls reloadData
        
        let italyUrlString = "https://api.flickr.com/services/feeds/photos_public.gne?tags=pantheon&format=json&nojsoncallback=1"
        print("+++> PTVC italyUrlString: \(italyUrlString)")
        // if let url = NSURL(string: foundURLString) {
        
        if let url = NSURL(string: italyUrlString) {
            print("+++> PTVC lets call updateFeed: \(url)")
            
            self.loadOrUpdateFeed(url, completion: { (feed) -> Void in
                // let viewController = application.windows[0].rootViewController as? PhotosTableViewController
                print("+++> PTVC running completion block \(self)")
                // JWS when iftvc.feed set, reloadData happens. see iftvc
                self.feed = feed
            })
        }
        print("+++> PTVC.viewDidLoad end")
    }
    

    // JWS loads feed and feeditems via api url
    // after feed item loaded, completion block is called

    func updateFeed(url: NSURL, completion: (feed: Feed?) -> Void) {
        // updateFeed(url, completion: <#T##(feed: Feed?) -> Void#>)
        print("+++> PTVC.updateFeed start")
        print("+++> PTVC.updateFeed url: \(url)")
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // print("+++> PTVC.updateFeed response: \(response)")
            if error == nil && data != nil {
                let feed = Feed(data: data!, sourceURL: url)
                if let goodFeed = feed {
                    if self.saveFeed(goodFeed) {
                        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "lastUpdate")
                    }
                }

                print("+++> loaded Remote feed! <++++++++++++++++")

                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    print("+++> PTVC.updateFeed lets call completion")
                    completion(feed: feed)
                })
            }
        }
        
        task.resume()
        print("+++> PTVC.updateFeed end")
    }

    func loadOrUpdateFeed(url: NSURL, completion: (feed: Feed?) -> Void) {
        
        let lastUpdatedSetting = NSUserDefaults.standardUserDefaults().objectForKey("lastUpdate") as? NSDate
        
        var shouldUpdate = true
        if let lastUpdated = lastUpdatedSetting where NSDate().timeIntervalSinceDate(lastUpdated) < 120 {
            shouldUpdate = false
        }
        if shouldUpdate {
            print("+++> PTVC loadOrUpdateFeed has been a while, update feed! <++++++++++++++++")
            self.updateFeed(url, completion: completion)
        } else {
            self.readFeed { (feed) -> Void in
                if let foundSavedFeed = feed where foundSavedFeed.sourceURL.absoluteString == url.absoluteString {
                    print("+++> PTVC loadOrUpdateFeed loaded saved feed! <++++++++++++++++")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completion(feed: foundSavedFeed)
                    })
                } else {
                    print("+++> PTVC loadOrUpdateFeed diff url, loaded remote feed! <++++++++++++++++")
                    self.updateFeed(url, completion: completion)
                }
            }
        }
    }

    func feedFilePath() -> String {
        let paths = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
        let filePath = paths[0].URLByAppendingPathComponent("feedFile.plist")
        return filePath!.path!
    }
    
    func saveFeed(feed: Feed) -> Bool {
        let success = NSKeyedArchiver.archiveRootObject(feed, toFile: feedFilePath())
        assert(success, "failed to write archive")
        return success
    }
    
    func readFeed(completion: (feed: Feed?) -> Void) {
        let path = feedFilePath()
        let unarchivedObject = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
        completion(feed: unarchivedObject as? Feed)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // print("+++> PTVC numberOfSectionsInTableView")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("+++> PTVC tableView numberOfRowsInSection")
        // return colors.count
        return self.feed?.items.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // print("+++> PTVC tableView cellForRowAtIndexPath")
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

