//
//  TaskViewModel.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 29..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation
import MapKit

public class TaskViewModel {
    public let models: [CellModel]
    public let pageTitle: String
    
    public init(pageTitle: String, models: [CellModel]) {
        self.pageTitle = pageTitle
        self.models = models
    }
}
