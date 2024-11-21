//
//  DebouncedText.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 22/11/24.
//
import SwiftUI
import Combine

public final class DebouncedText: ObservableObject {
    
    @Published public var text: String = ""
    public var onChange: ((String) -> Void)?
    private var canCelBag = Set<AnyCancellable>()

    public init() {}
    
    public init(_ seconds: TimeInterval = 0.2) {
        $text
            .removeDuplicates()
            .debounce(for: .seconds(seconds), scheduler: RunLoop.main)
            .sink { [weak self] value in
                guard let self else { return }
                self.onChange?(value)
            }
            .store(in: &canCelBag)
    }
}
