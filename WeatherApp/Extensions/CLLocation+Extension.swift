//
//  CLLocation+Extension.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import Foundation
import CoreLocation

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
