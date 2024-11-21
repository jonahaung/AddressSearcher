//
//  AttributedString++.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 22/11/24.
//
import SwiftUI

@available(macOS 12, *)
public extension AttributedString {
    var string: String {
        NSAttributedString(self).string
    }
}
