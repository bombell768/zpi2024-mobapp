//
//  StarRatingView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 22/11/2024.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Double
    var maximumRating: Int = 5
    var filledStar = "star.fill"
    var halfFilledStar = "star.leadinghalf.filled"
    var emptyStar = "star"
    var starSize: CGFloat = 50

    @State private var isDragging = false

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...maximumRating, id: \.self) { index in
                let starValue = Double(index)
                let halfStarValue = starValue - 0.5

                Image(systemName:
                      rating >= starValue ? filledStar :
                      (rating >= halfStarValue ? halfFilledStar : emptyStar))
                    .resizable()
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(.yellow)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    isDragging = true
                    updateRating(from: value.location)
                }
                .onEnded { _ in
                    isDragging = false
                }
        )
        .frame(height: starSize)
        .contentShape(Rectangle())
    }

    private func updateRating(from location: CGPoint) {
        let starSlotWidth = starSize + 4
        let exactRating = location.x / starSlotWidth
        rating = max(0, min(Double(maximumRating), round(exactRating * 2) / 2))
    }
}



#Preview {
    StarRatingView(rating: .constant(3))
}
