//
//  PowerProject.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import Foundation

class PowerProject {
    init (lat : Float)
    {
        self.latitude = lat
    }
    var latitude : Float
    
    func getAnnualPowerOutput() -> Float {
        return -1.0;
    }
    
    func reset() -> Void {
        return
    }
}
