//
//  CountryPickerTableViewController.swift
//  RebtelCountryList
//
//  Created by Deepak Kumar Dash (Digital) on 08/07/21.
//

import UIKit

public class CountryPickerTableViewController: UITableViewController {
    
    weak public var delegate: CountryPickerTableViewControllerDelegate?
    
    var countriesArr: [Country] = []
    
    
    override public func viewWillAppear(_ animated: Bool) {
        let countryListManager = CountryListManager.shared
        countryListManager.getCountries(){ (country : [Country]) in   // Object received from closure
            self.countriesArr = country
            DispatchQueue.main.async {
                //  Updating UI on main queue
                self.tableView.reloadData()
            }
        }
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesArr.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let country: Country = self.countriesArr[indexPath.row]
        cell.textLabel?.text = country.name
        cell.imageView?.image = country.flagImage
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please select the country for currency Info"
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country = self.countriesArr[indexPath.row]
        delegate?.didSelectCountry(country: selectedCountry)
        self.dismiss(animated: true, completion: nil)
    }
    
}

