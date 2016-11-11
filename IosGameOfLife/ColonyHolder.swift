//
//  ColonyHolder.swift
//  IosGameOfLife
//
//  Created by Katie Collins on 11/11/16.
//
//

import Foundation
import UIKit

class ColonyHolder {
    var allColonies = [Colony]()
    // This will be the model --- here will will have methods to add, remove, or move the order of colonies
    
    init () {
        var col = Colony()
        col.setCellAlive(5, yCoor: 5)
        col.setCellAlive(5, yCoor: 6)
        col.setCellAlive(5, yCoor: 7)
        col.setCellAlive(6, yCoor: 6)
        allColonies.append(col)
        // I have added a fake colony just for testing
    }
}
