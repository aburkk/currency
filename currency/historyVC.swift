//
//  historyVC.swift
//  currency
//
//  Created by Ali Burak Küçük on 9.04.2019.
//  Copyright © 2019 Ali Burak Küçük. All rights reserved.
//

import UIKit

class historyVC: UITableViewController {
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            print("\(key) = \(value) \n")
        }
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        view.addSubview(navBar)
        navBar.backgroundColor = UIColor(red: 194/255, green: 229/255, blue: 156/255, alpha: 1)
        let navItem = UINavigationItem(title: "Transection History")
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(doneClicked))
        navItem.rightBarButtonItem = doneItem
        
        let clearItem = UIBarButtonItem(title: "Clear", style: .plain, target: #selector(doneClicked), action: nil)
        navItem.leftBarButtonItem = clearItem
        
        navBar.setItems([navItem], animated: false)
       
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    @objc func doneClicked() {
        let segue = currencyVC()
        self.present(segue, animated: true, completion: nil)
    }
  
  
}
