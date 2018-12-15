//
//  TaskViewModel.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 29..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation
import MapKit

public class TaskViewModel: CellModel {
    public let models: [CellModel]
    public let pageTitle: String
    public static var identifier: String = "TASK_CARD_CELL"
    public var id = TaskViewModel.identifier
    
    public init(pageTitle: String, models: [CellModel]) {
        self.pageTitle = pageTitle
        self.models = models
    }
    
    public func taskDescription() -> String {
        var taskDesc = ""
        for model in models {
            if model.id == TaskDescriptionViewModel.identifier {
                if let taskModel = model as? TaskDescriptionViewModel {
                    taskDesc = taskModel.title
                }
            }
        }
        
        return taskDesc
    }
}
