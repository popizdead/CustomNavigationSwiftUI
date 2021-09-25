//
//  ArtsListScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Networking

struct ArtsListScreen: View {
    
    @EnvironmentObject var sourceModel : CategoriesModel
    @EnvironmentObject var segmentionRouter: SegmentionRouter
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Text(sourceModel.currentSearch)
                        .font(.headline)
                    Spacer()
                }
                if sourceModel.artObjectsList.count == 0 {
                    Text("No data")
                        .font(.system(size: 30))
                } else {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(sourceModel.artObjectsList) { item in
                                ArtObjectCell(item: item)
                            }
                        }
                        .onAppear() {
                            proxy.scrollTo(segmentionRouter.lastSearchArtAppeared)
                        }
                    }
                }
            }
            
            Spacer()
            Spacer()
            Divider()
            
            PopButton(dest: .previous, Label: {
                Text("Close")
                    .font(.headline)
            }, action: {
                sourceModel.artObjectsList.removeAll()
            })
        }
    }
}


