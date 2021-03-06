//
//  DashboardsTableViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/22/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

class DashboardsTableViewController: UITableViewController {

    var dashboards:[String] = ["People", "Grants", "Payments", "Organizations"]

    override func viewDidLoad() {
        super.viewDidLoad()

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

    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }*/
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dashboards.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("+++> DTVC cellForRowAt")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = dashboards[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! CardsTableViewController
        if segue.identifier == "cardsSegue" {
            print("+++> prepareForSegue cardsSegue")
            dest.selectedDashboard = "my selected dashboard"
            
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? CardsTableViewController {
                print("+++>    CardsTableViewController yes!")
                dest.selectedDashboard = dashboards[selectedRow!]
                dest.title = dashboards[selectedRow!]
            } else {
                print("+++>    CardsTableViewController no!")
            }
        } else {
            print("+++> prepareForSegue not albumsSegue")
            dest.selectedDashboard = "n/a"
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("+++> DTVC didSelectRowAtIndexPath")
    }

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

}
