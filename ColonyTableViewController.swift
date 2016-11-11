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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colonyHolder.colonies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        /* Set the text on the cell w/ the description of the colony
         that is at the nth index of colonies, where n = row this cell
         will appear in on the tableView */
         cell.textLabel?.text = colonyHolder.names[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowColony" {
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get colony associate w/ that row
                let colony = colonyHolder.colonies[row]
                let detailViewController = segue.destinationViewController as! DetailViewController
                detailViewController.colony = colony
            }
        }
    }
    
    @IBAction func addNewColony(sender: AnyObject) {
        
        let defaultID = colonyHolder.colonies.count // B/c we want a 0 index
        let colName = "Colony \(defaultID)"
        colonyHolder.addColony(colName)
        
        // Figure out where that colony is in the array
        if let index = colonyHolder.names.indexOf(colName) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            // Insert this new row into the table
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // If tableView is asking to commit a delete command ...
        if editingStyle == .Delete {
            colonyHolder.removeColony(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // Update the model
        colonyHolder.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
}
