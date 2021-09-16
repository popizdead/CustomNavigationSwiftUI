//
//  CustomNavigationController.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

//MARK:-PUBLIC
public struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject private var viewModel: NavControllerViewModel
    private var transition: (push: AnyTransition, pop: AnyTransition)
    private let content: Content
    
    public init(transition: NavTransition, easing: Animation = .easeOut(duration: 0.33), @ViewBuilder content: @escaping () -> Content) {
        viewModel = NavControllerViewModel(easing: easing)
        self.content = content()
        
        switch transition {
        case .custom(let trans):
            self.transition = (trans, trans)
        case .none:
            self.transition = (.identity, .identity)
        }
    }
    
    public var body: some View {
        let isRoot = viewModel.currentScreen == nil
        
        return ZStack {
            if isRoot {
                content
                    .environmentObject(viewModel)
                    .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
            } else {
                if let currentScreen = viewModel.currentScreen {
                    currentScreen.nextScreen
                        .environmentObject(viewModel)
                        .transition(viewModel.navigationType == .push ? transition.push : transition.pop)
                }
            }
        }
    }
    
}



public struct PushButton<Label, Destination>: View where Label: View, Destination: View {
    
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let destination: Destination
    private let label: Label
    
    init(dest: Destination, @ViewBuilder Label: @escaping () -> Label) {
        self.destination = dest
        self.label = Label()
    }
    
    public var body: some View {
        label.onTapGesture {
            viewModel.push(destination)
        }
    }
}

public struct PopButton<Label>: View where Label: View {
    
    @EnvironmentObject private var viewModel: NavControllerViewModel
    
    private let popDestination: PopDestination
    private let label: Label
    
    init(dest: PopDestination, @ViewBuilder Label: @escaping () -> Label) {
        self.popDestination = dest
        self.label = Label()
    }
    
    public var body: some View {
        label.onTapGesture {
            viewModel.pop(to: popDestination)
        }
    }
}


//MARK:-PRIVATE
final class NavControllerViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    
    private let easing: Animation
    var navigationType = NavType.push
    
    private var screenStack = ScreenStack() {
        didSet {
            currentScreen = screenStack.top()
        }
    }
    
    init(easing: Animation) {
        self.easing = easing
    }
    
    func push<S: View>(_ screenView: S) {
        navigationType = .push
        
        withAnimation(easing) {
            let screen = Screen(id: UUID().uuidString, nextScreen: AnyView(screenView))
            screenStack.push(screen)
        }
    }
    
    func pop(to: PopDestination) {
        navigationType = .pop
        
        withAnimation(easing) {
            switch to {
            case .root:
                screenStack.popToRoot()
            case .previous:
                screenStack.pop()
            }
        }
    }
}
//MARK:-ENUM

enum PopDestination {
    case previous
    case root
}

public enum NavType {
    case push
    case pop
}

public enum NavTransition {
    case none
    case custom(AnyTransition)
}

//MARK:-NAVIGATION LOGIC
private struct ScreenStack {
    
    private var screens: [Screen] = .init()
    
    func top() -> Screen? {
        screens.last
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func pop() {
        _ = screens.popLast()
    }
    
    mutating func popToRoot() {
        screens.removeAll()
    }
}

//MARK:-SCREEN
struct Screen: Equatable, Identifiable {
    
    let id: String
    let nextScreen: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
