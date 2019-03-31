//
//  SolarPlantViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class SolarPlantViewController: UIViewController {
    
    // constants
    let degreesCharacter = "\u{00B0}"

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
    
    // detailed info
    @IBOutlet weak var withNumPanelSetsDetailLabel: UILabel!
    
    
    var solarPlant: SolarPlantProject = SolarPlantProject(lat: 0.0, nCloudy: 0.0, avgAnTemp: 0.0)
    
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
        if(tempCoeffTextField.text == "" || panelSurfaceAreaTextField.text == "" || numPanelsTextField.text == "") {
            return
            // for later: show an alert?
        }
        solarPlant.addPanelSet(numPanels: Float(numPanelsTextField.text!) as! Float, percentEfficiency: percentEfficiencySlider.value, temperatureCoefficient: Float(tempCoeffTextField.text!) as! Float, surfaceArea: Float(panelSurfaceAreaTextField.text!) as! Float, tiltAngle: tiltAngleSlider.value)
        tempCoeffTextField.text = ""
        panelSurfaceAreaTextField.text = ""
        numPanelsTextField.text = ""
        if (solarPlant.solarPanels.count == 0 || solarPlant.solarPanels.count >= 2) {
            withNumPanelSetsDetailLabel.text = "with \(solarPlant.solarPanels.count) panel sets" // plural
        } else {
            withNumPanelSetsDetailLabel.text = "with \(solarPlant.solarPanels.count) panel set" // singular
        }
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        if(annualNumCloudyDaysTextField.text == "" || avgAnnualTempTextField.text == "" || latitudeTextField.text == "") {
            return
            // for later: show an alert?
        }
        solarPlant.annualNumCloudyDays = Float(annualNumCloudyDaysTextField.text!) as! Float
        solarPlant.averageAnnualTemp = Float(avgAnnualTempTextField.text!) as! Float
        solarPlant.latitude = Float(latitudeTextField.text!) as! Float
        
        print(solarPlant.getAnnualPowerOutput())
        
        let formattedPowerOutput : Float = Float(roundf(solarPlant.getAnnualPowerOutput() * 100) / 100)
        print("Formatted: \(formattedPowerOutput)")
        
        let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        reportVC.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        self.navigationController?.present(reportVC, animated: true, completion: {})
        reportVC.annualKWHOutputLabel?.text = "\(formattedPowerOutput)"
        print("presented")
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        self.reset()
    }
    
    // MARK: - Specific Functions
    
    func reset() -> Void {
        solarPlant.reset()
        
        tiltAngleLabel.text = "45.0\(degreesCharacter)"
        tiltAngleSlider.setValue(45.0, animated: true)
        percentEfficiencyLabel.text = "15.0%"
        percentEfficiencySlider.setValue(15.0, animated: true)
        tempCoeffTextField.text = ""
        panelSurfaceAreaTextField.text = ""
        numPanelsTextField.text = ""
        
        annualNumCloudyDaysTextField.text = ""
        avgAnnualTempTextField.text = ""
        latitudeTextField.text = ""
        
        withNumPanelSetsDetailLabel.text = "with \(solarPlant.solarPanels.count) panel sets"
    }
}
