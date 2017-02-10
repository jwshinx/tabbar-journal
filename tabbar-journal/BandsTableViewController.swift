//
//  BandsTableTableViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/22/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

class BandsTableViewController: UITableViewController {
    
    var bands:[String] = ["Radiohead", "Nirvana", "Beatles", "Air"]

    override func viewDidLoad() {
        print("+++> BTVC viewDidLoad")
        super.viewDidLoad()
        print("+++> 1 <++++++++++++++++++++++++++++++")
        let radiohead: Band = Band()
        radiohead.birthdate = NSDate()
        radiohead.hometown = "London"
        radiohead.name = "Radiohead"
        print("\(radiohead.description)")

        print("+++> 2 <++++++++++++++++++++++++++++++")
        let beatles: Band = Band()
        print("\(beatles.description)")
        
        print("+++> 3 <++++++++++++++++++++++++++++++")
        let aaa = Band.init()
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

    func numberOfSections(in tableView: UITableView) -> Int {
        print("+++> BTVC ")
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("+++> BTVC numberOfRowsInSection")
        return bands.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("+++> BTVC cellForRowAt")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = bands[indexPath.row]
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! AlbumsTableViewController
        if segue.identifier == "albumsSegue" {
            print("+++> prepareForSegue albumsSegue")
            dest.selectedBand = "my selected band"
            
            
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? AlbumsTableViewController {
                print("+++>    AlbumsViewController yes!")
                dest.selectedBand = bands[selectedRow!]
                dest.title = bands[selectedRow!]
            } else {
                print("+++>    AlbumsViewController no!")
            }
        } else {
            print("+++> prepareForSegue not albumsSegue")
            dest.selectedBand = "n/a"
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("+++> BTVC didSelectRowAtIndexPath")
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
