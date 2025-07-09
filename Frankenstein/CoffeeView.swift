//
//  CoffeeView.swift
//  Frankenstein
//
//  Created by Fabio Nogueira de Almeida on 10/06/25.
//

import SwiftUI

struct CoffeeView: View {
    @State var formula: String = ""
    @State var water: String = ""
    @State var coffee: String = ""
    @State var result: String = ""
    
    private var formulaBinding: Binding<String> {
        Binding(
            get: { formula },
            set: { newValue in
                formula = newValue
                calculate()
            }
        )
    }
    
    private var waterBinding: Binding<String> {
        Binding(
            get: { water },
            set: { newValue in
                water = newValue
                calculate()
            }
        )
    }
    
    private var coffeeBinding: Binding<String> {
        Binding(
            get: { coffee },
            set: { newValue in
                coffee = newValue
                calculate()
            }
        )
    }
    
    func calculate() {
        let formulaTotalValue = Int(formula)
        let waterValue = Int(water)
        let coffeeValue = Int(coffee)

        if formulaTotalValue != nil, waterValue != nil, coffeeValue != nil {
            result = "Informe apenas dois campos para calcular a variável restante"
            return
        } else if let formulaTotalValue, let waterValue {
            result = "Proporção 1:\(formulaTotalValue)\nVocê precisa de \(waterValue/formulaTotalValue) gramas de café"
        } else if let coffeeValue, let waterValue {
            result = "Proporção é de 1:\(waterValue/coffeeValue)"
            
        } else if let coffeeValue, let formulaTotalValue {
            result = "Proporção 1:\(formulaTotalValue)\nVocê precisa de \(coffeeValue*formulaTotalValue) ml de água"
        } else {
            result = "Informe ao menos dois campos para calcular a proporção"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HeaderView()
            InfoView(
                formula: formulaBinding,
                water: waterBinding,
                coffee: coffeeBinding
            )
            Spacer()
            ResultView(result: $result)
            Spacer()
        }
        .background(
            .linearGradient(
                colors:  [.white, .purple, .indigo],
                startPoint: .top, endPoint: .bottom
            )
        )
    }
}

extension CoffeeView {
    struct HeaderView: View {
        var body: some View {
            Text("☕️")
                .font(.system(size: 120, weight: .bold))
            Text("Café 1:10")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
        }
    }
    
    struct InfoView: View {
        @Binding var formula: String
        @Binding var water: String
        @Binding var coffee: String
        
        @FocusState private var focusedField: Field?
        enum Field {
            case formula
            case water
            case coffee
        }
        
        private func focusNextField() {
            switch focusedField {
            case .formula:
                focusedField = .water
            case .water:
                focusedField = .coffee
            case .coffee:
                focusedField = .formula
            case .none:
                focusedField = nil
            }
        }
        
        var body: some View {
            Group {
                VStack {
                    HStack {
                        Text("Proporção (1:x)")
                            .foregroundStyle(.white)
                            .bold()
                            .onTapGesture {
                                focusedField = .formula
                            }
                        TextField("", text: $formula)
#if os(iOS)
                            .keyboardType(.numberPad)
#endif
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.white)
                            .focused($focusedField, equals: .formula)
                    }
                    .padding()
                    .background(.white.opacity(0.2))
                    HStack {
                        Text("Água (ml)")
                            .foregroundStyle(.white)
                            .bold()
                            .onTapGesture {
                                focusedField = .water
                            }
                        TextField("", text: $water)
#if os(iOS)
                            .keyboardType(.numberPad)
#endif
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.white)
                            .focused($focusedField, equals: .water)
                    }
                    .padding()
                    .background(.white.opacity(0.2))
                    HStack {
                        Text("Café (gr)")
                            .foregroundStyle(.white)
                            .bold()
                            .onTapGesture {
                                focusedField = .coffee
                            }
                        TextField("", text: $coffee)
#if os(iOS)
                            .keyboardType(.numberPad)
#endif
                            .multilineTextAlignment(.trailing)
                            .foregroundStyle(.white)
                            .focused($focusedField, equals: .coffee)
                    }
                    .padding()
                    .background(.white.opacity(0.2))
                }
                .padding()
                .border(.white.opacity(0.1), width: 2)
                .padding()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Resetar") {
                        focusedField = .formula
                        $formula.wrappedValue = ""
                        $water.wrappedValue = ""
                        $coffee.wrappedValue = ""
                    }
                    .foregroundStyle(.indigo)
                    Button("Próximo") {
                        focusNextField()
                    }
                    .foregroundStyle(.indigo)
                    Spacer()
                    Button("Calcular") {
                        focusedField = nil
                    }
                    .foregroundStyle(.indigo)
                }
            }
        }
    }
    
    struct ResultView: View {
        @Binding var result: String
        var body: some View {
            HStack {
                Text(result)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .minimumScaleFactor(0.5)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(.white.opacity(0.2))
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    CoffeeView()
}
