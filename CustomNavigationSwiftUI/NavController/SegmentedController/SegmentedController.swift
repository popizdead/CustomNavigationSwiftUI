//
//  ContentView.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI

struct SegmentionController: View {
    @State var segmentionChoise = 0
    
    private var screensTitle : [String] = ["Top", "Places", "Authors"]
    private var facetsModel = DataSourceModel()
    
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
                    .environmentObject(facetsModel)
            }
            else if segmentionChoise == 1 {
                PlacesListScreen()
                    .environmentObject(facetsModel)
            } else if segmentionChoise == 2 {
                AuthorsScreen()
                    .environmentObject(facetsModel)
                Spacer()
            }
        }
    }
}