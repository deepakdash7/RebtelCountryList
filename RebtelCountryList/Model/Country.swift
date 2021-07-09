//
//  Country.swift
//  RebtelCountryList
//
//  Created by Deepak Kumar Dash (Digital) on 08/07/21.
//

import UIKit

public class Country: NSObject {
    public var isoCountryCode: String = ""
    public var name: String = ""
    public var localeId: String = ""
    public var index: Int = -1
    public var flagImage = UIImage()
    
    public var flagImageName: String? {
        get {
            let imageName = name.replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: "’", with: "")
                .lowercased()
            
            return imageName
        }
        set {
        }
    }
    
    public init(countryCode: String, name: String, localeId: String, countryFlagImage: UIImage) {
        self.isoCountryCode = countryCode
        self.name = name
        self.localeId = localeId
        self.flagImage = countryFlagImage
    }
    
    public override var description: String {
        return "\n{\n index: \(self.index),\n"
            + " country: \(self.name),\n"
            + " isoCountryCode: \(self.isoCountryCode),\n"
            + " localeId: \(self.localeId),\n"
            + " flagImageName: \(self.flagImageName!)\n}"
    }
}
