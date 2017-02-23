//
//  FirstViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/22/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func onButtonClick(sender: AnyObject) {
        print("+++> onButtonClick")
        let now = NSDate()
        NSUserDefaults.standardUserDefaults().setObject(now, forKey: "buttonTapped")
        NSUserDefaults.standardUserDefaults().setObject("Joel Shin", forKey: "name")
        self.updateDateLabel()
        self.updateNameLabel()
    }
    
    func updateNameLabel() {
        let fullName = NSUserDefaults.standardUserDefaults().objectForKey("name") as? NSString
        if let hasName = fullName {
            self.nameLabel.text = hasName as String
        } else {
            self.nameLabel.text = "No name info."
        }
    }
    
    func updateDateLabel() {
        let lastUpdate = NSUserDefaults.standardUserDefaults().objectForKey("buttonTapped") as? NSDate
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "MMM d, yyyy"

        if let hasLastUpdate = lastUpdate {
            self.dateLabel.text = formatter.stringFromDate(hasLastUpdate)
        } else {
            self.dateLabel.text = "No date saved."
        }
    }


/*
func updateAuthorLabel() {
    let author = NSUserDefaults.standardUserDefaults().objectForKey("author") as? NSString
    print("+++> author: \(author!)")
    if let hasAuthor = author {
        self.nameLabel.text = hasAuthor as String
    } else {
        self.nameLabel.text = "No author info."
    }
}

func updateDateLabel() {
    let lastUpdate = NSUserDefaults.standardUserDefaults().objectForKey("buttonTapped") as? NSDate
    if let hasLastUpdate = lastUpdate {
        self.dateLabel.text = hasLastUpdate.description
    } else {
        self.dateLabel.text = "No date saved."
    }
}
*/



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

