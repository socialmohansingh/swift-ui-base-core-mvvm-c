//  String.swift
//  Created by bemohansingh on 11/12/2021.


import Foundation
import UIKit

public extension String {
    
    /// Trims the leading and trailing whitespaces
    var trim: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Method to covert a String into attributed string
    /// - Parameters:
    ///   - font: The font attribute
    ///   - color: The color attribute
    ///   - underlined: Should the text be underlined
    ///   - alignment: The alignment attribute
    ///   - lineSpacing: The line spacing of the text
    ///   - strike: The strike throught text if true
    /// - Returns: NSMutableAttributedString
    func attributed(font: UIFont = UIFont.systemFont(ofSize: 15.0),
                    color: UIColor = .white,
                    underlined: Bool = false,
                    alignment: NSTextAlignment = .left,
                    lineSpacing: CGFloat? = nil,
                    strike: Bool = false) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        if let spacing = lineSpacing {
            paragraphStyle.lineSpacing = spacing
        }
       
        var attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, .paragraphStyle: paragraphStyle]
        
        if underlined {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        if strike {
            attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }
    
        let attributedText = NSMutableAttributedString(string: self, attributes: attributes)
        return attributedText
    }
}
