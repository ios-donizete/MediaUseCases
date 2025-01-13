import SwiftUI
import AVFoundation

struct CameraFeaturePreview: View {
    @State var viewModel = ViewModel()

    var body: some View {
        Text("Camera preview here")
    }
}

extension CameraFeaturePreview {
    @Observable
    class ViewModel {
        
    }
}

#Preview {
    CameraFeaturePreview()
}
