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
    
    override func getAnnualPowerOutput() -> Float {
        return -1.0
    }
}
