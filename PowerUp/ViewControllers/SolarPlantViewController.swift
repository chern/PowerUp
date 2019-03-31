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
    @IBOutlet weak var addSetButton: UIButton!
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
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var withNumPanelSetsDetailLabel: UILabel!
    
    
    var solarPlant: SolarPlantProject = SolarPlantProject(lat: 0.0, nCloudy: 0.0, avgAnTemp: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAnywhere()
        addSetButton.layer.cornerRadius = 8
        calculateButton.layer.cornerRadius = 8
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
        if (tempCoeffTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Temperature Coefficient")
            return
        }  else if (panelSurfaceAreaTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Panel Surface Area")
            return
        } else if (numPanelsTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Number of Panels")
            return
        }
        
        solarPlant.addPanelSet(numPanels: Float(numPanelsTextField.text!) as! Float, percentEfficiency: percentEfficiencySlider.value, temperatureCoefficient: Float(tempCoeffTextField.text!) as! Float, surfaceArea: Float(panelSurfaceAreaTextField.text!) as! Float, tiltAngle: tiltAngleSlider.value)
        resetAddPanelSetFields()
        if (solarPlant.solarPanels.count == 0 || solarPlant.solarPanels.count >= 2) {
            withNumPanelSetsDetailLabel.text = "with \(solarPlant.solarPanels.count) panel sets" // plural
        } else {
            withNumPanelSetsDetailLabel.text = "with \(solarPlant.solarPanels.count) panel set" // singular
        }
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        if (annualNumCloudyDaysTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Annual # of Cloudy Days")
            return
        } else if (avgAnnualTempTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Averge Annual Temperature")
            return
        } else if (latitudeTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Latitude")
            return
        }
        
        solarPlant.annualNumCloudyDays = Float(annualNumCloudyDaysTextField.text!) as! Float
        solarPlant.averageAnnualTemp = Float(avgAnnualTempTextField.text!) as! Float
        solarPlant.latitude = Float(latitudeTextField.text!) as! Float
        
        print(solarPlant.getAnnualPowerOutput())
        
        let formattedPowerOutput : Float = Float(roundf(solarPlant.getAnnualPowerOutput() * 100) / 100)
        print("Formatted: \(formattedPowerOutput)")
        
        let formattedRevenuePerYear : Float = Float(roundf(solarPlant.calculateRevenue() * 100) / 100)
        
        let formattedOffsetCO2PerYear : Float = Float(roundf(solarPlant.calculatePoundsCO2SavedPerYear() * 100) / 100)
        
        let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        reportVC.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        self.navigationController?.present(reportVC, animated: true, completion: {})
        reportVC.annualKWHOutputLabel?.text = "\(formattedPowerOutput)"
        reportVC.revenuePerYearLabel?.text = "$\(formattedRevenuePerYear)"
        reportVC.poundsCO2OffsetPerYearLabel?.text = "\(formattedOffsetCO2PerYear)"
        print("presented")
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        self.reset()
    }
    
    // MARK: - Specific Functions
    
    func resetAddPanelSetFields() -> Void {
        tiltAngleLabel.text = "45.0\(degreesCharacter)"
        tiltAngleSlider.setValue(45.0, animated: true)
        percentEfficiencyLabel.text = "15.0%"
        percentEfficiencySlider.setValue(15.0, animated: true)
        tempCoeffTextField.text = ""
        panelSurfaceAreaTextField.text = ""
        numPanelsTextField.text = ""
    }
    
    func resetSiteInfoFields() -> Void {
        annualNumCloudyDaysTextField.text = ""
        avgAnnualTempTextField.text = ""
        latitudeTextField.text = ""
    }
    
    func reset() -> Void {
        solarPlant.reset()
        resetAddPanelSetFields()
        resetSiteInfoFields()
        withNumPanelSetsDetailLabel.text = "with \(solarPlant.solarPanels.count) panel sets"
    }
    
    func showEmptyFieldAlert(fieldName : String) -> Void {
        let alert : UIAlertController = UIAlertController(title: fieldName, message: "The \(fieldName.lowercased()) field cannot be blank.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
