//
//  SymptonsView.swift
//  ProjectX
//
//  Created by William Hass on 2020-06-29.
//

import SwiftUI

struct Symptom: Identifiable {
    enum Comparison {
        case increased(Int)
        case decreased(Int)

        private var percentage: String {
            switch self {
            case .increased(let amount):
                return "\(amount)%"
            case .decreased(let amount):
                return "\(amount)%"
            }
        }

        var description: String {
            return "\(percentage) comparado a semana passada"
        }
    }
    let id = UUID()
    let imageName: String
    let name: String
    let count: Int
    let comparison: Comparison
    let color: Color
}

extension Symptom.Comparison {
    var imageName: String {
        switch self {
        case .decreased:
            return "arrow.down"
        case .increased:
            return "arrow.up"
        }
    }
    var color: Color {
        switch self {
        case .decreased:
            return Color(.label)
        case .increased:
            return Color(.label)
        }
    }
}

struct SymptomsView: View {
    @State var showCreateTaskView: Bool = false
    let symptoms: [Symptom] = (1...6).map { num -> Symptom in
        switch num {
        case 1:
            return Symptom(
                imageName: "flame.fill",
                name: "Ansiedade",
                count: 3,
                comparison: .decreased(2),
                color: Color(.systemRed)
            )
        case 2:
            return Symptom(
                imageName: "hand.raised.fill",
                name: "Falta de apetite",
                count: 5,
                comparison: .decreased(1),
                color: Color(.systemPurple)
            )
        case 3:
            return Symptom(
                imageName: "burst.fill",
                name: "Pânico",
                count: 2,
                comparison: .increased(3),
                color: Color(.systemBlue)
            )
        case 4:
            return Symptom(
                imageName: "bolt.horizontal.fill",
                name: "Dor de cabeça",
                count: 0,
                comparison: .decreased(5),
                color: Color(.systemPink)
            )
        case 5:
            return Symptom(
                imageName: "umbrella.fill",
                name: "Tristeza",
                count: 1,
                comparison: .increased(3),
                color: Color(.systemIndigo)
            )
        case 6:
            return Symptom(
                imageName: "moon.fill",
                name: "Insônia",
                count: 2,
                comparison: .decreased(2),
                color: Color(.systemTeal)
            )
        default:
            return Symptom(
                imageName: "",
                name: "Item \(num)",
                count: num,
                comparison: .decreased(0),
                color: Color(.systemYellow)
            )
        }
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(symptoms) { symptom in
                    SymptomCardView(symptom: symptom)
                }
                Button(action: {
                    self.showCreateTaskView = true
                }) {
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
        .sheet(
            isPresented: $showCreateTaskView) {
            CreateTaskView(save: {
                            self.showCreateTaskView = false
            })
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
    
    var customFont: Font =
        Font.system(.caption, design: .rounded).weight(.medium)
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: symptom.imageName)
                .font(.caption)
                .foregroundColor(symptom.color)
            Text(symptom.name)
                .font(customFont)
                .foregroundColor(symptom.color)
                .saturation(2.0)
            Spacer()
        }
        
    }
}

struct SymptomComparisonView: View {
    let symptom: Symptom

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: symptom.comparison.imageName)
                .foregroundColor(symptom.comparison.color)
            Text(symptom.comparison.description).foregroundColor(Color(.label).opacity(0.8))
        }
        .font(.footnote)
    }
}

struct SymptomCountView: View {
    let count: Int
    var body: some View {
        HStack {
            Spacer()
            Text("\(count)x").font(.title).bold()
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
                    SymptomCountView(count: symptom.count)
                    SymptomComparisonView(symptom: symptom)
                }
            }
            Spacer()
        }
        .card()
    }
}
