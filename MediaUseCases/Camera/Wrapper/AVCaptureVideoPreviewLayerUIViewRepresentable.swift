import SwiftUI
import AVFoundation

struct AVCaptureVideoPreviewLayerUIViewRepresentable : UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> AVCaptureVideoPreviewLayerUIView {
        AVCaptureVideoPreviewLayerUIView()
    }
    
    func updateUIView(_ uiView: AVCaptureVideoPreviewLayerUIView, context: Context) {
        uiView.inner.session = session
    }
    
    class AVCaptureVideoPreviewLayerUIView : UIView {
        override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
        var inner: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }
    }
}
