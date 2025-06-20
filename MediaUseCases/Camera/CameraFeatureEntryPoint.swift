
import SwiftUI
import AVFoundation

struct CameraFeatureEntryPoint: View {
    @State var viewModel = ViewModel()

    var body: some View {
        if viewModel.isCameraGranted {
            NavigationStack {
                List {
                    NavigationLink("Preview") {
                        CameraFeaturePreview()
                    }
                    NavigationLink("Photo Capture") {
                        CameraFeaturePhotoCapture()
                    }
                }
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
            .onTapGesture(perform: viewModel.requestCameraPermission)
        }
    }
}

extension CameraFeatureEntryPoint {
    @Observable
    class ViewModel {
        private(set) var isCameraGranted = false

        init() {
            isCameraGranted = AVCaptureDevice
                .authorizationStatus(for: .video) == .authorized
        }

        func requestCameraPermission() {
            Task {
                isCameraGranted = await AVCaptureDevice.requestAccess(for: .video)
            }
        }
    }
}

#Preview {
    CameraFeatureEntryPoint()
}
