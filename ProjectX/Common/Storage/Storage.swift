//
//  Storage.swift
//  ProjectX
//
//  Created by Henrique Valcanaia on 2020-06-28.
//

import Foundation

struct Storage {
    static let comorbities = [
        Comorbity(id: UUID(), name: "Transtorno Bipolar", severity: .medium),
        Comorbity(id: UUID(), name: "Déficit de atenção", severity: .high),
        Comorbity(id: UUID(), name: "Pânico", severity: .low),
        Comorbity(id: UUID(), name: "Hiperatividade", severity: .veryHigh),
        Comorbity(id: UUID(), name: "Depressão", severity: .veryLow),
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
                       age: Int.random(in: 23...76),
                       comorbities: comorbities)
    }
    .sorted(\.name)
}
