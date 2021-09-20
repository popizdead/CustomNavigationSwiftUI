//
//  TopItemCell.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 20/09/2021.
//

import SwiftUI
import Networking
import SDWebImageSwiftUI

struct TopItemsCell: View {
    @EnvironmentObject var dataSourceModel: TopItemModel
    @ObservedObject var detailsModel : DetailModel = .init()
    
    var item: ArtObject
    
    var body: some View {
        PushButton(dest: DetailsScreen(reviewArt: item), Label: {
            VStack(alignment: .leading, spacing: 5, content: {
                if let imgUrl = item.webImage?.url {
                    WebImage(url: URL(string: imgUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150, alignment: .center)
                }
                
                VStack(alignment: .leading, spacing: 5, content: {
                    Text(item.title)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    Text(item.principalOrFirstMaker)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                })
            })
        }, action: {})
        
        
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
