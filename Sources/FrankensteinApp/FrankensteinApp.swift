//
//  FrankensteinApp.swift
//  Frankenstein
//
//  Created by Fabio Nogueira de Almeida on 10/06/25.
//

import SwiftUI

#if os(iOS) || os(macOS)
// Native SwiftUI app for iOS and macOS
@main
struct FrankensteinApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
#endif

#if SKIP_BRIDGE
// Android: Skip Fuse handles app structure automatically
// DashboardView will be the root view for Android
#endif
