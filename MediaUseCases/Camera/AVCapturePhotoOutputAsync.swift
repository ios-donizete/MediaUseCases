import AVFoundation

class AVCapturePhotoOutputAsync : NSObject, AVCapturePhotoCaptureDelegate {
    private let photoOutput: AVCapturePhotoOutput
    private var callback: ((Result<AVCapturePhoto, Error>) -> Void)?
    
    init(_ photoOutput: AVCapturePhotoOutput) {
        self.photoOutput = photoOutput
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: (any Error)?) {
        if let error { callback?(.failure(error)); return }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        if let error { callback?(.failure(error)); return }
        callback?(.success(photo))
    }
    
    func capturePhoto(with settings: AVCapturePhotoSettings) async -> AVCapturePhoto? {
        try? await withCheckedThrowingContinuation { continuation in
            callback = { continuation.resume(with: $0) }
            photoOutput.capturePhoto(with: settings, delegate: self)
        }
    }
}
