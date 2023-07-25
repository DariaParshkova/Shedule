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
    @Persisted var sheduleName : String = ""
    @Persisted var sheduleType : String = ""
    @Persisted var sheduleBuilding : String = ""
    @Persisted var sheduleAudience : String = ""
    @Persisted var sheduleTeacher : String = ""
    @Persisted var sheduleColor: String = R.Colors.yellow.hexValue
    @Persisted var sheduleRepeat : Bool = true
    @Persisted var sheduleWeekday : Int = 1
    
}
