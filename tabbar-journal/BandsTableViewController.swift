//
//  BandsTableTableViewController.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/22/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

class BandsTableViewController: UITableViewController {
    
    var artists:[Band] = []

    override func viewDidLoad() {
        print("+++> BTVC viewDidLoad")
        super.viewDidLoad()
        print("+++> 1 <++++++++++++++++++++++++++++++")

        let radiohead: Band = Band(nameAndHomeTownAndBirthDate: "Radiohead", homeTown: "Leeds", birthDate: NSDate());
        print("accessing readonly property: \(radiohead.hometown)")
        let beatles: Band = Band(nameAndHomeTownAndBirthDate: "Beatles", homeTown: "Liverpool", birthDate: NSDate());
        let u2: Band = Band(nameAndHomeTown: "U2", homeTown: "Dublin");
        let rem: Band = Band(nameAndHomeTownAndBirthDate: "REM", homeTown: "Athens", birthDate: NSDate());

        artists.append(radiohead)
        artists.append(beatles)
        artists.append(u2)
        artists.append(rem)
        
        initializeAlbums()
        
        for band in artists {
            print("xxx> \(band.description())")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initializeAlbums() {
        let theBends: Album = Album(titleAndYearAndRevenue: "The Bends", year: 1995, revenue: 11)
        let okComputer: Album = Album(titleAndYearAndRevenue: "Ok Computer", year: 1997, revenue: 204)
        let amnesiac: Album = Album(titleAndYearAndRevenue: "Amnesiac", year: 2003, revenue: 224)
        let inRainbows: Album = Album(titleAndYearAndRevenue: "In Rainbows", year: 2005, revenue: 91)
        populateDiscography(artists[0], albums: [theBends, okComputer, amnesiac, inRainbows])
        
        let sp: Album = Album(titleAndYearAndRevenue: "Sargent Peppers", year: 1967, revenue: 67)
        let revolver: Album = Album(titleAndYearAndRevenue: "Revolver", year: 1965, revenue: 81)
        let wa: Album = Album(titleAndYearAndRevenue: "White Album", year: 1962, revenue: 103)
        populateDiscography(artists[1], albums: [sp, revolver, wa])

        let joshuaTree: Album = Album(titleAndYearAndRevenue: "Joshua Tree", year: 1988, revenue: 112)
        let war: Album = Album(titleAndYearAndRevenue: "War", year: 1983, revenue: 35)
        populateDiscography(artists[2], albums: [joshuaTree, war])

        let green: Album = Album(titleAndYearAndRevenue: "Green", year: 1988, revenue: 75)
        let document: Album = Album(titleAndYearAndRevenue: "Document", year: 1985, revenue: 8)
        populateDiscography(artists[3], albums: [green, document])
    }

    func populateDiscography(band: Band, albums: [Album]) {
        for album in albums {
            band.addAlbum(album)
        }
    }
    /*
    func populateDiscography(rem: Band) {
        let green: Album = Album(titleAndYearAndRevenue: "Green", year: 1988, revenue: 75)
        let document: Album = Album(titleAndYearAndRevenue: "Document", year: 1985, revenue: 8)
        
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
    }*/

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
