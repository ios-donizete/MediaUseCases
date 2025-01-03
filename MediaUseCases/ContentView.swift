//
//  ContentView.swift
//  MediaUseCases
//
//  Created by Donizete Vida on 03/01/25.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var isCameraGranted = false

    var body: some View {
        VStack {
            if isCameraGranted {
                Text("Tap to start recording")
            } else {
                Text("Tap to request camera access")
                    .onTapGesture {
                        Task.init { await onCameraRequest() }
                    }
            }
        }
    }

    func onCameraRequest() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        var isGranted = status == .authorized
        
        if !isGranted {
            isGranted = await AVCaptureDevice.requestAccess(for: .video)
        }

        isCameraGranted = isGranted
    }
}

#Preview {
    ContentView()
}
