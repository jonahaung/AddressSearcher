//
//  AddressSearchSettingsView++.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 25/11/24.
//
import SwiftUI

internal extension AddressSearchConfiguration.SearchResultType {
    var localizedLabel: LocalizedStringKey {
        switch self {
        case .addresses:
            "Addresses"
        case .pointsOfInterest:
            "Points of Interest"
        }
    }
}

internal extension AddressSearchConfiguration.RegionPriority {
    var localizedLabel: LocalizedStringKey {
        switch self {
        case .default:
            "Nearby"
        case .required:
            "Visible Map Only"
        }
    }
}

internal extension AddressSearchConfiguration.PointOfInterestOptions {
    var localizedLabel: LocalizedStringKey {
        switch self {
        case .excludeTravelCategories:
            "Exclude Travel Categories"
        case .includeTravelCategories:
            "Include Travel Categories"
        case .anyCategory:
            "Any Category"
        }
    }
}

internal extension AddressSearchConfiguration.AddressOptions {
    var localizedLabel: LocalizedStringKey {
        switch self {
        case .anyField:
            "Any Address Field"
        case .includeCityAndPostalCode:
            "City and Postal Code"
        }
    }
}
