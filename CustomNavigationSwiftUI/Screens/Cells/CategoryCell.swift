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
    @State var isAnimated: Bool = false
    
    var category: Facet
    
    var body: some View {
        PushButton(dest: ArtsListScreen().environmentObject(categoryModel), Label: {
            HStack {
                Spacer()
                Text(category.key)
                Spacer()
            }
        }, action: {
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
        guard let searchRequest = category.key.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else { return }
        
        categoryModel.getSearchRequest(searchRequest)
    }
}
