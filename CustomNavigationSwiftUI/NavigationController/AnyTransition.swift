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


struct TransitionEffect: GeometryEffect {
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    var animatableData: CGFloat {
        get {
            x
        }
        set {
            x = newValue
            y = newValue
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: x, y: y))
    }
}
