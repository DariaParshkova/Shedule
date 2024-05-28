//
//  TaskModel.swift
//  Shedule
//
//  Created by Parshkova Daria on 28.07.2021.
//

import RealmSwift
class TaskModel: Object {
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescriptionName: String = "Unknown"
    @Persisted var taskColor: String = R.Colors.yellow.hexValue
    @Persisted var taskReady: Bool = false
}
