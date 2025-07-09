//
//  GasView.swift
//  Frankenstein
//
//  Created by Fabio Nogueira de Almeida on 14/06/25.
//

import SwiftUI

struct GasView: View {
    @State var etanolValue: Double?
    @State var gasolineValue: Double?
    @State var result: String = ""
    
    let etanolText: String = "Álcool"
    let gasolinaText: String = "Gasolina"
    
    private var etanolBinding: Binding<Double?> {
        Binding(
            get: { etanolValue },
            set: { newValue in
                etanolValue = newValue
                calculate()
            }
        )
    }
    
    private var gasolineBinding: Binding<Double?> {
        Binding(
            get: { gasolineValue },
            set: { newValue in
                gasolineValue = newValue
                calculate()
            }
        )
    }
    
    func calculate() {
        guard let etanol = etanolValue, let gasoline = gasolineValue, gasoline > 0 else {
            result = ""
            return
        }
        
        if (etanol / gasoline) >= 0.7 {
            result = gasolinaText
        } else {
            result = etanolText
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HeaderView()
            InfoView(
                etanolValue: etanolBinding,
                gasolineValue: gasolineBinding
            )
            Spacer()
            ResultView(result: $result)
            Spacer()
        }
        .background(
            .linearGradient(
                colors:  [.white, .orange, .red],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

extension GasView {
    struct HeaderView: View {
        var body: some View {
            Text("⛽️")
                .font(.system(size: 120, weight: .bold))
                .padding()
            Text("Álcool ou Gasolina")
                .font(.title)
                .bold()
                .foregroundStyle(.white)
        }
    }
    
    struct InfoView: View {
        @Binding var etanolValue: Double?
        @Binding var gasolineValue: Double?
        
        @FocusState private var focusedField: Field?
        enum Field {
            case etanol
            case gasoline
        }
        
        private func focusNextField() {
            switch focusedField {
            case .etanol:
                focusedField = .gasoline
            case .gasoline:
                focusedField = .etanol
            case .none:
                focusedField = nil
            }
        }
        
        var body: some View {
            VStack {
                HStack {
                    Text("Álcool (R$)")
                        .foregroundStyle(.white)
                        .bold()
                        .onTapGesture {
                            focusedField = .etanol
                        }
                    TextField(
                        "",
                        value: $etanolValue,
                        format: .currency(code: "BRL")
                    )
#if os(iOS)
                    .keyboardType(.decimalPad)
#endif

                    .foregroundStyle(.white)
                    .multilineTextAlignment(.trailing)
                    .focused($focusedField, equals: .etanol)
                    .onSubmit {
                        focusedField = .gasoline
                    }
                    
                }
                .padding()
                .background(.white.opacity(0.2))
                HStack {
                    Text("Gasolina (R$)")
                        .foregroundStyle(.white)
                        .bold()
                        .onTapGesture {
                            focusedField = .gasoline
                        }
                    TextField(
                        "",
                        value: $gasolineValue,
                        format: .currency(code: "BRL")
                    )
#if os(iOS)
                    .keyboardType(.decimalPad)
#endif
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.trailing)
                    .focused($focusedField, equals: .gasoline)
                    .onSubmit {
                        focusedField = nil
                    }
                    
                }
                .padding()
                .background(.white.opacity(0.2))
            }
            .padding()
            .border(.white.opacity(0.1), width: 1)
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Resetar") {
                        focusedField = .etanol
                        $gasolineValue.wrappedValue = nil
                        $etanolValue.wrappedValue = nil
                    }
                    .foregroundStyle(.orange)
                    Button("Próximo") {
                        focusNextField()
                    }
                    .foregroundStyle(.orange)
                    Spacer()
                    Button("Calcular") {
                        focusedField = nil
                    }
                    .foregroundStyle(.orange)
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

#Preview {
    GasView()
}
