//
//  SolarPlantViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class SolarPlantViewController: UIViewController {

    @IBOutlet weak var tiltAngleLabel: UILabel!
    @IBOutlet weak var tiltAngleSlider: UISlider!
    @IBOutlet weak var percentEfficiencyLabel: UILabel!
    @IBOutlet weak var percentEfficiencySlider: UISlider!
    @IBOutlet weak var tempCoeffTextField: UITextField!
    @IBOutlet weak var panelSurfaceAreaTextField: UITextField!
    @IBOutlet weak var numPanelsTextField: UITextField!
    
    let degreesCharacter = "\u{00B0}"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAnywhere()
    }
    
    @IBAction func tiltAngleSliderTapped(_ sender: UISlider) {
        let roundedAngle = Float(roundf(tiltAngleSlider.value * 10) / 10)
        tiltAngleLabel.text = "\(roundedAngle) \(degreesCharacter)"
    }
    
    @IBAction func percentEfficiencySliderTapped(_ sender: UISlider) {
        let roundedPercentEfficiency = Float(roundf(percentEfficiencySlider.value * 10) / 10)
        percentEfficiencyLabel.text = "\(roundedPercentEfficiency) %"
    }
    
    @IBAction func addPanelSetButtonPressed(_ sender: UIButton) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
