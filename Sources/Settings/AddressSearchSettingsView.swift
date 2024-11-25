//
//  SwiftUIView.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 25/11/24.
//

import SwiftUI

public struct AddressSearchSettingsView: View {
    
    @Bindable var searchConfiguration: AddressSearchConfiguration
    @Environment(\.dismiss) private var dismissAction
    var hostedDismissHandler: (() -> Void)?
    
    public init(searchConfiguration: AddressSearchConfiguration, hostedDismissHandler: ( () -> Void)? = nil) {
        self.searchConfiguration = searchConfiguration
        self.hostedDismissHandler = hostedDismissHandler
    }
    
    public var body: some View {
        Form {
            Section {
                Picker("Search For", selection: $searchConfiguration.resultType) {
                    ForEach(AddressSearchConfiguration.SearchResultType.allCases, id: \.self) { option in
                        Text(option.localizedLabel)
                    }
                }
                Picker("Search Region", selection: $searchConfiguration.regionPriority) {
                    ForEach(AddressSearchConfiguration.RegionPriority.allCases, id: \.self) { option in
                        Text(option.localizedLabel)
                    }
                }
            }
            Section(header: Text("Points of Interest")) {
                Picker("Category", selection: $searchConfiguration.pointOfInterestOptions) {
                    ForEach(AddressSearchConfiguration.PointOfInterestOptions.allCases, id: \.self) { option in
                        Text(option.localizedLabel)
                    }
                }
            }
            Section(header: Text("Address Search")) {
                Picker("Address Component", selection: $searchConfiguration.addressOptions) {
                    ForEach(AddressSearchConfiguration.AddressOptions.allCases, id: \.self) { option in
                        Text(option.localizedLabel)
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            Button("Done") {
                dismissAction()
            }
            .bold()
        }
        .onDisappear {
            if let hostedDismissHandler {
                hostedDismissHandler()
            }
        }
    }
}
