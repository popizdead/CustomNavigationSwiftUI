//
//  ContentView.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

struct SegmentionController: View {
    @State var segmentionChoise = 0
    
    private var screensTitle : [String] = ["Amsterdam Museum", "Home screen"]
    
    var body: some View {
        ScrollView {
            VStack {
                Picker("Options", selection: $segmentionChoise) {
                    ForEach(0 ..< screensTitle.count) { index in
                        Text(self.screensTitle[index])
                            .tag(index)
                    }
                    
                }.pickerStyle(SegmentedPickerStyle())
                
                if segmentionChoise == 0 {
                    AmsterdamHomeScreen()
                } else if segmentionChoise == 1 {
                    NavControllerView(transition: .custom(.present)) {
                        FirstScreen()
                    }
                    Spacer()
                }
            }
            .frame(minHeight: 1000)
        }
    }
}
