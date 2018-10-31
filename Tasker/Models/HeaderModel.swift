//
//  HeaderModel.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 31..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation
import MapKit

public class HeaderModel: CellModel {
    public let title: String
    public static var identifier: String = "HEADERCELL"
    public var id = HeaderModel.identifier
    
    public init(title: String) {
        self.title = title
    }
    
    public func objectAsDictionary() -> [String: AnyObject] {
        var dict = [String:AnyObject]()
        
        dict["title"] = self.title as AnyObject?
        
        return dict;
    }
}
