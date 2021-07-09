//
//  ViewController.swift
//  RebtelCountryList
//
//  Created by Deepak Kumar Dash (Digital) on 08/07/21.
//

import UIKit

class ViewController: UIViewController {
    let tableViewController = CountryPickerTableViewController(style: .plain)
    
    @IBOutlet weak var countryTxtFld: UITextField!
    @IBOutlet weak var countryFlagImgVw: UIImageView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Country Picker"
        
        // CountryPickerTableViewDelegate
        tableViewController.delegate = self
        
        // TextFieldDelegate
        countryTxtFld.delegate = self
        
        // fetch a list of countries
        let countryListManager = CountryListManager.shared
        _ = countryListManager.countries
    }
}

extension ViewController: CountryPickerTableViewControllerDelegate {
    
    func didSelectCountry(country: Country?) {
        if country != nil {
            self.countryTxtFld.text = country?.name
            self.countryFlagImgVw.image = country?.flagImage
            self.countryCodeLbl.text = "Country Currency Symbol: \(country!.isoCountryCode)"
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.present(tableViewController, animated: true, completion: nil)
    }
}

