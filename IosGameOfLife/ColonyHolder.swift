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
    var allColonies: [String: Colony]
    // This will be the model --- here will will have methods to add, remove, or move the order of colonies
    
    init () {
        allColonies = [String: Colony]()
        allColonies["Colony0"] = Colony()
    }
    
    func addColony(colonyName: String) {
        allColonies[colonyName] = Colony()
    }
    
    func setCellAliveInColony(colonyName: String, coordinate: Coordinate)-> Bool {
        if let colony = allColonies[colonyName] {
            colony.setCellAlive(coordinate.getX(), yCoor: coordinate.getY())
            return true
        }
        return false
    }
    
    func setCellDeadInColony(colonyName: String, coordinate: Coordinate)->Bool {
        if let colony = allColonies[colonyName] {
            colony.setCellDead(coordinate.getX(), yCoor: coordinate.getY())
            return true
        }
        return false
    }
    func evolveColony(colonyName: String)->Bool {
        if let colony = allColonies[colonyName] {
            colony.evolve()
            return true
        }
        return false
    }
    
}
