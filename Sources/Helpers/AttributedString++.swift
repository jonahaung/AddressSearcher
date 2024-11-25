//
//  AttributedString++.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 22/11/24.
//
import SwiftUI

public extension AttributedString {
    var string: String {
        NSAttributedString(self).string
    }
}
