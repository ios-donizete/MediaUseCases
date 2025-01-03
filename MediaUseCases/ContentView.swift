//
//  ContentView.swift
//  MediaUseCases
//
//  Created by Donizete Vida on 03/01/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        VStack {
            if viewModel.isCameraGranted {
                VStack {
                    Image(systemName: "camera")
                    Text("Tap to start recording")
                }
            } else {
                VStack {
                    Label(
                        "Camera access is required",
                        systemImage: "exclamationmark.triangle"
                    ).foregroundStyle(.red)
                    Spacer().frame(height: 16)
                    Text("Tap to request camera access")
                }
                .padding()
                .onTapGesture(perform: viewModel.onCameraRequest)
            }
        }
    }
}

extension ContentView {

    @Observable
    class ViewModel {
        private(set) var isCameraGranted = false

        init() {
//            isCameraGranted = AVCaptureDevice
//                .authorizationStatus(for: .video) == .authorized
        }

        func onCameraRequest() {
            Task {
                isCameraGranted =  await AVCaptureDevice.requestAccess(for: .video)
            }
        }
    }
}

#Preview {
    ContentView()
}
