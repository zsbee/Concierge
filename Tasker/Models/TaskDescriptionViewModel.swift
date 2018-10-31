//
//  TaskDescriptionViewModel.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 31..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation

public class TaskDescriptionViewModel: CellModel {
    public static var identifier: String = "DESCRIPTIONCELL"
    public var id = TaskDescriptionViewModel.identifier
    public let placeHolder: String
    public let title: String
    
    public init(placeHolder: String, title: String) {
        self.placeHolder = placeHolder
        self.title = title
    }
    
    public func objectAsDictionary() -> [String: AnyObject] {
        var dict = [String:AnyObject]()
        
        dict["title"] = self.title as AnyObject?
        dict["placeholder"] = self.placeHolder as AnyObject?

        return dict;
    }
    
}
