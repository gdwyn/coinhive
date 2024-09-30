//
//  Sparkline.swift
//  coinhive
//
//  Created by Godwin IE on 29/09/2024.
//

import SwiftUI

struct SparklineView: View {
    let sparkline: [Double]
    var maxVisiblePoints: Int = 50
    var lineColor: Color

    @State private var progress: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                guard sparkline.count > 1 else { return }

                let height = geometry.size.height
                let width = geometry.size.width
                let maxPrice = sparkline.max() ?? 1
                let minPrice = sparkline.min() ?? 0

                // Calculate the xStep and yRatio based on the visible points
                let visiblePoints = min(sparkline.count, maxVisiblePoints)
                let xStep = width / CGFloat(visiblePoints - 1)
                let yRatio = height / CGFloat(maxPrice - minPrice)

                // Move to the first point
                let firstPoint = CGPoint(x: 0, y: height - CGFloat((sparkline.first! - minPrice)) * yRatio)
                path.move(to: firstPoint)

                // Iterate over points and create the line using smoothing
                for index in 1..<visiblePoints - 1 {
                    let currentPoint = CGPoint(
                        x: CGFloat(index) * xStep,
                        y: height - CGFloat((sparkline[index] - minPrice)) * yRatio
                    )
                    let nextPoint = CGPoint(
                        x: CGFloat(index + 1) * xStep,
                        y: height - CGFloat((sparkline[index + 1] - minPrice)) * yRatio
                    )

                    // Midpoint smoothing
                    let controlPoint = CGPoint(
                        x: (currentPoint.x + nextPoint.x) / 2,
                        y: (currentPoint.y + nextPoint.y) / 2
                    )

                    path.addQuadCurve(to: controlPoint, control: currentPoint)
                }
            }
            .trim(from: 0, to: progress)
            .stroke(lineColor, lineWidth: 1)
            .onAppear {
                withAnimation(.easeInOut(duration: 2)) {
                    progress = 1.0
                }
            }
        }
        .clipped()
        .padding(.horizontal, 0)
    }
}
