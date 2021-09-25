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
    
    @EnvironmentObject var segmentionRouter: SegmentionRouter
    
    @ObservedObject var placesModel : CategoriesModel = .init(type: .places)
    @ObservedObject var authorsModel : CategoriesModel = .init(type: .authors)
    @ObservedObject var topItemsModel : TopItemModel = .init()
    
    var screensTitle : [String] = ["Top", "Places", "Authors"]
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        if isDataLoading() {
            loadingView()
            Spacer()
        } else {
            VStack {
                segmentionController()
                
                List {
                    if segmentionRouter.segmentionChoise == 0 {
                        //Top items
                        ForEach(topItemsModel.topItemsList) { item in
                            TopItemsCell(item: item)
                                .environmentObject(topItemsModel)
                        }
                    }
                    else if segmentionRouter.segmentionChoise == 1 {
                        //Places
                        ForEach(placesModel.categoriesList) { place in
                            CategoryCell(category: place)
                                .environmentObject(placesModel)
                        }
                    }
                    else if segmentionRouter.segmentionChoise == 2 {
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
    
    private func segmentionController() -> some View {
        Picker("Options", selection: $segmentionRouter.segmentionChoise) {
            ForEach(0 ..< screensTitle.count) { index in
                Text(self.screensTitle[index])
                    .tag(index)
            }
            
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    private func isDataLoading() -> Bool {
        return
            topItemsModel.topItemsList.count == 0
        ||
            authorsModel.categoriesList.count == 0
        ||
            placesModel.categoriesList.count == 0
    }
    
    private func loadingView() -> some View {
        VStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}

