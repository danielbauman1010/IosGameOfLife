//
//  Colony.swift
//  GameOfLife
//
//  Created by Katie Collins on 9/26/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import Foundation

class Colony: CustomStringConvertible{
    
    var cells: Set<Coordinate> = []
    
    var genNumber: Int = 0
    
    let yMax = 20
    let xMax = 20
    
    func setCellAlive(xCoor: Int, yCoor: Int) {
        if xCoor < 20 && xCoor >= 0 {
            if yCoor < 20 && yCoor >= 0 {
                let coor = Coordinate(x: xCoor, y: yCoor)
                cells.insert(coor)
            }
        }
    }
    
    func setCellDead(xCoor: Int, yCoor: Int) {
        let coor = Coordinate(x: xCoor, y: yCoor)
        cells.remove(coor)
    }
    
    func resetColony() {
        cells.removeAll()
    }
    
    func isCellAlive(xCoor:Int, yCoor: Int) -> Bool{
        for c in cells {
            if c.getX() == xCoor && c.getY() == yCoor {
                return true
            }
        }
        return false
    }
    
    func getNeighbors(x: Int, y: Int) -> Set<Coordinate> {
        var neighbors: Set <Coordinate> = [];
        neighbors.insert(Coordinate(x: x + 1, y: y));
        neighbors.insert(Coordinate(x: x - 1, y: y));
        neighbors.insert(Coordinate(x: x, y: y + 1));
        neighbors.insert(Coordinate(x: x, y: y - 1));
        neighbors.insert(Coordinate(x: x + 1, y: y + 1));
        neighbors.insert(Coordinate(x: x - 1, y: y - 1));
        neighbors.insert(Coordinate(x: x + 1, y: y - 1));
        neighbors.insert(Coordinate(x: x - 1, y: y + 1));
        return neighbors;
    }
    
    func evolve() {
        
        genNumber += 1
        
        var newCells: Set<Coordinate> = []
        var toCheck: Set<Coordinate> = []
        var temp: Set<Coordinate> = []
        
        // Populating toCheck with the cells toCheck
        cells.map({
            getNeighbors($0.x, y: $0.y).map(
                {t in toCheck.insert(t)})
            toCheck.insert($0)
        })
        temp.removeAll()
        
        // Count the number of neighbors in the set for each coordinate and apply rules
        
        toCheck.map(
            {var alive = 0
                getNeighbors($0.x, y: $0.y).map(
                    {t in if cells.contains(t) {alive += 1}})
                if !cells.contains($0) {
                    // Was not originally alive
                    if alive == 3 {
                        newCells.insert($0);
                    }
                }
                else {
                    if alive == 3 || alive == 2 {
                        newCells.insert($0);
                    }
                }
            }
        )
        
        // Convert the newCells to the actual cells
        
        cells.removeAll();
        newCells.map({setCellAlive($0.x, yCoor: $0.y)})
        
    }
    
    func coorString(x: Int, y: Int) -> String {
        if isCellAlive(x, yCoor: y) {
            return "*"
        } else {
            return " "
        }
    }
    
    var description: String {
        var output = ""
        output += "Generation #" + String(genNumber) + "\n\n"
        for x in 0 ..< 20 {
            for y in 0 ..< 20 {
                output += coorString(x, y: y)
            }
            output += "\n"
        }
        return output
    }
}
