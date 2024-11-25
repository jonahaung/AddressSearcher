//
//  AddressSearchConfiguration.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//


import Foundation
import MapKit
import SwiftUI

@Observable public  class AddressSearchConfiguration {
    public enum RegionPriority: CaseIterable {
        case `default`
        case required
        
        public var localSearchRegionPriority: MKLocalSearchRegionPriority {
            switch self {
            case .default:
                MKLocalSearchRegionPriority.default
            case .required:
                MKLocalSearchRegionPriority.required
            }
        }
    }
    public enum SearchResultType: CaseIterable {
        case addresses
        case pointsOfInterest
        public var completionResultType: MKLocalSearchCompleter.ResultType {
            switch self {
            case .addresses:
                MKLocalSearchCompleter.ResultType.address
            case .pointsOfInterest:
                MKLocalSearchCompleter.ResultType.pointOfInterest
            }
        }
        
        public var localSearchResultType: MKLocalSearch.ResultType {
            switch self {
            case .addresses:
                MKLocalSearch.ResultType.address
            case .pointsOfInterest:
                MKLocalSearch.ResultType.pointOfInterest
            }
        }
    }
    public enum PointOfInterestOptions: CaseIterable {
        case includeTravelCategories
        case excludeTravelCategories
        case anyCategory
        
        public var filter: MKPointOfInterestFilter? {
            switch self {
            case .includeTravelCategories:
                MKPointOfInterestFilter(including: MKPointOfInterestCategory.travelPointsOfInterest)
            case .excludeTravelCategories:
                MKPointOfInterestFilter(excluding: MKPointOfInterestCategory.travelPointsOfInterest)
            case .anyCategory:
                nil
            }
        }
        
        public var categories: PointOfInterestCategories {
            switch self {
            case .includeTravelCategories:
                PointOfInterestCategories.including(MKPointOfInterestCategory.travelPointsOfInterest)
            case .excludeTravelCategories:
                PointOfInterestCategories.excluding(MKPointOfInterestCategory.travelPointsOfInterest)
            case .anyCategory:
                PointOfInterestCategories.all
            }
        }
    }
    
    public enum AddressOptions: CaseIterable {
        case anyField
        case includeCityAndPostalCode
        
        public var filter: MKAddressFilter {
            switch self {
            case .anyField:
                return MKAddressFilter.includingAll
            case .includeCityAndPostalCode:
                return MKAddressFilter(including: [.locality, .postalCode, .subLocality])
            }
        }
    }
    
    public var resultType: SearchResultType = .pointsOfInterest
    public var pointOfInterestOptions: PointOfInterestOptions = .anyCategory
    public var addressOptions: AddressOptions = .anyField
    public var region: MKCoordinateRegion = MKCoordinateRegion.init(center: .init(latitude: 1.38, longitude: 103.78), latitudinalMeters: 50 * 1000, longitudinalMeters: 28 * 1000)
    public var regionPriority: RegionPriority = .required
}
