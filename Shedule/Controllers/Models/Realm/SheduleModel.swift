//
//  SheduleModel.swift
//  Shedule
//
//  Created by Parshkova Daria on 20.07.2023.
//
import RealmSwift

class SheduleModel: Object {
    @Persisted var sheduleDate = Date()
    @Persisted var sheduleTime = Date()
    @Persisted var sheduleName : String = "Unknown"
    @Persisted var sheduleType : String = "Unknown"
    @Persisted var sheduleBuilding : String = "Unknown"
    @Persisted var sheduleAudience : String = "Unknown"
    @Persisted var sheduleTeacher : String = "Unknown"
    @Persisted var sheduleColor: String = R.Colors.yellow.hexValue
    @Persisted var sheduleRepeat : Bool = true
    @Persisted var sheduleWeekday : Int = 1
    
}
