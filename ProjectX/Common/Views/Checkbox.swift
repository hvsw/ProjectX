//
//  Checkbox.swift
//  GroceriesTracker
//
//  Created by William Hass on 2020-06-14.
//  Copyright © 2020 Camililo. All rights reserved.
//

import SwiftUI

struct Checkbox: View {
    @Binding var marked: Bool
    var body: some View {
        Button(action: { self.marked.toggle() } ) {
            ZStack {
                Circle()
                    .stroke(lineWidth: 0.5)
                    .stroke(Color(marked ? .systemBlue : .lightGray))
                    .frame(width: 24, height: 24)
                    .background(Color.clear)
                if marked {
                    Color(.systemBlue)
                        .font(.footnote)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(.systemBackground))
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
            .frame(width: 22, height: 22)
        }
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Checkbox(marked: .constant(true))
            Checkbox(marked: .constant(false))
        }
    }
}
