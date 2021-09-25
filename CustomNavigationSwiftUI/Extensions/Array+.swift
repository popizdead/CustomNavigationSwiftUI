//
//  Array+.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import Networking

extension Array {
    func cleanFromOptionalFacet() -> [Facet]? {
        guard let array = self as? [Facet] else { return nil }
        
        let cleaned = array.filter({
            $0.key.contains("?") == false && $0.key.contains("anon") == false
        })
        return cleaned
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {
    
    public func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
    
}

//Little trick to fix bug with duplicated items
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
