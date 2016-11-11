//
//  ColonyTableViewController.swift
//  IosGameOfLife
//
//  Created by Katie Collins on 11/11/16.
//
//

import Foundation
import UIKit

class ColonyTableViewController: UITableViewController {
    
    var colonyHolder: ColonyHolder!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colonyHolder.allColonies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        /* Set the text on the cell w/ the description of the item
         that is at the nth index of colonies, where n = row this cell
         will appear in on the tableView */
        //let colony = colonyHolder.allColonies[indexPath.row]
        
        //cell.textLabel?.text = colony.name
        cell.textLabel?.text = "Colony \(indexPath.row)"
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowColony" {
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get colony associate w/ that row
                //let colony = colonyHolder.allColonies[row]
                if let colony = colonyHolder.getColonyForIndex(row) {
                    let detailViewController = segue.destinationViewController as! DetailViewController
                    detailViewController.colony = colony
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
}
