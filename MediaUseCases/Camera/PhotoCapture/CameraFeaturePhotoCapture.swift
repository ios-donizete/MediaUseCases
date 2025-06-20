import SwiftUI
import AVFoundation
import Photos

struct CameraFeaturePhotoCapture: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        if let session = viewModel.session {
            VStack {
                AVCaptureVideoPreviewLayerUIViewRepresentable(session: session)
                Button("Take photo") {
                    viewModel.capturePhoto()
                }
            }
        } else {
            Button("Tap to start previewing") {
                viewModel.startPreview()
            }
        }
    }
}

extension CameraFeaturePhotoCapture {
    @Observable
    class ViewModel: NSObject, AVCapturePhotoCaptureDelegate {
        private(set) var session: AVCaptureSession? = nil
        private(set) var photoOutput: AVCapturePhotoOutput? = nil
        
        deinit {
            self.session?.stopRunning()
            self.session = nil
        }
        
        func startPreview() {
            guard
                let device = AVCaptureDevice.default(for: .video),
                let input = try? AVCaptureDeviceInput(device: device)
            else { return }
            
            let session = AVCaptureSession()
            let photoOutput = AVCapturePhotoOutput()
            
            session.beginConfiguration()
            session.sessionPreset = .photo
            
            session.addInput(input)
            session.addOutput(photoOutput)
            
            session.commitConfiguration()
            session.startRunning()
            
            self.session = session
            self.photoOutput = photoOutput
        }
        
        func capturePhoto() {
            guard let photoOutput else { return }
            Task {
                let photoOutputAsync = AVCapturePhotoOutputAsync(photoOutput)
                guard
                    let photo = await photoOutputAsync.capturePhoto(with: AVCapturePhotoSettings()),
                    let data = photo.fileDataRepresentation()
                else { return }
                
                guard await
                        PHPhotoLibrary.requestAuthorization(
                            for: .addOnly
                        ) == .authorized
                else { return }
                
                try? await
                PHPhotoLibrary.shared().performChanges {
                    PHAssetCreationRequest
                        .forAsset()
                        .addResource(with: .photo, data: data, options: nil)
                }
            }
        }
    }
}

#Preview {
    CameraFeaturePhotoCapture()
}
