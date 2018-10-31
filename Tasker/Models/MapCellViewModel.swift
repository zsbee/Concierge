//
//  MapCellViewModel.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 26..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import Foundation
import MapKit

public class MapCellViewModel: CellModel {
    public static var identifier: String = "MAPCELL"
    public var id = MapCellViewModel.identifier

    public let title: String
    public let summary: String
    public var coordinates: CLLocationCoordinate2D

    public init(title: String, summary: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.summary = summary
        self.coordinates = coordinates
    }
    
    public func objectAsDictionary() -> [String: AnyObject] {
        var dict = [String:AnyObject]()
        
        dict["title"] = self.title as AnyObject?
        dict["summary"] = self.summary as AnyObject?
        dict["location"] = self.locationDictionary() as AnyObject?
        
        return dict;
    }
    
    private func locationDictionary() -> [String:AnyObject] {
        var dict = [String:AnyObject]()
        
        dict["latitude"] = self.coordinates.latitude as AnyObject?
        dict["longitude"] = self.coordinates.longitude as AnyObject?
        
        return dict
    }
    
    
}
