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
    var artists:[Band] = []

    override func viewDidLoad() {
        print("+++> BTVC viewDidLoad")
        super.viewDidLoad()
        print("+++> 1 <++++++++++++++++++++++++++++++")
        let radiohead: Band = Band()
        radiohead.birthdate = NSDate()
        radiohead.hometown = "London"
        radiohead.name = "Radiohead"

        let beatles: Band = Band(nameAndHomeTownAndBirthDate: "Beatles", homeTown: "Liverpool", birthDate: NSDate());
        let arcadeFire: Band = Band(name: "Arcade Fire")
        let stoneRoses: Band = Band(nameAndHomeTown: "Stone Roses", homeTown: "Manchester");
        let rem: Band = Band(nameAndHomeTownAndBirthDate: "REM", homeTown: "Athens", birthDate: NSDate());

        artists.append(rem)
        artists.append(radiohead)
        artists.append(beatles)
        artists.append(arcadeFire)
        artists.append(stoneRoses)
        populateDiscography(rem)
        
        /*
        let joshuaTree: Album = Album(titleAndYear: "Joshua Tree", year: 1985)
        joshuaTree.revenue = 112
        print("+++ +++> album: \(joshuaTree)")
        */

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // JWS todo: make this more flexible. pass band and albums. make it handle all bands
    // JWS todo: make this more flexible. pass band and albums. make it handle all bands
    // JWS todo: make this more flexible. pass band and albums. make it handle all bands
    // JWS todo: make this more flexible. pass band and albums. make it handle all bands
    // JWS todo: make this more flexible. pass band and albums. make it handle all bands
    func populateDiscography(rem: Band) {
        let green: Album = Album(titleAndYear: "Green", year: 1988)
        green.revenue = 75
        
        let document: Album = Album(titleAndYear: "Document", year: 1985)
        green.revenue = 8
        
        rem.addAlbum(green)
        rem.addAlbum(document)
        
        for artist in artists {
            print("------> \(artist.description)")
            guard let albums = artist.discography else {
                continue
            }
            for album in albums {
                print("------>     ***> \(album)")
            }
        }
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
        return artists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("+++> BTVC cellForRowAt")
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = artists[indexPath.row].name
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! AlbumsTableViewController
        if segue.identifier == "albumsSegue" {
            print("+++> prepareForSegue albumsSegue")
            dest.selectedBand = Band()
            
            
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? AlbumsTableViewController {
                print("+++>    AlbumsViewController yes!")
                dest.selectedBand = artists[selectedRow!]
                dest.title = artists[selectedRow!].name
            } else {
                print("+++>    AlbumsViewController no!")
            }
        } else {
            print("+++> prepareForSegue not albumsSegue")
            dest.selectedBand = Band()
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
