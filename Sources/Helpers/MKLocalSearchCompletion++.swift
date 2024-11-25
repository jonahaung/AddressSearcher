//
//  MKLocalSearchCompletion++.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//

import SwiftUI
import MapKit

public extension MKLocalSearchCompletion {
    private func createHighlightedString(text: String, rangeValues: [NSValue]) -> AttributedString {
#if os(iOS)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue, .paragraphStyle: NSMutableParagraphStyle.wordWrappingLineBreak, .font: UIFont.systemFontSize(of: UIFont.labelFontSize, weight: .medium)]
#elseif os(macOS)
        let attributes = [NSAttributedString.Key.foregroundColor: NSColor.blue, .paragraphStyle: NSMutableParagraphStyle.wordWrappingLineBreak]
#endif
#if os(iOS)
        let highlightedString = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFontSize(of: UIFont.labelFontSize)])
#elseif os(macOS)
        let highlightedString = NSMutableAttributedString(string: text)
#endif
        let ranges = rangeValues.map { $0.rangeValue }
        for range in ranges {
            highlightedString.addAttributes(attributes, range: range)
        }
        return .init(highlightedString)
    }
    
    var highlightedTitleStringForDisplay: AttributedString {
        return createHighlightedString(text: title, rangeValues: titleHighlightRanges)
    }
    
    var highlightedSubtitleStringForDisplay: AttributedString {
        return createHighlightedString(text: subtitle, rangeValues: subtitleHighlightRanges)
    }
}
