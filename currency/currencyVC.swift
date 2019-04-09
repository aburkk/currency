//
//  ViewController.swift
//  currency
//
//  Created by Ali Burak Küçük on 8.04.2019.
//  Copyright © 2019 Ali Burak Küçük. All rights reserved.
//

import UIKit


class currencyVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    

    // Functions are about picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        race = row
        print(race)
        let value = currency[race]
        print(value)
        activeCurrency = values[row]
    }
   
    // values are about dictionaries
    var currency : [String] = []
    var values : [Double] = []
    var activeCurrency: Double = 0
    var typePickerView: UIPickerView = UIPickerView()
    var race : Int = Int()
    
    
    
    
    let noteLabel:UILabel = {
        let noteLabel = UILabel()
        noteLabel.text = "  Important !!! : Data is Euro-based"
        noteLabel.textColor = UIColor.orange
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        return noteLabel
    }()
    let result:UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        result.font = UIFont(name: "HelveticaNeue-UltraLight",
                              size: 28.0)
        result.layer.borderColor = UIColor.black.cgColor
        result.layer.borderWidth = 1
        result.backgroundColor = UIColor.white
        return result
    }()
    
    
    let image_logo:UIImageView = {
        let image_logo = UIImageView()
        image_logo.layer.borderColor = UIColor.black.cgColor
        image_logo.layer.borderWidth = 1
        image_logo.image = UIImage(named: "rsz_global-currency-symbols")
        image_logo.translatesAutoresizingMaskIntoConstraints = false
        
        return image_logo
    }()
    
    let label_1:UITextView = {
        let label_1 = UITextView()
        label_1.backgroundColor = UIColor.white
        label_1.text = ""
        label_1.font = UIFont(name: "HelveticaNeue-UltraLight",
                                 size: 28.0)
        label_1.layer.borderColor = UIColor.black.cgColor
        label_1.layer.borderWidth = 1
        label_1.translatesAutoresizingMaskIntoConstraints = false
        return label_1
    }()
    let conert:UIButton = {
        let conert = UIButton(type: .system)
        conert.backgroundColor = UIColor.orange
        conert.translatesAutoresizingMaskIntoConstraints = false
        conert.setTitle("Convert!", for: .normal)
        
        conert.addTarget(self, action: #selector(convertClicked), for: .touchUpInside)
        return conert
    }()
    let history:UIButton = {
        let history = UIButton(type: .system)
        history.backgroundColor = UIColor.orange
        history.translatesAutoresizingMaskIntoConstraints = false
        history.setTitle("History!", for: .normal)
        
        history.addTarget(self, action: #selector(historyClicked), for: .touchUpInside)
        return history
    }()
    @objc func hidekeyboard(){
        self.view.endEditing(true)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(currencyVC.hidekeyboard))
        self.view.addGestureRecognizer(keyboardRecognizer)
       
       
        
        typePickerView.dataSource = self
        typePickerView.delegate = self
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=3a4f4c9f2f1f1be399f06a7ecf3b3529&format=1")
        let sessison = URLSession.shared
        let task = sessison.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true , completion: nil)
                
                
            }else {
                if data != nil{
                    do {
                        let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , AnyObject>
                        DispatchQueue.main.async {
                            let rates = jSONResult["rates"] as! [String : AnyObject]
                            for (key , value) in rates {
                                self.currency.append((key as? String)!)
                                self.values.append((value as? Double)!)
                            }
                           self.typePickerView.reloadAllComponents()
                        }
                        
                        
                        
                        
                    }catch{
                        print("Error!!!")
                    }
                }
                
            }
           
        }
        task.resume()
        
    
        let topColor = UIColor(red: 194/255, green: 229/255, blue: 156/255, alpha: 1).cgColor
        let botColor = UIColor(red: 100/255, green: 179/255, blue: 244/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, botColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.layer.frame
        self.view.layer.insertSublayer(gradientLayer, at: 0)
          view.addSubview(conert)
          view.addSubview(typePickerView)
          view.addSubview(label_1)
          view.addSubview(image_logo)
          view.addSubview(noteLabel)
          view.addSubview(result)
          view.addSubview(history)

        
        image_logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        image_logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image_logo.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image_logo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        image_logo.clipsToBounds = true
        image_logo.layer.cornerRadius = 40

        
        label_1.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        label_1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label_1.topAnchor.constraint(equalTo: image_logo.bottomAnchor, constant: 30).isActive = true
        label_1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label_1.clipsToBounds = true
        label_1.layer.cornerRadius = 25
        
        result.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        result.heightAnchor.constraint(equalToConstant: 50).isActive = true
        result.topAnchor.constraint(equalTo: typePickerView.bottomAnchor, constant: 30).isActive = true
        result.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        result.clipsToBounds = true
        result.layer.cornerRadius = 25
        
        conert.widthAnchor.constraint(equalToConstant: 100).isActive = true
        conert.heightAnchor.constraint(equalToConstant: 50).isActive = true
        conert.topAnchor.constraint(equalTo: result.bottomAnchor, constant: 30).isActive = true
        conert.centerXAnchor.constraint(equalTo: result.centerXAnchor, constant: 130).isActive = true
        
        conert.clipsToBounds = true
        conert.layer.cornerRadius = 15
        
        
        history.widthAnchor.constraint(equalToConstant: 100).isActive = true
        history.heightAnchor.constraint(equalToConstant: 50).isActive = true
        history.topAnchor.constraint(equalTo: result.bottomAnchor, constant: 30).isActive = true
        history.centerXAnchor.constraint(equalTo: result.centerXAnchor, constant: -130).isActive = true
        
        history.clipsToBounds = true
        history.layer.cornerRadius = 15
        
        typePickerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        typePickerView.topAnchor.constraint(equalTo: label_1.bottomAnchor, constant: 30).isActive = true
        typePickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        typePickerView.translatesAutoresizingMaskIntoConstraints = false

        //typePickerView.backgroundColor = UIColor.gray

        noteLabel.widthAnchor.constraint(equalTo: label_1.widthAnchor).isActive = true
        noteLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        noteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      

        
    }
    @objc func convertClicked() {
        if label_1 != nil {
        result.text = "\(String(Double(label_1.text)!*activeCurrency))"
       
        let test = currency[race]
        let test1 = result.text
        let test2 = label_1.text
        let defaults = UserDefaults.standard
        defaults.set(test, forKey: "Currency")
        defaults.set(test1, forKey: "results")
        defaults.set(test2, forKey: "EuroLabel")
//        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
//                print("\(key) = \(value) \n")
//            }
//
        
        
//        print("Euro:\(test2)")
//        print(test1)
//        print(test)
        
        
            
         }
        
        }
    @objc func historyClicked() {
        let segue = historyVC()
        self.present(segue, animated: true, completion: nil)
        
    }

 
}

