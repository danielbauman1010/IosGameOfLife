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
    
    // NOTE: the name of the colony will automatically appear as the header --- no need to code this
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // this is where we set the outlets ..... Katie will do this soon (excpet for the colonyView and coordinateText .... Daniel can do this??)
    }
    
}