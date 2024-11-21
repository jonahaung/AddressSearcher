//
//  NSMutableParagraphStyle++.swift
//  AddressSearcher
//
//  Created by Aung Ko Min on 22/11/24.
//
import Foundation
import AppKit

public extension NSMutableParagraphStyle {
    nonisolated(unsafe) static let wordWrappingLineBreak: NSMutableParagraphStyle = {
        $0.lineBreakMode = .byCharWrapping
        $0.alignment = .justified
        return $0
    }(NSMutableParagraphStyle())
}
