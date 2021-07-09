//
//  CountryListManager.swift
//  RebtelCountryList
//
//  Created by Deepak Kumar Dash (Digital) on 08/07/21.
//

import UIKit
import Alamofire
import FlagKit

public class CountryListManager {
    
    // MARK: - Properties
    static public let shared = CountryListManager()
    
    // MARK: -
    public var countries: [Country] = []
    
    // Initialization
    init() {
    }
    
    public func getCountry(completion: @escaping ([String]) -> ()) {
        let url: String = "https://restcountries.eu/rest/v2/all"
        AF.request(url).responseJSON { (responseData) -> Void in
            print(responseData.result)
            do {
                guard let data = responseData.data else { return }
                let res  = try JSONDecoder().decode([CountryName].self,from:data)
                completion(self.getCountryName(countryName: res))
            }
            catch {
                print(error)
            }
        }
    }
    
    struct CountryName: Codable {
        let alpha2Code: String
    }
    
    private func getCountryName(countryName:[CountryName]) -> [String]{
        var country:[String]  = []
        for index in 0...countryName.count - 1{
            country.append(countryName[index].alpha2Code)
        }
        return country
    }
    
    
    private func locale(for fullCountryName : String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
    
    func getCountries1(completion: @escaping ([Country]) -> ()) {
        var countriesArr: [Country] = []
        let _: () = getCountry { result in
            
            for code in result as [String] {
                let localeIdentifier = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: localeIdentifier) ?? "Error: Country not found for code: \(code)"
                
                let locale = NSLocale(localeIdentifier: localeIdentifier)
                let currencyCode =  locale.object(forKey: NSLocale.Key.currencySymbol)
                let flag = Flag(countryCode: code)
                
                // Retrieve the unstyled image for customized use
                let iconConfig = UIImage.SymbolConfiguration(scale: .large)
                let gearIcon = UIImage(systemName: "flag", withConfiguration: iconConfig)
                
                let originalImage = flag?.originalImage ?? gearIcon
                // let originalImage = flag?.image(style: .circle) ?? gearIcon
                let country = Country(countryCode: currencyCode as! String, name: name, localeId: localeIdentifier, countryFlagImage: originalImage! )
                countriesArr.append(country)
            }
            countriesArr = countriesArr.sorted(by: {$0.name < $1.name})
            
            // Add index according to the sorted array positioning
            var flagIndex: Int = 0
            for country in countriesArr {
                country.index = flagIndex
                flagIndex += 1
            }
            print(countriesArr)
            completion(countriesArr)
        }
    }
}
