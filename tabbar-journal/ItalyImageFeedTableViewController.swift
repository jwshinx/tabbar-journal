//
//  ItalyImageFeedTableViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/1/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit
import CoreData

class ItalyImageFeedTableViewController: UITableViewController {
    
    var window: UIWindow?
    var dataController: DataController!
    var urlSession: NSURLSession!
    var initialLoad: Bool = true
    
    var feed: ItalyFeed? {
        didSet {
            print("++++++++++++++++++++++++++++++++++++++++++++++++")
            print("++++++++++++++++++++++++++++++++++++++++++++++++")
            print("+++> IIFTVC didSet italyFeed")
            print("+++> IIFTVC didSet lets reload data <+++++++++")
            
            guard let fct = feed?.items.count else {
                return
            }
            print("+++> feed: \(fct)")
            print("++++++++++++++++++++++++++++++++++++++++++++++++")
            print("++++++++++++++++++++++++++++++++++++++++++++++++")
            
            self.tableView.reloadData()
            if initialLoad == true {
                initialLoad = false
            }
            /*
            if(dataController == nil) {
                print("+++> dataController is not there")
            } else {
                print("+++> dataController is there")
                self.tableView.reloadData()
            }*/
            
            /*
            if fct == 20 {
                self.tableView.reloadData()
            }*/
            
            // self.tableView.reloadData()
            /*if initialLoad == true {
                print("+++ +++> initial load - reloadData")
                self.tableView.reloadData()
            } else {
                print("+++ +++> filtered load - do not reloadData")
            }*/
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print("+++> IIFTVC viewWillAppear 1")
        super.viewWillAppear(animated)

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)

        NSUserDefaults.standardUserDefaults().registerDefaults(["ItalyImageFeedURLString": "https://api.flickr.com/services/feeds/photos_public.gne?tags=italy&format=json&nojsoncallback=1"])
        
        self.dataController = DataController()
        
        // aaa
        // func applicationDidBecomeActive(application: UIApplication) {
        let urlString = NSUserDefaults.standardUserDefaults().stringForKey("ItalyImageFeedURLString")
        print("+++> AD applicationDidBecomeActive urlString: \(urlString)")
        guard let foundURLString = urlString else {
            return
        }
        if let url = NSURL(string: foundURLString) {
            self.loadOrUpdateFeed(url, completion: { (feed) -> Void in
                // let navController = application.windows[0].rootViewController as? UINavigationController
                // let viewController = navController?.viewControllers[0] as? ItalyImageFeedTableViewController
                print("~~~> feed 1 <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~")
                // viewController?.feed = feed
                // self.feed = feed
                print("~~~> initialLoad: \(self.initialLoad)")
                if self.initialLoad == true {
                    self.feed = feed
                }
                print("~~~> feed 2 <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~ <~~~")
            })
        }

        // bbb
        
        
        print("+++> IIFTVC viewWillAppear 10")
    }

    // ccc
    func loadOrUpdateFeed(url: NSURL, completion: (feed: ItalyFeed?) -> Void) {
        print("+++> AD loadOrUpdateFeed")
        let lastUpdatedSetting = NSUserDefaults.standardUserDefaults().objectForKey("lastUpdate") as? NSDate
        
        var shouldUpdate = true
        if let lastUpdated = lastUpdatedSetting where NSDate().timeIntervalSinceDate(lastUpdated) < 20 {
            shouldUpdate = false
        }
        if shouldUpdate {
            self.updateItalyFeed(url, completion: completion)
        } else {
            self.readItalyFeed { (feed) -> Void in
                if let foundSavedFeed = feed where foundSavedFeed.sourceURL.absoluteString == url.absoluteString {
                    print("+++> AD loaded saved feed!")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completion(feed: foundSavedFeed)
                    })
                } else {
                    self.updateItalyFeed(url, completion: completion)
                }
            }
        }
    }
    
    func updateItalyFeed(url: NSURL, completion: (feed: ItalyFeed?) -> Void) {
        print("+++> AD updateItalyFeed")
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil && data != nil {
                let feed = ItalyFeed(data: data!, sourceURL: url)
                if let goodFeed = feed {
                    if self.saveItalyFeed(goodFeed) {
                        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "lastUpdate")
                    }
                }
                print("+++> AD updateItalyFeed loaded Remote feed!")
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(feed: feed)
                })
            }
        }
        task.resume()
    }
    
    func italyFeedFilePath() -> String {
        print("+++> AD italyFeedFilePath")
        let paths = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)
        let filePath = paths[0].URLByAppendingPathComponent("feedFile.plist")
        return filePath!.path!
    }
    
    func saveItalyFeed(feed: ItalyFeed) -> Bool {
        print("+++> AD saveItalyFeed")
        let success = NSKeyedArchiver.archiveRootObject(feed, toFile: italyFeedFilePath())
        assert(success, "failed to write archive")
        return success
    }
    
    func readItalyFeed(completion: (feed: ItalyFeed?) -> Void) {
        print("+++> AD readItalyFeed")
        let path = italyFeedFilePath()
        let unarchivedObject = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
        completion(feed: unarchivedObject as? ItalyFeed)
    }

    // ddd
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("xxx> viewDidLoad <xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // print("+++> IIFTVC numberOfSectionsInTableView")
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("+++> IIFTVC tableView numberOfRowsInSection")
        return self.feed?.items.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // print("+++> IFTVC tableView cellForRowAtIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("ItalyImageFeedItemTableViewCell", forIndexPath: indexPath) as! ItalyImageFeedItemTableViewCell
        let item = self.feed!.items[indexPath.row]
        cell.itemTitle.text = item.title
        let request = NSURLRequest(URL: item.imageURL)
        cell.dataTask = self.urlSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
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

    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // print("+++> IIFTVC tableView didEndDisplayingCell")
        if let cell = cell as? ItalyImageFeedItemTableViewCell {
            cell.dataTask?.cancel()
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // print("+++> IIFTVC tableView didSelectRowAtIndexPath")
        let item = self.feed!.items[indexPath.row]
        let alertController = UIAlertController(title: "Add Tag", message: "Type your tag", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            if let tagTitle = alertController.textFields![0].text {
                // let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                // appDelegate.dataController.tagFeedItem(tagTitle, feedItem: item)
                self.dataController.tagFeedItem(tagTitle, feedItem: item)
            }
        }
        alertController.addAction(defaultAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addTextFieldWithConfigurationHandler(nil)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("+++> IIFTVC prepareForSegue")
        if segue.identifier == "showTags" {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.dataController.managedObjectContext
            let tagsVC = segue.destinationViewController as! TagsTableViewController
            
            let request = NSFetchRequest(entityName: "Tag")
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            tagsVC.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
