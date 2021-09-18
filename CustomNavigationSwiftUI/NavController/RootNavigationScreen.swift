//
//  RootNavigationScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI

struct RootNavigationController: View {
    @State var segmentionChoise = 0
    
    private var screensTitle : [String] = ["Top", "Places", "Authors"]
    
    
    var body: some View {
        VStack {
            Picker("Options", selection: $segmentionChoise) {
                ForEach(0 ..< screensTitle.count) { index in
                    Text(self.screensTitle[index])
                        .tag(index)
                }
                
            }.pickerStyle(SegmentedPickerStyle())
            
            if segmentionChoise == 0 {
                TopItemsScreen()
            }
            else if segmentionChoise == 1 {
                PlacesListScreen()
            }
            else if segmentionChoise == 2 {
                AuthorsScreen()
            }
        }
    }
}
