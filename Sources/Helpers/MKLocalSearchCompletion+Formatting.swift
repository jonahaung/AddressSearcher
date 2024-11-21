//
//  MKLocalSearchCompletion+Formatting.swift
//  AddressSearchExample
//
//  Created by Aung Ko Min on 21/11/24.
//

import SwiftUI
import MapKit

@available(macOS 12, *)
extension MKLocalSearchCompletion {
    private func createHighlightedString(text: String, rangeValues: [NSValue]) -> AttributedString {
#if os(iOS)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.blue, .paragraphStyle: NSMutableParagraphStyle.wordWrappingLineBreak]
#elseif os(macOS)
        let attributes = [NSAttributedString.Key.foregroundColor: NSColor.blue, .paragraphStyle: NSMutableParagraphStyle.wordWrappingLineBreak]
#endif
        
        let highlightedString = NSMutableAttributedString(string: text)
        
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
