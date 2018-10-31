//
//  NewTaskViewController.swift
//  Tasker
//
//  Created by Zsombor Fuszenecker on 2018. 10. 17..
//  Copyright © 2018. ZsomborFuszenceker. All rights reserved.
//

import UIKit
import Backpack
import MapKit

class NewTaskViewController: UIViewController, NewTaskHeaderCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let closeButton = Button(size: .large, style: .link)
    var collectionView: UICollectionView!
    var taskModel: TaskViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.createViews()
        self.addViews()
        
        self.createDummyModel()
    }

    func createViews() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false;
        closeButton.setImage(Icon.makeIcon(name: .nativeiOSClose, color: .black, size: .large))
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.backgroundColor = UIColor.white;
        closeButton.layer.cornerRadius = 16;
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = BPKSpacingSm
        layout.minimumLineSpacing = BPKSpacingSm
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        //collectionView.isPrefetchingEnabled = false
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(NewTaskHeaderCell.self, forCellWithReuseIdentifier: "header")
        collectionView.register(MapCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.register(DescriptionInputCell.self, forCellWithReuseIdentifier: "description")

    }
    
    func addViews() {
        self.view.addSubview(collectionView)
        self.view.addSubview(closeButton)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskModel.models.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model:CellModel = taskModel.models[indexPath.row]

        if (model.id == HeaderModel.identifier) {
            let headerCell: NewTaskHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath) as! NewTaskHeaderCell
            headerCell.setModel(model: model as! HeaderModel)
            headerCell.delegate = self
            return headerCell
        } else if (model.id == MapCellViewModel.identifier) {
            let cell: MapCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! MapCell
            cell.setModel(model: model as! MapCellViewModel)
            return cell
        } else if (model.id == TaskDescriptionViewModel.identifier) {
            let cell: DescriptionInputCell = collectionView.dequeueReusableCell(withReuseIdentifier: "description", for: indexPath) as! DescriptionInputCell
            cell.setModel(model: model as! TaskDescriptionViewModel)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model:CellModel = taskModel.models[indexPath.row]
        var h:CGFloat = 0
        let w:CGFloat = self.view.frame.width

        if (model.id == HeaderModel.identifier) {
            h = 75
        } else if (model.id == MapCellViewModel.identifier) {
            h = 350
        } else if (model.id == TaskDescriptionViewModel.identifier)  {
            h = 300
        }
        
        return CGSize(width: w, height: h)
    }
    
    @objc func closeTapped(sender: UIButton!) {
        let dialogController = DialogController(title: "Discard", message: "Are you sure you would like to discard?", style: .alert, iconBackgroundColor: Color.red500, iconImage: Icon.makeIcon(name: .trash, color: .white, size: .large))
        
        let discardAction = DialogButtonAction(title: "Discard", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelAction = DialogButtonAction(title: "Cancel", style: .link) { (action) in
            
        }
        
        let faderAction = DialogScrimAction(handler: { (scrim) in
            //
        }, shouldDismiss: true)
        
        dialogController.addButtonAction(discardAction)
        dialogController.addButtonAction(cancelAction)
        dialogController.scrimAction = faderAction
        
        self.present(dialogController, animated: true, completion: nil)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let topMargin =  self.view.safeAreaInsets.top + BPKSpacingMd;
        let bottomMargin =  self.view.safeAreaInsets.bottom;

        NSLayoutConstraint.activate([
                closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -BPKSpacingBase),
                closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topMargin + BPKSpacingMd),
                closeButton.widthAnchor.constraint(equalToConstant: 32),
                closeButton.heightAnchor.constraint(equalToConstant: 32),
            
                collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                collectionView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: BPKSpacingMd),
                collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomMargin)
            ]);
    }
 
    
    func createDummyModel() {
        taskModel = TaskViewModel(pageTitle: "undefined", models: [
            HeaderModel(title: "Feladat leírás"),
            TaskDescriptionViewModel(placeHolder: "Kérlek írd le a lehető legpontosabban hogy mi lesz a feladat...", title: ""),
            HeaderModel(title: "Honnan"),
            MapCellViewModel(title: "Egyéb info:", summary: "trallala", coordinates: CLLocationCoordinate2D(latitude: 47.492973, longitude: 19.073773)),
            HeaderModel(title: "Hova"),
            MapCellViewModel(title: "Egyéb info:", summary: "trallala", coordinates: CLLocationCoordinate2D(latitude: 47.492973, longitude: 19.073773)),
            HeaderModel(title: "Határidő"),
            MapCellViewModel(title: "Egyéb info:", summary: "trallala", coordinates: CLLocationCoordinate2D(latitude: 47.492973, longitude: 19.073773)),
            HeaderModel(title: "Fizetés"),
            MapCellViewModel(title: "Egyéb info:", summary: "trallala", coordinates: CLLocationCoordinate2D(latitude: 47.492973, longitude: 19.073773))
            ]);
        collectionView.reloadData()
    }
    
    func header_deleteTappedWithModel(model: HeaderModel) {
        print("discard " + model.title)
    }
    
}

