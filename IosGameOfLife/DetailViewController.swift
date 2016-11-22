//
//  DetailViewController.swift
//  IosGameOfLife
//
//  Created by Katie Collins on 11/11/16.
//
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var colony: Colony!
    
    @IBOutlet var colonyView: UIView!
    
    @IBOutlet var coordinateText: UILabel!
    
    @IBOutlet var numEvolves: UISlider!
    @IBOutlet var textNumEvolves: UILabel!
    
    @IBOutlet var speed: UISlider!
    @IBOutlet var textSpeed: UILabel!
    
    @IBOutlet var wrapping: UISwitch!
    
    var timer: NSTimer?
    
    var currentEvolveNumber: Int = 0
    
    var minX,minY,maxX,maxY,height,width: CGFloat?
    // NOTE: the name of the colony will automatically appear as the header --- no need to code this
    var cells: [Coordinate: UIView]!
    
    func findBounds() {
        minX = colonyView.bounds.minX
        minY = colonyView.bounds.minY
        maxX = colonyView.bounds.maxX
        maxY = colonyView.bounds.maxY
        width = CGFloat(Int(colonyView.bounds.width)/60)
        height = CGFloat(Int(colonyView.bounds.height)/60)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // this is where we set the outlets .... Daniel can do this for colonyView and coordinateText??)
        numEvolves.minimumValue = 0
        numEvolves.maximumValue = 1000
        numEvolves.value = 0
        textNumEvolves.text = String(Int(numEvolves.value))
        // Speed = # of evolutions per second
        speed.minimumValue = 0
        speed.maximumValue = 5
        speed.value = 0
        textSpeed.text = String(Int(speed.value))
        wrapping.on = false
        coordinateText.text = "(x,y)"
        //set example colony
        colony = Colony()
        colony.setCellAlive(17, yCoor: 5)
        colony.setCellAlive(18, yCoor: 5)
        colony.setCellAlive(19, yCoor: 5)
        colony.setCellAlive(18, yCoor: 6)
        
        //setup for colonyView:
        cells = [Coordinate: UIView]()
        findBounds()
        for x in 0..<60 {
            for y in 0..<60 {
                let cell = CGRect(x: CGFloat(Int(minX!)+Int(width!)*x), y: CGFloat(Int(minY!)+Int(height!)*y), width: width!, height: height!)
                let cellView = UIView(frame: cell)
                cellView.layer.borderColor = UIColor.blackColor().CGColor
                cellView.layer.borderWidth = 1.0
                colonyView.addSubview(cellView)
                cells[Coordinate(x: x, y: y)] = cellView
            }
        }
        drawColony()
    }
    
    func drawColony() {
        let cellsAlive = cells.keys.filter{self.colony.cells.contains($0)}
        let cellsDead = cells.keys.filter{!self.colony.cells.contains($0)}
        
        for cell in cellsAlive {
            cells[cell]?.backgroundColor = UIColor.blackColor()
        }
        
        for cell in cellsDead {
            cells[cell]?.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func evolveSliderChanged(sender: UISlider) {
        textNumEvolves.text = String(Int(sender.value))
        currentEvolveNumber = 0
    }
    
    @IBAction func speedSliderChanged(sender: UISlider) {
        let value = Int(sender.value)
        textSpeed.text = "\(value)"
        startTimer(NSTimeInterval(value))
    }
    
    func startTimer(interval: NSTimeInterval) {
        timer = NSTimer.scheduledTimerWithTimeInterval(interval,
                                                       target: self,
                                                       selector: #selector(DetailViewController.onTick(_:)),
                                                       userInfo: nil,
                                                       repeats: false)
    }
    
    func onTick(timer:NSTimer){
        if currentEvolveNumber < Int(numEvolves!.value) {
            colony.evolve() // NOTE, colony is a class, so this should update no matter what (reference, not value type)
            drawColony()
            currentEvolveNumber += 1
        }
    }
    
    
    @IBAction func changedWrapping(sender: UISwitch) {
        if sender.on {
            colony.useWrapping()
        } else {
            colony.dontUseWrapping()
        }
    }
    
}