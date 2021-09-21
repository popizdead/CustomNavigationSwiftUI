//
//  AnyTransition.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

extension AnyTransition {
    
    static var present: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        
        return asymmetric(insertion: insertion, removal: removal)
    }
    
}
