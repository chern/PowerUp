//
//  WindFarmViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class WindFarmViewController: UIViewController {

    // add turbine set
    @IBOutlet weak var addSetButton: UIButton!
    @IBOutlet weak var cutInWindspeedLabel: UILabel!
    @IBOutlet weak var cutInWindspeedSlider: UISlider!
    @IBOutlet weak var maxWindspeedLabel: UILabel!
    @IBOutlet weak var maxWindspeedSlider: UISlider!
    @IBOutlet weak var ratedPowerTextField: UITextField!
    @IBOutlet weak var numTurbinesTextField: UITextField!
    
    // site info
    @IBOutlet weak var avgAnnualWindspeedTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    // detailed info
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var withNumTurbineSetsLabel: UILabel!
    
    var windFarm = WindFarmProject(lat: 0.0, long: 0.0, avgWSpd: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAnywhere()
        addSetButton.layer.cornerRadius = 8
        calculateButton.layer.cornerRadius = 8
    }
    
    @IBAction func cutInWindspeedSliderTouched(_ sender: UISlider) {
        let roundedCutInWindspeed = Float(roundf(cutInWindspeedSlider.value * 10) / 10)
        cutInWindspeedLabel.text = "\(roundedCutInWindspeed) m/s"
    }
    
    @IBAction func maxWindspeedSliderTouched(_ sender: UISlider) {
        let roundedMaxWindspeed = Float(roundf(maxWindspeedSlider.value * 10) / 10)
        maxWindspeedLabel.text = "\(roundedMaxWindspeed) m/s"
    }
    
    @IBAction func addTurbineSetButtonPressed(_ sender: UIButton) {
        if (ratedPowerTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Rated Power")
            return
        } else if (numTurbinesTextField.text == "") {
            showEmptyFieldAlert(fieldName: "Number of Turbines")
            return
        }
        
        windFarm.addTurbineSet(numTurbines: Float(numTurbinesTextField.text!) as! Float, cutInWindSpeed: cutInWindspeedSlider.value, ratedPowerWindSpeed: maxWindspeedSlider.value, ratedPower: Float(ratedPowerTextField.text!) as! Float)
        
        resetAddTurbineSetFields()
        
        if (windFarm.turbines.count == 0 || windFarm.turbines.count >= 2) {
            withNumTurbineSetsLabel.text = "with \(windFarm.turbines.count) turbine sets"
        } else {
            withNumTurbineSetsLabel.text = "with \(windFarm.turbines.count) turbine set"
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        var ableToCalculate : Bool = false
        if (avgAnnualWindspeedTextField.text != "") {
            ableToCalculate = true
            // then use avg annual windspeed
            windFarm.averageWindSpeed = Float(avgAnnualWindspeedTextField.text!) as! Float
        } else if (longitudeTextField.text != "") {
            ableToCalculate = true
            windFarm.setAnnualWindSpeedBasedOnLongitude(longitude: Float(longitudeTextField.text!) as! Float)
        }
        
        if (!ableToCalculate) {
            let alert = UIAlertController(title: "Site Info Error", message: "Either average annual windspeed or a longitude must be entered.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            print(windFarm.getAnnualPowerOutput())
            
            let formattedPowerOutput : Float = Float(roundf(windFarm.getAnnualPowerOutput() * 100) / 100)
            print("Formatted: \(formattedPowerOutput)")
            
            let formattedRevenuePerYear : Float = Float(roundf(windFarm.calculateRevenue() * 100) / 100)
            
            let formattedOffsetCO2PerYear : Float = Float(roundf(windFarm.calculatePoundsCO2SavedPerYear() * 100) / 100)
            
            if (formattedPowerOutput < 0) {
                let errorAlert = UIAlertController(title: "Error", message: "Average windspeed must be greater than cut-in windspeed for all turbine sets.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true)
            } else {
                let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
                reportVC.modalTransitionStyle = UIModalTransitionStyle.partialCurl
                self.navigationController?.present(reportVC, animated: true, completion: {})
                reportVC.annualKWHOutputLabel?.text = "\(formattedPowerOutput)"
                reportVC.revenuePerYearLabel?.text = "$\(formattedRevenuePerYear)"
                reportVC.poundsCO2OffsetPerYearLabel?.text = "\(formattedOffsetCO2PerYear)"
                print("presented")
            }
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        self.reset()
    }
    
    // MARK: - Specific Member Functions
    
    func resetAddTurbineSetFields() -> Void {
        cutInWindspeedLabel.text = "0.0 m/s"
        cutInWindspeedSlider.setValue(0.0, animated: true)
        maxWindspeedLabel.text = "0.0 m/s"
        maxWindspeedSlider.setValue(0.0, animated: true)
        ratedPowerTextField.text = ""
        numTurbinesTextField.text = ""
    }
    
    func resetSiteInfoFields() -> Void {
        avgAnnualWindspeedTextField.text = ""
        longitudeTextField.text = ""
    }
    
    func reset() -> Void {
        windFarm.reset()
        resetAddTurbineSetFields()
        resetSiteInfoFields()
        withNumTurbineSetsLabel.text = "with \(windFarm.turbines.count) turbine sets"
    }
    
    func showEmptyFieldAlert(fieldName : String) -> Void {
        let alert : UIAlertController = UIAlertController(title: fieldName, message: "The \(fieldName.lowercased()) field cannot be blank.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
