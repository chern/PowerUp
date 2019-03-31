import Foundation

class SolarPanel {
    init(perEff : Float, tempCoeff : Float, sa : Float, tAngle : Float)
    {
        self.percentEfficiency = perEff
        self.temperatureCoefficient = tempCoeff
        self.surfaceArea = sa
        self.tiltAngle = tAngle
    }
    var percentEfficiency : Float
    var temperatureCoefficient : Float
    var surfaceArea : Float
    var tiltAngle : Float
}

//func (lhs : WindTurbine, rhs : WindTurbine) -> Bool {
//    return lhs.ratedPower == rhs.ratedPower
//}
