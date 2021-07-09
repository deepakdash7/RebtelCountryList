//
//  CountryPickerTableViewControllerDelegate.swift
//  RebtelCountryList
//
//  Created by Deepak Kumar Dash (Digital) on 08/07/21.
//

public protocol CountryPickerTableViewControllerDelegate: AnyObject {
    func didSelectCountry(country: Country?)
}
