//
//  WindFarmProject.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import Foundation

class WindFarmProject : PowerProject
{
    init(lat : Float, long : Float, avgWSpd : Float)
    {
        self.averageWindSpeed = avgWSpd
        self.longitude = long
        super.init(lat: lat)
    }
//    var turbineSystem : [WindTurbine : Int] = [:]
    var turbines : [WindTurbine] = []
    var numOfTurbines : [Int] = []
    var averageWindSpeed : Float
    var longitude : Float
    
    
}

