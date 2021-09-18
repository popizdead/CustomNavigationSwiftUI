//
//  TopItemsScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking

struct TopItemsScreen: View {
    
    @EnvironmentObject var sourceModel : DataSourceModel
    
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
    @EnvironmentObject var dataSourceModel: DataSourceModel
    
    var item: ArtObject
    
    var body: some View {
        VStack {
            Text(item.title)
                .padding(.leading)
            Text(item.principalOrFirstMaker)
                .padding(.leading)
        }
        .padding(.leading)
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
