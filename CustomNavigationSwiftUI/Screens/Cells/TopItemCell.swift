//
//  TopItemCell.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 20/09/2021.
//

import SwiftUI
import Networking
import SDWebImageSwiftUI

//MARK:-TOP ART CELL
struct TopItemsCell: View {
    @EnvironmentObject var dataSourceModel: TopItemModel
    @EnvironmentObject var segmentionRouter: SegmentionRouter
    
    @ObservedObject var detailsModel : DetailModel = .init()
    @State var isAnimated: Bool = false
    
    var item: ArtObject
    
    var body: some View {
        PushButton(dest: DetailsScreen().environmentObject(detailsModel), Label: {
            VStack(alignment: .center, spacing: 5, content: {
                if let imgUrl = item.webImage?.url {
                    itemImg(url: imgUrl)
                }
                
                itemInfo()
            })
            .padding()
        }, action: {
            segmentionRouter.lastItemAppeared = item.id
            
            showAnimation()
            getItemData()
        })
        .onAppear() {
            if self.dataSourceModel.topItemsList.isLast(item) {
                dataSourceModel.requestNextTopPage()
            }
            
        }
        .modifier(TransitionEffect(x: isAnimated ? 500 : 0, y: isAnimated ? 100 : 0))
        
        
        if self.isLastItem() {
            loadingView()
        }
    }
    
    private func showAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            isAnimated = true
        }
    }
    
    //ITEM INFO
    private func getItemData() {
        guard let id = item.objectNumber else { return }
        detailsModel.requestForObject(id)
    }
    
    private func itemImg(url: String) -> some View {
        HStack {
            Spacer()
            WebImage(url: URL(string: url))
                .resizable()
                .scaledToFit()
                .frame(height: 150, alignment: .center)
            Spacer()
        }
    }
    
    private func itemInfo() -> some View {
        VStack(alignment: .center, spacing: 5, content: {
            Text(item.title)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
            Text(item.principalOrFirstMaker)
                .font(.subheadline)
                .foregroundColor(.secondary)
        })
    }
    
    
    //PAGING
    private func isLastItem() -> Bool {
        return self.dataSourceModel.topItemsList.isLast(item) && dataSourceModel.isPageLoading
    }
    
    private func loadingView() -> some View {
        VStack(alignment: .center) {
            Divider()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}

//MARK:-ART LIST CELL

struct ArtObjectCell: View {
    @EnvironmentObject var sourceModel: CategoriesModel
    @ObservedObject var detailsModel : DetailModel = .init()
    @EnvironmentObject var segmentionRouter: SegmentionRouter
    
    @State var isAnimated: Bool = false
    
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
            segmentionRouter.lastSearchArtAppeared = item.id
            
            showAnimation()
            getItemData()
        })
        .onAppear() {
            checkForNextPage()
        }
        .modifier(TransitionEffect(x: isAnimated ? 500 : 0, y: isAnimated ? 100 : 0))
        
        if self.sourceModel.artObjectsList.isLast(item) && sourceModel.isPageLoading {
            VStack(alignment: .center) {
                Divider()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
    }
    
    private func showAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            isAnimated = true
        }
    }
    
    private func getItemData() {
        guard let id = item.objectNumber else { return }
        detailsModel.requestForObject(id)
    }
    
    private func checkForNextPage() {
        if self.sourceModel.artObjectsList.isLast(item) {
            sourceModel.requestNextPage()
        }
    }
}
