//
//  VariationCard.swift
//  DemoKetch
//
//  Created by Diwakar Bisht on 27/07/25.
//


import SwiftUI

struct VariationCard: View {
    let item: FlatVariationItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: "https://pictures.kartmax.in/cover/live/600x800/quality=6/sites/aPfvUDpPwMn1ZadNKhP7/product-images/HLSH022876_3.JPG" )) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.2).frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Color.gray.frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }

                if let fit = item.fit {
                    Text(fit)
                        .font(.caption2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 6)
                        .background(Color.black)
                        .cornerRadius(4)
                        .rotationEffect(.degrees(90))
                        .offset(
                            x: fit == "Slim Fit" ? 130 :
                               fit == "Relaxed Fit" ? 120 :
                               fit == "Regular Fit" ? 120 : 115,
                            y: 80
                        )
                }
            }
            
            HStack {
                Text(item.brand ?? "")
                    .font(.footnote)
                    .bold()
            }
            
            Text(item.name)
                .font(.footnote)
                .lineLimit(1)
            
            HStack(spacing: 4) {
                if let sellingPrice = item.sellingPrice {
                    Text("₹\(sellingPrice)")
                        .font(.subheadline)
                }
                if let price = item.price {
                    Text("₹\(price)")
                        .font(.footnote)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
                if let discount = item.discount {
                    Text("(\(discount)% OFF)")
                        .font(.caption)
                        .foregroundColor(.red)
                        .bold()
                }
            }
        }
        .padding(6)
    }
}
