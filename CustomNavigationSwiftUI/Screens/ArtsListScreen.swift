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
    
    var body: some View {
        VStack {
            PopButton(dest: .previous, Label: {
                Text("Back")
            }, action: {
                sourceModel.artObjectsList.removeAll()
            })
            List {
                ForEach(sourceModel.artObjectsList) { item in
                    ArtObjectCell(item: item)
                        .environmentObject(sourceModel)
                }
            }
            .onAppear {
                print("Appearing fucking screen")
            }
        }
    }
}

struct ArtObjectCell: View {
    @EnvironmentObject var dataSourceModel: CategoriesModel
    
    var item: ArtObject
    
    var body: some View {
        HStack(alignment: .center, spacing: 5, content: {
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
            })
        })
    }
}
