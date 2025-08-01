//
//  ContentView.swift
//  MediaUseCases
//
//  Created by Donizete Vida on 03/01/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Camera") {
                    CameraFeatureEntryPoint()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
