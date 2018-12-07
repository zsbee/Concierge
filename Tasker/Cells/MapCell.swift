//
//  MapCell.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 26..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import UIKit
import MapKit
import Backpack

class MapCell: BaseCell, MKMapViewDelegate {
    
    let mapView = MKMapView()
    let label = Label(fontStyle: .textBase)
    let refreshButton = Button(size: .default, style: .secondary)
    var pin:UIImageView!

    var model:MapCellViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        self.createViews()
        self.addViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        label.numberOfLines = 1
        
        refreshButton.setImage(Icon.makeIcon(name: .refresh, color: .black, size: .small))
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        refreshButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        refreshButton.setContentHuggingPriority(.required, for: .horizontal)

        pin = UIImageView(image: Icon.makeIcon(name: .cityCenter, color: Color.red500, size: .large))
        
        mapView.delegate = self
        mapView.layer.cornerRadius = 24
    }
    
    @objc func refreshTapped(sender: UIButton!) {
        mapView.removeAnnotations(mapView.annotations)
        getAddressFor(coordinates: mapView.centerCoordinate) { (addressString) in
            self.label.text = addressString
            
            // create annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = self.mapView.centerCoordinate
            annotation.title = addressString
            self.mapView.addAnnotation(annotation)
        }
    }
    
    public func setModel(model: MapCellViewModel) {
        label.text = model.title;
        
        mapView.setCenter(model.coordinates, animated: false)
        let viewRegion = MKCoordinateRegion(center: model.coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(viewRegion, animated: true)
        
        getAddressFor(coordinates: model.coordinates) { (addressString) in
            self.label.text = addressString
        }
        
        self.createConstraints()
    }
    

    func createConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false;
        mapView.translatesAutoresizingMaskIntoConstraints = false;
        refreshButton.translatesAutoresizingMaskIntoConstraints = false;
        pin.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
            mapView.heightAnchor.constraint(equalToConstant: 150),
            mapView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -BPKSpacingBase),
            
            pin.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            pin.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -10),

            label.centerYAnchor.constraint(equalTo: refreshButton.centerYAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: BPKSpacingSm),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -BPKSpacingBase),
            
            refreshButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: BPKSpacingSm),
            refreshButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: BPKSpacingBase),
            refreshButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -BPKSpacingMd),
            ])
    }
    
    func addViews() {
        self.contentView.addSubview(mapView)
        self.contentView.addSubview(label)
        self.contentView.addSubview(refreshButton)
        self.contentView.addSubview(pin)
    }
    
    
    func getAddressFor(coordinates: CLLocationCoordinate2D, callback:@escaping ((String) -> Void)) {
        var addressString = ""
        let loc = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(loc) { (placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            if let pms = placemarks {
                if pms.count > 0 {
                    let pm = placemarks![0]
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + " "
                    }
                    if pm.subThoroughfare != nil {
                        addressString = addressString + pm.subThoroughfare! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                }
                callback(addressString)
            }
        }
    }
}
