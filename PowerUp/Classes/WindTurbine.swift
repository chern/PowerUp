//
//  WindTurbine.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import Foundation

class WindTurbine {
    init (cw : Float, rpw : Float, rp : Float)
    {
        self.cutInWindspeed = cw
        self.ratedPowerWindspeed = rpw
        self.ratedPower = rp
    }
//    var hashValue : Float {
//        return self.ratedPower
//    }
    
    var cutInWindspeed : Float
    var ratedPowerWindspeed : Float
    var ratedPower : Float
}
//
//func ==(lhs : WindTurbine, rhs : WindTurbine) -> Bool {
//    return lhs.ratedPower == rhs.ratedPower
//}
