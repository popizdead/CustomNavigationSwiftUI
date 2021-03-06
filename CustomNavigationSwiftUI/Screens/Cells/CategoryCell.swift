//
//  CategoryCell.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 20/09/2021.
//

import SwiftUI
import Networking

struct CategoryCell: View {
    @EnvironmentObject var categoryModel: CategoriesModel
    @EnvironmentObject var segmentionRouter: SegmentionRouter
    
    @State var isAnimated: Bool = false
    
    var category: Facet
    
    var body: some View {
        PushButton(dest: ArtsListScreen().environmentObject(categoryModel).environmentObject(segmentionRouter), Label: {
            Text(category.key)
        }, action: {
            segmentionRouter.lastItemAppeared = category.id
            
            showAnimation()
            getCategoryItems()
        })
        .modifier(TransitionEffect(x: isAnimated ? 500 : 0, y: isAnimated ? 100 : 0))
    }
    
    private func showAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            isAnimated = true
        }
    }
    
    private func getCategoryItems() {
        categoryModel.currentSearch = category.key
        categoryModel.getSearchRequest()
    }
}
