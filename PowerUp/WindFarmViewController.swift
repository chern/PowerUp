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
    @IBOutlet weak var withNumTurbineSetsLabel: UILabel!
    
    var windFarm = WindFarmProject(lat: 0.0, long: 0.0, avgWSpd: 0.0)
    
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
    
    @IBAction func addTurbineSetButtonPressed(_ sender: UIButton) {
        if (ratedPowerTextField.text == "" || numTurbinesTextField.text == "") {
            return
        }
        windFarm.addTurbineSet(numTurbines: Float(numTurbinesTextField.text!) as! Float, cutInWindSpeed: cutInWindspeedSlider.value, ratedPowerWindSpeed: maxWindspeedSlider.value, ratedPower: Float(ratedPowerTextField.text!) as! Float)
        ratedPowerTextField.text = ""
        numTurbinesTextField.text = ""
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
            windFarm.averageWindSpeed = WindFarmProject.getAnnualWindSpeed(longitude: Float(longitudeTextField.text!) as! Float)
        }
        
        if (ableToCalculate) {
            print(windFarm.getAnnualPowerOutput())
            
            let formattedPowerOutput : Float = Float(roundf(windFarm.getAnnualPowerOutput() * 100) / 100)
            print("Formatted: \(formattedPowerOutput)")
            
            let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
            reportVC.modalTransitionStyle = UIModalTransitionStyle.partialCurl
            self.navigationController?.present(reportVC, animated: true, completion: {self.reset()})
            reportVC.annualKWHOutputLabel?.text = "\(formattedPowerOutput)"
            print("presented")
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        self.reset()
    }
    
    func reset() -> Void {
        windFarm.reset()
        
        cutInWindspeedLabel.text = "0.0 m/s"
        cutInWindspeedSlider.setValue(0.0, animated: true)
        maxWindspeedLabel.text = "0.0 m/s"
        maxWindspeedSlider.setValue(0.0, animated: true)
        ratedPowerTextField.text = ""
        numTurbinesTextField.text = ""
        
        avgAnnualWindspeedTextField.text = ""
        longitudeTextField.text = ""
        
        withNumTurbineSetsLabel.text = "with 0 turbine sets"
    }
}
