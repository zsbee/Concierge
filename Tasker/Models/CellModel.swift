//
//  CellModel.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 31..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation

public protocol CellModel {
    static var identifier: String {get}
    var id: String {get}
}
