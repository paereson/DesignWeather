//
//  ViewEx.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 27/11/2022.
//

import SwiftUI

extension View {
    func backgroundBlur(radius: CGFloat = 3, opague: Bool = false) -> some View {
        self
            .background(
            Blur(radius: radius, opaque: opague)
            )
    }
    
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blur: CGFloat = 4, blendMode: BlendMode = .normal, opacity: Double = 1) -> some View {
        return self
            .overlay {
                shape
                    .stroke(color ,lineWidth: lineWidth)
                    .blendMode(blendMode)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: blur)
                    .mask(shape)
                    .opacity(opacity)
            }
    }
}

