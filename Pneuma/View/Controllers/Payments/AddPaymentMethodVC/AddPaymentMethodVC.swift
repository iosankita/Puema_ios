//
//  AddPaymentMethodVC.swift
//  Pneuma
//
//  Created by Jatin on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AddPaymentMethodVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - VARIABLES
    private let cellIdentifier = "AddPaymentMethodCollectionCell"
    let viewModel = AddPaymentMethodVM()
    
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupCollectionView() {
        self.registerNib()
        self.collectionView.dataSource = self.viewModel.collectionDataSource
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: self.cellIdentifier)
    }

}
