//
//  TopItemsScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking
import SDWebImageSwiftUI

struct TopItemsScreen: View {
    
    var body: some View {
        NavControllerView(transition: .custom(.present)) {
            FirstTopScreen()
        }
    }
}

struct FirstTopScreen: View {
    
    @ObservedObject var sourceModel : TopItemModel = .init()
    
    var body: some View {
        List {
            ForEach(sourceModel.topItemsList) { item in
                TopItemCell(item: item)
                    .environmentObject(sourceModel)
            }
        }
    }
}

struct TopItemCell: View {
    @EnvironmentObject var dataSourceModel: TopItemModel
    @ObservedObject var detailsModel : DetailModel = .init()
    
    var item: ArtObject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            if let imgUrl = item.webImage?.url {
                WebImage(url: URL(string: imgUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }
            
            VStack(alignment: .leading, spacing: 5, content: {
                Text(item.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                Text(item.principalOrFirstMaker)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                PushButton(dest: DetailsScreen(reviewArt: item), Label: {
                    Text("Review")
                }, action: {})
            })
        })
        .onAppear() {
            if self.dataSourceModel.topItemsList.isLast(item) {
                dataSourceModel.requestNextTopPage()
            }
        }
        
        if self.dataSourceModel.topItemsList.isLast(item) && dataSourceModel.isPageLoading {
            VStack(alignment: .center) {
                Divider()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}
