import SwiftUI
import AVFoundation

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
