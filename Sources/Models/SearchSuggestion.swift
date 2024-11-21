//
//  AddressSearchCompletion.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//

import Foundation
@preconcurrency import MapKit

@available(macOS 12, *)
public struct SearchSuggestion: Sendable, Identifiable, Hashable {
    public var id: String { highlightedTitleStringForDisplay.string }
    public let highlightedTitleStringForDisplay: AttributedString
    public let completion: MKLocalSearchCompletion
    
    public init(highlightedTitleStringForDisplay: AttributedString, completion: MKLocalSearchCompletion) {
        self.highlightedTitleStringForDisplay = highlightedTitleStringForDisplay
        self.completion = completion
    }
}
