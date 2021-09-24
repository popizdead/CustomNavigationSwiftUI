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
    
    //MARK:-ITEM INFO
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
    
    
    //MARK:-PAGING
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
