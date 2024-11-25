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
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Button {
                            viewModel.updateSearchResults(for: suggestion)
                        } label: {
                            Text(suggestion.highlightedTitleStringForDisplay)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            Section {
                ForEach(viewModel.results, id: \.self) { result in
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text(result.placemark.formattedAddress ?? result.description)
                    }
                }
            }
        }
        .buttonStyle(.plain)
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
