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
    
    // NOTE: the name of the colony will automatically appear as the header --- no need to code this
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
    }
    
    @IBAction func evolveSliderChanged(sender: UISlider) {
        textNumEvolves.text = String(Int(sender.value))
        currentEvolveNumber = 0
    }
    
    @IBAction func speedSliderChanged(sender: UISlider) {
        var value = Int(sender.value)
        textSpeed.text = "\(value)"
        startTimer(NSTimeInterval(value))
    }
    
    func startTimer(interval: NSTimeInterval) {
        timer = NSTimer.scheduledTimerWithTimeInterval(interval,
                                                       target: self,
                                                       selector: "onTick:",
                                                       userInfo: nil,
                                                       repeats: false)
    }
    
    func onTick(timer:NSTimer){
        if currentEvolveNumber < Int(numEvolves!.value) {
            colony.evolve() // NOTE, colony is a class, so this should update no matter what (reference, not value type)
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