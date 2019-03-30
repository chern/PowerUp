//
//  WindFarmViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class WindFarmViewController: UIViewController {

    @IBOutlet weak var cutInWindspeedLabel: UILabel!
    @IBOutlet weak var cutInWindspeedSlider: UISlider!
    @IBOutlet weak var maxWindspeedLabel: UILabel!
    @IBOutlet weak var maxWindspeedSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAnywhere()
    }
    
    @IBAction func cutInWindspeedSliderTouched(_ sender: UISlider) {
        let roundedCutInWindspeed = Float(roundf(cutInWindspeedSlider.value * 10) / 10)
        cutInWindspeedLabel.text = "\(roundedCutInWindspeed) m/s"
    }
    
    @IBAction func maxWindspeedSliderTouched(_ sender: UISlider) {
        let roundedMaxWindspeed = Float(roundf(maxWindspeedSlider.value * 10) / 10)
        maxWindspeedLabel.text = "\(roundedMaxWindspeed) m/s"
    }
    
}
