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
            VStack {
                List {
                    ForEach(sourceModel.artObjectsList) { item in
                        ArtObjectCell(item: item)
                    }
                }
                .onAppear {
                    print("Appearing fucking screen")
                }
            }
            
            Spacer()
            Spacer()
            Divider()
            
            PopButton(dest: .previous, Label: {
                Text("Close")
            }, action: {
                sourceModel.artObjectsList.removeAll()
            })
        }
    }
}

struct ArtObjectCell: View {
    @EnvironmentObject var sourceModel: CategoriesModel
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
            if self.sourceModel.artObjectsList.isLast(item) {
                sourceModel.requestNextPage()
            }
        }
        if self.sourceModel.artObjectsList.isLast(item) && sourceModel.isPageLoading {
            VStack(alignment: .center) {
                Divider()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}
