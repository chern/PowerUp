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
    
    func setAnnualWindSpeedBasedOnLongitude(longitude : Float) -> Void {
        if (longitude <= 130.0 && longitude >= 105.0) {
            averageWindSpeed = 4.5;
        }
        else if (longitude <= 105.0 && longitude >= 95.0) {
            averageWindSpeed = 8.0;
        }
        else if (longitude <= 95.0 && longitude >= 85.0) {
            averageWindSpeed = 6.0;
        }
        else if (longitude <= 85.0 && longitude >= 60.0) {
            averageWindSpeed = 4.5;
        }
        else {
            averageWindSpeed = 5.5;
        }
    }
    
    func addTurbineSet(numTurbines : Float, cutInWindSpeed : Float, ratedPowerWindSpeed : Float, ratedPower : Float) -> Void
    {
        let newTurbine = WindTurbine (cw : cutInWindSpeed, rpw : ratedPowerWindSpeed, rp : ratedPower)
        turbines.append(newTurbine)
        numOfTurbines.append(numTurbines)
    }
    
    override func reset() -> Void {
        turbines.removeAll()
        numOfTurbines.removeAll()
    }
}
