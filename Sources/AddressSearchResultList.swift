//
//  SwiftUIView.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 25/11/24.
//

import SwiftUI

public struct AddressSearchResultList: View {
    
    @State private var viewModel: AddressSearchViewModel
    
    public init(searchText: DebouncedText, _ configuration: AddressSearchConfiguration = .shared) {
        viewModel = .init(searchText: searchText, configuration)
    }
    
    public var body: some View {
        List {
            ForEach(viewModel.searchSuggestions) { suggestion in
                Text(suggestion.highlightedTitleStringForDisplay)
                    .onTapGesture {
                        viewModel.updateSearchResults(for: suggestion)
                    }
            }
            ForEach(viewModel.results, id: \.self) { result in
                Text(result.placemark.formattedAddress ?? result.description)
            }
        }
        .onAppear {
            viewModel.startGeneratingSearchCompletions()
        }
        .onDisappear {
            viewModel.startGeneratingSearchCompletions()
        }
        .onSubmit(of: .search) {
            viewModel.searchButtonClicked()
        }
    }
}
