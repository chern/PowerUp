//
//  SolarFarmProject.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import Foundation

class SolarPlantProject : PowerProject {
    init (lat : Float, nCloudy : Float, avgAnTemp : Float)
    {
        self.annualNumCloudyDays = nCloudy
        self.averageAnnualTemp = avgAnTemp
        super.init(lat: lat)
    }
    var solarPanels : [SolarPanel] = []
    var numOfPanels : [Float] = []
    var annualNumCloudyDays : Float
    var averageAnnualTemp : Float
    
    override func getAnnualPowerOutput() -> Float {
        var totalPowerOutput : Float = 0
        
        var peakIrradiance : Float = 0
        
        if (abs(latitude) >= 0 && abs(latitude) <= 10) {
            peakIrradiance = 1365;
        }
        else if (abs(latitude) >= 10 && abs(latitude) <= 20) {
            peakIrradiance = 1348;
        }
        else if (abs(latitude) >= 20 && abs(latitude) <= 30) {
            peakIrradiance = 1313;
        }
        else if (abs(latitude) >= 30 && abs(latitude) <= 40) {
            peakIrradiance = 1259;
        }
        else if (abs(latitude) >= 40 && abs(latitude) <= 50) {
            peakIrradiance = 1183;
        }
        else if (abs(latitude) >= 50 && abs(latitude) <= 60) {
            peakIrradiance = 1080;
        }
        else if (abs(latitude) >= 60 && abs(latitude) <= 70) {
            peakIrradiance = 942;
        }
        else if (abs(latitude) >= 70 && abs(latitude) <= 80) {
            peakIrradiance = 747;
        }
        else if (abs(latitude) >= 80 && abs(latitude) <= 90) {
            peakIrradiance = 322;
        }
        else {
            peakIrradiance = 1000;
        }
        
        var i : Int = 0
        
        for solarPanel in solarPanels {
            var tiltFactor : Float = 0
            tiltFactor = (-1.0/90.0) * abs(solarPanel.tiltAngle + 23.5 - 90) + 1
            
            let dailyNonCloudyPowerGeneration : Float = (solarPanel.surfaceArea * (peakIrradiance * 0.45) * (solarPanel.percentEfficiency / 100.0 - solarPanel.temperatureCoefficient / 100.0 * self.averageAnnualTemp)) * numOfPanels[i]
            
            let dailyCloudyPowerGeneration : Float = dailyNonCloudyPowerGeneration * 0.25
            
            totalPowerOutput += dailyNonCloudyPowerGeneration * 12.0 * (365.0 - self.annualNumCloudyDays) * tiltFactor
            
            totalPowerOutput +=  dailyCloudyPowerGeneration * 12.0 * annualNumCloudyDays * tiltFactor
            
            i += 1
        }
        return totalPowerOutput / 1000;
    }
    
    
    func addPanelSet(numPanels : Float, percentEfficiency : Float, temperatureCoefficient : Float, surfaceArea : Float, tiltAngle : Float) -> Void
    {
        let newPanel = SolarPanel (perEff: percentEfficiency, tempCoeff: temperatureCoefficient, sa: surfaceArea, tAngle: tiltAngle)
        solarPanels.append(newPanel)
        numOfPanels.append(numPanels)
    }
}

