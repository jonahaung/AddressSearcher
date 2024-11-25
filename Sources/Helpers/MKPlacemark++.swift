//
//  /Users/aungkomin/Library/Mobile Documents/com~apple~CloudDocs/Documents/Personal/Packages/AddressSearcher/Sources/Helpers/MKPlacemark++.swift++.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//

import MapKit
import Contacts

public extension MKPlacemark {
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress).replacingOccurrences(of: "\n", with: " ")
    }
}
