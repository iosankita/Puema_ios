//
//  SelectPlaceTypeVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SelectPlaceTypeVC: UIViewController {
    
    //MARK:- IBOUTLETS
     @IBOutlet weak var customNav: CustomNavigationView!
     @IBOutlet weak var yourRouteTableview: UITableView!
     @IBOutlet weak var placesTableView: UITableView!
   
        
      let cellId = "CustomListCell"
      let routeCellId = "routeTableCell"
      var viewModel = CityDiscoverVM()
      let placesModel = CityDiscoverDataSourceModel()
      
    
    //MARK:- VIEW LIFE CYCLE
     override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        registerCellForRoute()
        customNav.delegate = self
     }
            
        
     private func registerCell() {
        self.placesTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.placesTableView.dataSource = self.viewModel.tableDataSource
        self.viewModel.selectionCallback = { (type) in
                    self.handleSelection(with: type)
        }
    }
        
     private func registerCellForRoute() {
               self.yourRouteTableview.register(UINib(nibName: routeCellId, bundle: nil), forCellReuseIdentifier: routeCellId)
              
        }
    
            
    private func handleSelection(with type: CityDiscoverType) {
                switch type {
                case .restaurants:
                    print(type.rawValue)
                case .cinemaTheater:
                    print(type.rawValue)
                case .museums:
                    print(type.rawValue)
                case .shoppingCenters:
                    print(type.rawValue)
                case .sights:
                    print(type.rawValue)
                case .funPlace:
                    print(type.rawValue)
                }
            }
        }

   //MARK:- CustomNavigationViewDelegate
   extension SelectPlaceTypeVC: CustomNavigationViewDelegate {
            func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
               self.navigationController?.popViewController(animated: true)
            }
    }
