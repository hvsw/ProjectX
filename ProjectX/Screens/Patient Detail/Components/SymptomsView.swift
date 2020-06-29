//
//  SymptonsView.swift
//  ProjectX
//
//  Created by William Hass on 2020-06-29.
//

import SwiftUI

struct Symptom: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let count: Int
}

struct SymptomsView: View {
    let symptoms: [Symptom] = (1...6).map { num -> Symptom in
        switch num {
        case 1:
            return Symptom(
                imageName: "",
                name: "Ansiedade",
                count: 6
            )
        case 2:
            return Symptom(
                imageName: "",
                name: "Falta de apetite",
                count: 6
            )
        case 3:
            return Symptom(
                imageName: "",
                name: "Pânico",
                count: 6
            )
        case 4:
            return Symptom(
                imageName: "",
                name: "Dor de cabeça",
                count: 6
            )
        case 5:
            return Symptom(
                imageName: "",
                name: "Tristeza",
                count: 6
            )
        case 6:
            return Symptom(
                imageName: "",
                name: "Insônia",
                count: 6
            )
        default:
            return Symptom(
                imageName: "",
                name: "Item \(num)",
                count: 6
            )
        }
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
//        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(symptoms) { symptom in
                    SymptomCardView(symptom: symptom)
                }
                Button(action: {}) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .padding(.vertical, 16)
                            .font(.largeTitle)
                            .foregroundColor(Color(.label))
                        Spacer()
                    }
                    .card()
                }
            }
        }
    }
}


struct SymptonsView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomsView()
    }
}

struct SymptomHeader: View {
    let symptom: Symptom
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: "suit.heart.fill")
                .font(.caption)
            Text(symptom.name)
                .font(.caption).bold()
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
    }
}

struct SymptomComparisonView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: "arrow.up")
            Text("3% comparado a semana passada")
        }
        .font(.footnote)
    }
}

struct SymptomCountView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("6x").font(.title).bold()
            Spacer()
        }
    }
}

struct SymptomCardView: View {
    let symptom: Symptom

    var body: some View {
        HStack {
            VStack(spacing: 8) {
                SymptomHeader(symptom: symptom)
                VStack(spacing: 4) {
                    SymptomCountView()
                    SymptomComparisonView()
                }
            }
            Spacer()
        }
        .card()
    }
}
