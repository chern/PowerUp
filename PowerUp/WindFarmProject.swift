import Foundation

class WindFarmProject : PowerProject
{
    init(lat : Float, long : Float, avgWSpd : Float)
    {
        self.averageWindSpeed = avgWSpd
        self.longitude = long
        super.init(lat: lat)
    }
    var turbines : [WindTurbine] = []
    var numOfTurbines : [Float] = []
    var averageWindSpeed : Float
    var longitude : Float
    
    override func getAnnualPowerOutput() -> Float {
        
        var totalPowerOutput : Float = 0
        var i : Int = 0
        
        for turbine in turbines
        {
            if (self.averageWindSpeed < turbine.cutInWindspeed)
            {
                return -1.0
            }
            else if (averageWindSpeed > turbine.ratedPowerWindspeed)
            {
                totalPowerOutput += turbine.ratedPower * numOfTurbines[i]
            }
            else
            {
                totalPowerOutput += ((turbine.ratedPower / (turbine.ratedPowerWindspeed - turbine.cutInWindspeed)) * (self.averageWindSpeed - turbine.cutInWindspeed)) * numOfTurbines[i]
            }
            i += 1
        }
        return totalPowerOutput
    }
    
    func getAnnualWindSpeed (longitude : Float) -> Float {
        if (longitude <= 130 && longitude >= 105) {
            return 4.5;
        }
        else if (longitude <= 105 && longitude >= 95) {
            return 8.0;
        }
        else if (longitude <= 95 && longitude >= 85) {
            return 6.0;
        }
        else if (longitude <= 85 && longitude >= 60) {
            return 4.5;
        }
        else {
            return 5.5;
        }
    }
    
    override func reset() -> Void {
        turbines.removeAll()
        numOfTurbines.removeAll()
    }
}
