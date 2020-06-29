//
//  ComorbityView.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

struct ComorbityView: View {
    let comorbity: Comorbity
    
    var body: some View {
        Text(comorbity.name)
            .font(.subheadline)
            .foregroundColor(Color(.label))
            .padding(4)
            .background(Color(.secondarySystemFill))
            .cornerRadius(4)
            .colorMultiply(comorbity.severity.color)
    }
}
