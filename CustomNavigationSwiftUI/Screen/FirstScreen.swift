//
//  FirstScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

struct FirstScreen: View {
    var body: some View {
        VStack {
            PushButton(dest: SecondsScreen()) {
                Text("To 2")
                    .padding()
                    .background(Color.green)
            }
        }
    }
}

struct SecondsScreen: View {
    var body: some View {
        VStack {
            PushButton(dest: ThirdScreen()) {
                Text("To 3")
                    .padding()
                    .background(Color.green)
            }
            
            PopButton(dest: .previous) {
                Text("To 1")
                    .padding()
                    .background(Color.green)
            }
        }
    }
}

struct ThirdScreen: View {
    var body: some View {
        VStack {
            PopButton(dest: .previous) {
                Text("To 2")
                    .padding()
                    .background(Color.green)
            }
            
            PopButton(dest: .root) {
                Text("To 1")
                    .padding()
                    .background(Color.green)
            }
        }
    }
}
