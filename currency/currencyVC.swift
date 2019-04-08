//
//  ViewController.swift
//  currency
//
//  Created by Ali Burak Küçük on 8.04.2019.
//  Copyright © 2019 Ali Burak Küçük. All rights reserved.
//

import UIKit

class currencyVC: UIViewController {
    
    let label_1:UILabel = {
        let label_1 = UILabel()
        label_1.text = "user"
        label_1.backgroundColor = UIColor.white
        label_1.translatesAutoresizingMaskIntoConstraints = false
        return label_1
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(label_1)
        
        label_1.widthAnchor.constraint(equalTo: view.widthAnchor)
        label_1.heightAnchor.constraint(equalToConstant: 50)
        label_1.topAnchor.constraint(equalTo: view.topAnchor)
        label_1.layer.cornerRadius = 25
        
    }


}

