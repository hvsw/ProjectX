//
//  Patient.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import SwiftUI

enum ComorbitySeverity {
    case veryLow, low, medium, high, veryHigh
    
    var color: Color {
        switch self {
        case .veryLow:
            return .blue
        case .low:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .orange
        case .veryHigh:
            return .red
        }
    }
}

struct Comorbity: Identifiable {
    let id: UUID
    let name: String
    let severity: ComorbitySeverity
}

struct Patient: Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let comorbities: [Comorbity]
    var imageName:String? {
        switch self.name {
        case "Camilla Romero":
            return "camilla"
        
        case "Guilherme Gades":
            return "gades"
            
        case "Henrique Valcanaia":
            return "henrique"
        
        case "William Hass":
            return "william"
        
        case "Steve Jobs":
            return "steve"
        
        case "Elon Musk":
            return "elon"
        
        default:
            return nil
        }
    }
}
