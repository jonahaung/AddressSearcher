//
//  SwiftUIView.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 25/11/24.
//

import SwiftUI
import MapKit

public struct AddressSearchResultList: View {
    
    @State private var viewModel: AddressSearchViewModel
    private let onSelect: (MKMapItem) -> Void
    
    public init(
        searchText: DebouncedText,
        _ configuration: AddressSearchConfiguration = .shared,
        _ onSelect: @escaping (MKMapItem) -> Void
    ) {
        viewModel = .init(searchText: searchText, configuration)
        self.onSelect = onSelect
    }
    
    public var body: some View {
        List {
            Section {
                ForEach(viewModel.searchSuggestions) { suggestion in
                    Button {
                        viewModel.updateSearchResults(for: suggestion)
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19, height: 19)
                            Text(suggestion.highlightedTitleStringForDisplay)
                        }
                    }
                    .buttonStyle(.borderless)
                }
            }
            Section {
                ForEach(viewModel.results, id: \.self) { result in
                    Button {
                        onSelect(result)
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 19, height: 19)
                            Text(result.placemark.formattedAddress ?? result.description)
                        }
                    }
                    .buttonStyle(.borderless)
                }
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
