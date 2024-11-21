//
//  AddressSearchDatasource.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//


import Foundation
@preconcurrency import MapKit
import OSLog
import SwiftUI
@available(macOS 15, *)

@MainActor
public final class AddressSearchDatasource: NSObject {
    
    private let searchLogging = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Search Completions")
    
    private let mapConfiguration: AddressSearchConfiguration
    private var searchCompleter: MKLocalSearchCompleter?
    private var resultStreamContinuation: AsyncStream<[MKLocalSearchCompletion]>.Continuation?
    private var currentSearch: MKLocalSearch?
    
    public init(configuration: AddressSearchConfiguration) {
        self.mapConfiguration = configuration
        super.init()
    }
    
    public func search(for completion: MKLocalSearchCompletion) async -> [MKMapItem] {
        let request = MKLocalSearch.Request(completion: completion)
        return await performSearch(request)
    }
    
    public func search(for queryString: String) async -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = queryString
        return await performSearch(request)
    }
    
    private func performSearch(_ request: MKLocalSearch.Request) async -> [MKMapItem] {
        currentSearch?.cancel()
        request.region = mapConfiguration.region
        request.resultTypes = mapConfiguration.resultType.localSearchResultType
        request.regionPriority = mapConfiguration.regionPriority.localSearchRegionPriority
        if mapConfiguration.resultType == .pointsOfInterest {
            request.pointOfInterestFilter = mapConfiguration.pointOfInterestOptions.filter
        } else if mapConfiguration.resultType == .addresses {
            request.addressFilter = mapConfiguration.addressOptions.filter
        }
        
        let search = MKLocalSearch(request: request)
        currentSearch = search
        defer {
            currentSearch = nil
        }
        var results: [MKMapItem]
        
        do {
            let response = try await search.start()
            results = response.mapItems
        } catch let error {
            searchLogging.error("Search error: \(error.localizedDescription)")
            results = []
        }
        
        return results
    }
    
    public func startProvidingSearchCompletions(with continuation: AsyncStream<[MKLocalSearchCompletion]>.Continuation) {
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        resultStreamContinuation = continuation
    }
    
    public func stopProvidingSearchCompletions() {
        searchCompleter = nil
        resultStreamContinuation?.finish()
        resultStreamContinuation = nil
    }
    
    public func provideCompletionSuggestions(for query: String) {
        searchCompleter?.resultTypes = mapConfiguration.resultType.completionResultType
        searchCompleter?.regionPriority = mapConfiguration.regionPriority.localSearchRegionPriority
        if mapConfiguration.resultType == .pointsOfInterest {
            searchCompleter?.pointOfInterestFilter = mapConfiguration.pointOfInterestOptions.filter
        } else if mapConfiguration.resultType == .addresses {
            searchCompleter?.addressFilter = mapConfiguration.addressOptions.filter
        }
        
        searchCompleter?.region = mapConfiguration.region
        searchCompleter?.queryFragment = query
    }
}
@available(macOS 15, *)
extension AddressSearchDatasource: @unchecked Sendable, MKLocalSearchCompleterDelegate {
    nonisolated public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task { @MainActor in
            let suggestedCompletions = completer.results
            resultStreamContinuation?.yield(suggestedCompletions)
        }
    }
    
    nonisolated public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        Task { @MainActor in
            searchLogging.error("Search completion failed for query \"\(completer.queryFragment)\". Reason: \(error.localizedDescription)")
            resultStreamContinuation?.yield([])
        }
    }
}
