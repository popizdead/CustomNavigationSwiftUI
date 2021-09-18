//
//  AmsterdamHomeScreen.swift
//  CustomNavigationSwiftUI
//
//  Created by Даниил Дорожкин on 16/09/2021.
//

import SwiftUI
import Alamofire

struct AmsterdamHomeScreen: View {
    var body: some View {
        Button("Download data", action: {
            request()
        })
    }
}

func request() {
    AF.request("https://www.rijksmuseum.nl/api/en/collection?key=s4QQN2YY").responseJSON { data in
        print(data.result)
    }
}

