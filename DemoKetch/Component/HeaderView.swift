//
//  HeaderView.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 27/07/25.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: DemoKetchViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Casual Shirts For Men")
                    .font(.headline)
                Spacer()
                Image(systemName: "magnifyingglass")
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "heart")
                    Circle().fill(Color.black).frame(width: 14, height: 14)
                        .overlay(Text("0").font(.system(size: 10)).foregroundColor(.white))
                }
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bag")
                    Circle().fill(Color.black).frame(width: 14, height: 14)
                        .overlay(Text("0").font(.system(size: 10)).foregroundColor(.white))
                }
            }
            .padding(.horizontal)
            
            Text("\(viewModel.totalItemCount) items")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
