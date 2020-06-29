//
//  ViewModifiers.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

struct ListSeparatorStyle: ViewModifier {
    
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorColor = .clear
                UITableView.appearance().separatorStyle = self.style
            }
            .onDisappear {
                UITableView.appearance().separatorStyle = .singleLine
            }
    }
}

extension View {
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}
