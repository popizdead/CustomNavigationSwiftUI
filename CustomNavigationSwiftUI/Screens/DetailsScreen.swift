//
//  DetailsScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 18/09/2021.
//

import SwiftUI
import Networking
import SDWebImageSwiftUI

struct DetailsScreen : View {
    
    @EnvironmentObject var detailModel : DetailModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    VStack {
                        if let art = detailModel.reviewArt,
                           let url = art.webImage?.url {
                            
                            ArtImageView(url: url)
                                .padding()
                            
                            ArtDescription(art: art)
                                .padding()
                        }
                    }
                }
            }
            
            
            Spacer()
            Spacer()
            Divider()
            
            PopButton(dest: .previous, Label: {
                Text("Close")
            }, action: {})
        }
        
        
    }
}

struct ArtDescription: View {
    var art: ArtObject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text(art.title)
                .fontWeight(.semibold)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
                .font(.headline)
            Text(art.longTitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            if let longDescription = art.plaqueDescriptionEnglish {
                Text(longDescription)
                    .font(.body)
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(alignment: .center)
            }
            
        })
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 10)
           .stroke(Color.black.opacity(0.2), lineWidth: 1)
        )
        .background(
           RoundedRectangle(
             cornerRadius: 10
           )
           .foregroundColor(Color.white)
           .shadow(
             color: Color.secondary,
             radius: 5,
             x: 0,
             y: 0
           )
        )
    }
}

struct ArtImageView: View {
    
    var url: String
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .scaledToFit()
            .frame(height: 300, alignment: .center)
            .padding()
            .overlay(
              RoundedRectangle(cornerRadius: 10)
               .stroke(Color.black.opacity(0.2), lineWidth: 1)
            )
            .background(
               RoundedRectangle(
                 cornerRadius: 10
               )
               .foregroundColor(Color.white)
               .shadow(
                 color: Color.secondary,
                 radius: 5,
                 x: 0,
                 y: 0
               )
            )
    }
}
