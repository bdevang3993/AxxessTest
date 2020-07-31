//
//  ViewController.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblDisplay: UITableView!
    var objMainViewModel = MainViewModel()
    private let manager: ItemManager = ItemManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupgetData()
        
    }
    func setupgetData() {
        tblDisplay.delegate = self
        tblDisplay.dataSource = self
        tblDisplay.tableFooterView = UIView()
        
        objMainViewModel.apiFailedMessage = {[weak self] value in
            removeProgressHub()
          //  Alert().showAlert(message: kAppName, viewController: self!)
            DispatchQueue.main.async {
                self!.objMainViewModel.arrMainData = self!.manager.fetchItemList()
                self!.tblDisplay.reloadData()
            }
            
        }
        
        objMainViewModel.apisuccessMessage = {[weak self] value in
            removeProgressHub()
            if ksuccess == value {
                let deleteAllData = self!.manager.deleteAllData()
                if deleteAllData {
                    self!.objMainViewModel.arrMainData.forEach { (items) in
                        let itemListModel = MainModel(id: items.id, type: items.type, date: items.date, data: items.data)
                        self!.manager.createItem(items: itemListModel)
                    }
                    removeProgressHub()
                    DispatchQueue.main.async {
                        self!.tblDisplay.reloadData()
                    }
                }
                
            }
        }
        setProgressHub(view: self.view)
        objMainViewModel.getAllData()
    }

    @IBAction func btnSortClicked(_ sender: Any) {
        
    }
    
}

