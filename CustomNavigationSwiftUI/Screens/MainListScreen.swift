//
//  MainListScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 20/09/2021.
//

import SwiftUI
import Networking
import SDWebImageSwiftUI

struct MainListScreen: View {
    
    @ObservedObject var placesModel : CategoriesModel = .init(type: .places)
    @ObservedObject var authorsModel : CategoriesModel = .init(type: .authors)
    @ObservedObject var topItemsModel : TopItemModel = .init()
    
    @State var segmentionChoise = 0
    
    var screensTitle : [String] = ["Top", "Places", "Authors"]
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        if topItemsModel.topItemsList.count == 0 {
            VStack(alignment: .center) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            Spacer()
        } else {
            VStack {
                Picker("Options", selection: $segmentionChoise) {
                    ForEach(0 ..< screensTitle.count) { index in
                        Text(self.screensTitle[index])
                            .tag(index)
                    }
                    
                }.pickerStyle(SegmentedPickerStyle())
                
                
                List {
                    if segmentionChoise == 0 {
                        //Top items
                        ForEach(topItemsModel.topItemsList) { item in
                            TopItemsCell(item: item)
                                .environmentObject(topItemsModel)
                        }
                    }
                    else if segmentionChoise == 1 {
                        //Places
                        ForEach(placesModel.categoriesList) { place in
                            CategoryCell(category: place)
                                .environmentObject(placesModel)
                        }
                    }
                    else if segmentionChoise == 2 {
                        //Authors
                        ForEach(authorsModel.categoriesList) { author in
                            CategoryCell(category: author)
                                .environmentObject(authorsModel)
                        }
                    }
                }
                
            }
            
        }
    }
}

