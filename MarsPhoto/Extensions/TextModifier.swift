//
//  TextModifier.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 24.08.2024.
//

import SwiftUI

struct TextModifier: ViewModifier {
    private let size: CGFloat
    private let color: Color
    private let fontStyle: Font?

    init(
        size: CGFloat,
        color: Color,
        fontStyle: Font? = nil
    ) {
        self.size = size
        self.color = color
        self.fontStyle = fontStyle
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom("SF Pro", size: size))
            .foregroundStyle(Color(color))
            .font(fontStyle)
            .lineSpacing(21)
            .kerning(-0.4)
            .multilineTextAlignment(.leading)
        
    }
}

extension View {
    func modificateText(
        color: Color,
        size: CGFloat,
        fontStyle: Font? = nil
    ) -> some View {
        modifier(
            TextModifier(
                size: size,
                color: color,
                fontStyle: fontStyle
            )
        )
    }
}
