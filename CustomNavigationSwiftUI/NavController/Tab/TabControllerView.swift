//
//  ContentView.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

struct TabControllerView: View {
    @EnvironmentObject var tabRouter: TabRouter
    
    var body: some View {
        TabView(selection: $tabRouter.selection) {
            AmsterdamHomeScreen()
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("Amsterdam")
                    }
                }
                .tag(1)
            
            NavControllerView(transition: .custom(.present)) {
                FirstScreen()
            }
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("First")
                    }
                }
                .tag(2)
            
            
        }
    }
}
