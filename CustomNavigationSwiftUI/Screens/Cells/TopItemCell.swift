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
        PushButton(dest: DetailsScreen().environmentObject(detailsModel), Label: {
            VStack(alignment: .center, spacing: 5, content: {
                if let imgUrl = item.webImage?.url {
                    //Image
                    HStack {
                        Spacer()
                        WebImage(url: URL(string: imgUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150, alignment: .center)
                        Spacer()
                    }
                }
                
                VStack(alignment: .center, spacing: 5, content: {
                    //Item description
                    Text(item.title)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                    Text(item.principalOrFirstMaker)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                })
            })
            .padding()
        }, action: {
            //Get data of cell item
            guard let id = item.objectNumber else { return }
            detailsModel.requestForObject(id)
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
