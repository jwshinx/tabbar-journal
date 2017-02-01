//
//  AppDelegate.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/22/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataController: DataController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // NSUserDefaults.standardUserDefaults().registerDefaults(["PhotoFeedURLString": "https://api.flickr.com/services/feeds/photos_public.gne?tags=pantheon&format=json&nojsoncallback=1"])

        NSUserDefaults.standardUserDefaults().registerDefaults(["ItalyImageFeedURLString": "https://api.flickr.com/services/feeds/photos_public.gne?tags=italy&format=json&nojsoncallback=1"])
        print("+++> AD application")
        self.dataController = DataController()
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        let urlString = NSUserDefaults.standardUserDefaults().stringForKey("ItalyImageFeedURLString")
        // let x = NSUserDefaults.standardUserDefaults().stringForKey("xxx")
        print("+++> AD applicationDidBecomeActive urlString: \(urlString)")
        guard let foundURLString = urlString else {
            return
        }
        if let url = NSURL(string: foundURLString) {
            self.loadOrUpdateFeed(url, completion: { (feed) -> Void in
                let navController = application.windows[0].rootViewController as? UINavigationController
                let viewController = navController?.viewControllers[0] as? ItalyImageFeedTableViewController
                viewController?.feed = feed
            })
        }
    }

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
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

