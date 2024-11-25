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
}
