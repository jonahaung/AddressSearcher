//
//  MKPointOfInterestCategory+Extension.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//

import Foundation
import MapKit

public extension MKPointOfInterestCategory {
    
    @available(macOS 15.0, *)
    static let travelPointsOfInterest: [MKPointOfInterestCategory] = [
        // Places to eat, drink, and be merry.
        .bakery,
        .brewery,
        .cafe,
        .distillery,
        .restaurant,
        .winery,
        
        // Places to stay.
        .campground,
        .hotel,
        .rvPark,
        
        // Places to go.
        .beach,
        .castle,
        .conventionCenter,
        .fairground,
        .fortress,
        .nationalMonument,
        .nationalPark,
        .planetarium,
        .spa,
        .zoo
    ]
    
    static let defaultPointOfInterestSymbolName = "mappin.and.ellipse"
    
    var symbolName: String {
        if #available(macOS 15.0, *) {
            switch self {
            case .airport:
                return "airplane"
            case .atm, .bank:
                return "banknote"
            case .bakery, .brewery, .cafe, .distillery, .foodMarket, .restaurant, .winery:
                return "fork.knife"
            case .beach:
                return "beach.umbrella"
            case .campground, .hotel:
                return "bed.double"
            case .carRental, .evCharger, .gasStation, .parking:
                return "car"
            case .store:
                return "storefront"
            case .library, .museum, .school, .theater, .university:
                return "building.columns"
            case .nationalMonument, .nationalPark, .park:
                return "leaf"
            case .postOffice:
                return "envelope"
            case .publicTransport:
                return "bus"
            case .zoo:
                return "bird"
            default:
                return MKPointOfInterestCategory.defaultPointOfInterestSymbolName
            }
        } else {
            switch self {
            case .airport:
                return "airplane"
            case .atm, .bank:
                return "banknote"
            case .bakery, .brewery, .cafe, .foodMarket, .restaurant, .winery:
                return "fork.knife"
            case .beach:
                return "beach.umbrella"
            case .campground, .hotel:
                return "bed.double"
            case .carRental, .evCharger, .gasStation, .parking:
                return "car"
            case .store:
                return "storefront"
            case .library, .museum, .school, .theater, .university:
                return "building.columns"
            case .nationalPark, .park:
                return "leaf"
            case .postOffice:
                return "envelope"
            case .publicTransport:
                return "bus"
            case .zoo:
                return "bird"
            default:
                return MKPointOfInterestCategory.defaultPointOfInterestSymbolName
            }
        }
    }
}
