//
//  SolarPlantViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class SolarPlantViewController: UIViewController {

    // add panel set
    @IBOutlet weak var tiltAngleLabel: UILabel!
    @IBOutlet weak var tiltAngleSlider: UISlider!
    @IBOutlet weak var percentEfficiencyLabel: UILabel!
    @IBOutlet weak var percentEfficiencySlider: UISlider!
    @IBOutlet weak var tempCoeffTextField: UITextField!
    @IBOutlet weak var panelSurfaceAreaTextField: UITextField!
    @IBOutlet weak var numPanelsTextField: UITextField!
    
    // site info
    @IBOutlet weak var annualNumCloudyDaysTextField: UITextField!
    @IBOutlet weak var avgAnnualTempTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    
    let degreesCharacter = "\u{00B0}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAnywhere()
    }
    
    @IBAction func tiltAngleSliderTapped(_ sender: UISlider) {
        let roundedAngle = Float(roundf(tiltAngleSlider.value * 10) / 10)
        tiltAngleLabel.text = "\(roundedAngle)\(degreesCharacter)"
    }
    
    @IBAction func percentEfficiencySliderTapped(_ sender: UISlider) {
        let roundedPercentEfficiency = Float(roundf(percentEfficiencySlider.value * 10) / 10)
        percentEfficiencyLabel.text = "\(roundedPercentEfficiency)%"
    }
    
    @IBAction func addPanelSetButtonPressed(_ sender: UIButton) {
    }

}
