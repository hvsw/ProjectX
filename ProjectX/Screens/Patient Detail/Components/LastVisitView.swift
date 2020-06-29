//
//  LastVisitView.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

struct LastVisitView: View {
    
    let date: String = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        let daysInSeconds = Int.random(in: 0...30)
        let newDate = Date().addingTimeInterval(-Double(daysInSeconds*60*60*24))
        
        return formatter.string(from: newDate)
    }()
    
    var body: some View {
        HStack(spacing: 4) {
            Text(date)
                .font(.caption2)
                .foregroundColor(Color(.secondaryLabel))
            
            Image(systemName: "info.circle")
                .font(.caption)
                .foregroundColor(Color(.secondaryLabel))
        }
    }
}

struct LastVisitView_Previews: PreviewProvider {
    static var previews: some View {
        LastVisitView()
    }
}
