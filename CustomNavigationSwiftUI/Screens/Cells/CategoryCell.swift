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
    
    var category: Facet
    
    var body: some View {
        PushButton(dest: ArtsListScreen().environmentObject(categoryModel), Label: {
            HStack {
                Spacer()
                Text(category.key)
                Spacer()
            }
        }, action: {
            guard let searchRequest = category.key.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) else { return }
            
            categoryModel.getSearchRequest(searchRequest)
        })
    }
}
