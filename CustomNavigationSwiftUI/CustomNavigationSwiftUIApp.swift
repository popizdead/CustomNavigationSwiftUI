//
//  CustomNavigationSwiftUIApp.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

@main
struct CustomNavigationSwiftUIApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavControllerView(transition: .custom(.present), content: {
                MainListScreen().environmentObject(SegmentionRouter.init())
            })
        }
    }
}

