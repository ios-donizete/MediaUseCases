import SwiftUI
import AVFoundation

struct CameraFeaturePreview: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        if let session = viewModel.session {
            PreviewView(session: session)
        } else {
            Button("Tap to start previwing") {
                viewModel.startPreview()
            }
        }
    }
}

extension CameraFeaturePreview {
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

struct PreviewView : UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIPreviewView {
        UIPreviewView()
    }
    
    func updateUIView(_ uiView: UIPreviewView, context: Context) {
        uiView.inner.session = session
    }
}

class UIPreviewView : CALayerView<AVCaptureVideoPreviewLayer> { }

class CALayerView<T : CALayer> : UIView {
    override class var layerClass: AnyClass { T.self }
    var inner: T { layer as! T }
}

#Preview {
    CameraFeaturePreview()
}
