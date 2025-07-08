//
//  ContentView.swift
//  Frankeinstein
//
//  Created by Fabio Nogueira de Almeida on 10/06/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            Tab("Café 1:10", systemImage: "cup.and.saucer.fill") {
                CoffeeView()
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 0)
                    }
            }
            Tab("Gasolina x Álcool", systemImage: "fuelpump.fill") {
                GasView()
                    .safeAreaInset(edge: .bottom) {
                        Color.clear.frame(height: 0)
                    }
            }
        }
        .toolbarBackground(.visible, for: .tabBar)
        .accentColor(.white)
    }
}

#Preview {
    DashboardView()
}
