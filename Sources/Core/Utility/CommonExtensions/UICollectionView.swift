//
//  UICollectionView.swift
//  
//
//  Created by bemohansingh on 06/12/2021.
//

import Foundation
import UIKit

public enum ElementKind {
    case header
    case footer
    
    public var name: String {
        switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
        }
    }
}

public extension UICollectionView {
    
    /// register class for a cell.
    ///
    /// - Parameter cellType: cell to register
    func registerClass<C>(_ cell: C.Type) where C: UICollectionViewCell {
        self.register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    /// Register a view as supllimentary view for UICOllectionView
    /// - Parameters:
    ///   - view: the UICollectionReusableView subclass
    ///   - viewKind: the kind to register as e.g UICollectionView.elementKindSectionFooter
    func registerSupplimentaryViewClass<C>(_ view: C.Type, viewKind kind: ElementKind) where C: UICollectionReusableView {
        self.register(view, forSupplementaryViewOfKind: kind.name, withReuseIdentifier: view.identifier)
    }
}
