//
//  AddressSearchViewModel.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//

import SwiftUI
import Combine
@preconcurrency import MapKit

@MainActor
@Observable
public final class AddressSearchViewModel {
    
    public var searchSuggestions = [SearchSuggestion]()
    public var results = [MKMapItem]()
    
    @ObservationIgnored private let datasource = AddressSearchDatasource(configuration: .init())
    @ObservationIgnored private var searchCompletionsTask: Task<Void, Never>?
    @ObservationIgnored public var debouncedText = DebouncedText()
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []
    public init() {
        debouncedText.$text
            .removeDuplicates()
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .sink { [weak self] value in
                guard let self else { return }
                self.updateSearchResults(for: value)
            }.store(in: &cancellables)
    }
}

extension AddressSearchViewModel {
    public func startGeneratingSearchCompletions() {
        let searchCompletionStream = AsyncStream<[MKLocalSearchCompletion]>.makeStream()
        datasource.startProvidingSearchCompletions(with: searchCompletionStream.continuation)
        searchCompletionsTask = searchCompletionsTask ?? Task { @MainActor in
            for await searchCompletions in searchCompletionStream.stream {
                let suggestions = searchCompletions.map { completion in
                    let suggestion = SearchSuggestion(highlightedTitleStringForDisplay: completion.highlightedTitleStringForDisplay, completion: completion)
                    return suggestion
                }
                self.searchSuggestions = suggestions
            }
        }
    }
    public func stopGeneratingSearchCompletions() {
        datasource.stopProvidingSearchCompletions()
        searchCompletionsTask?.cancel()
        searchCompletionsTask = nil
    }
}

extension AddressSearchViewModel {
    private func displaySearchResults(_ results: [MKMapItem]) {
        self.results = results
    }
    private func updateSearchResults(for text: String) {
        displaySearchResults([])
        datasource.provideCompletionSuggestions(for: text)
    }
    public func updateSearchResults(for searchSuggestion: SearchSuggestion) {
        let completion = searchSuggestion.completion
        stopGeneratingSearchCompletions()
        debouncedText.text = completion.title
        Task {
            let searchResults = await datasource.search(for: completion)
            self.searchSuggestions = []
            displaySearchResults(searchResults)
            startGeneratingSearchCompletions()
        }
    }
    public func searchButtonClicked() {
        Task {
            stopGeneratingSearchCompletions()
            searchSuggestions.removeAll()
            let text = debouncedText.text
            let searchResults = await datasource.search(for: text)
            displaySearchResults(searchResults)
        }
    }
}
