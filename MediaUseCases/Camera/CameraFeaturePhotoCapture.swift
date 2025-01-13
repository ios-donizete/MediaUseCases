import SwiftUI
import AVFoundation

struct CameraFeaturePhotoCapture: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        if let session = viewModel.session {
            PreviewView(session: session)
        } else {
            Button("Tap to start previewing") {
                viewModel.startPreview()
            }
        }
    }
}

extension CameraFeaturePhotoCapture {
    @Observable
    class ViewModel {
        private(set) var session: AVCaptureSession? = nil
        
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
            session.beginConfiguration()
            
            session.addInput(input)
            
            session.commitConfiguration()
            session.startRunning()
            
            self.session = session
        }
    }
}

#Preview {
    CameraFeaturePhotoCapture()
}
