//
//  Storage.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import Foundation

struct Storage {
    static let comorbities = [
        Comorbity(id: UUID(), name: "Obesidade", severity: .medium),
        Comorbity(id: UUID(), name: "Endocardite", severity: .high),
        Comorbity(id: UUID(), name: "Asma", severity: .low),
        Comorbity(id: UUID(), name: "Depressão", severity: .veryHigh),
        Comorbity(id: UUID(), name: "Alergia", severity: .veryLow),
    ]
    
    static let patients: [Patient] = [
        "Camilla Romero",
        "Guilherme Gades",
        "Henrique Valcanaia",
        "William Hass",
        "Steve Jobs",
        "Elon Musk",
        "Bill Gates",
    ]
    .map { (patientName: String) -> Patient in
        return Patient(id: UUID(),
                       name: patientName,
                       age: Int.random(in: 1...90),
                       comorbities: comorbities)
    }
    .sorted(\.name)
}
