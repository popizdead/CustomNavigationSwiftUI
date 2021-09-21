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
    
    @State private var animate = false
    
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
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                self.animate = true
            }
        }
        .modifier(MyEffect(x: animate ? 0 : 500, y: animate ? 0 : 100))
        
        
        if self.dataSourceModel.topItemsList.isLast(item) && dataSourceModel.isPageLoading {
            VStack(alignment: .center) {
                Divider()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
}

struct MyEffect: GeometryEffect {
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    var animatableData: CGFloat {
        get {
            x
        }
        set {
            x = newValue
            y = newValue
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: x, y: y))
    }
}
