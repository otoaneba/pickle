//
//  VideoContentViewModel.swift
//  pickle
//
//  Created by Naoto Abe on 11/24/23.
//

import Foundation
import Aespa
import SwiftUI
import Combine

class VideoContentViewModel: ObservableObject {
    let aespaSession: AespaSession
    var preview: some View {
        aespaSession.interactivePreview()
    }
    private var subscription = Set<AnyCancellable>()
    
    @Published var videoAlbumCover: Image?
    @Published var videoFiles: [VideoAsset] = []
    
    init() {
        let option = AespaOption(albumName: "Aespa-Demo")
        self.aespaSession = Aespa.session(with: option)
    
        aespaSession
            .focus(mode: .continuousAutoFocus)
            .changeMonitoring(enabled: true)
            .orientation(to: .portrait)
            .quality(to: .high)
            .custom(WideColorCameraTuner()) { result in
                if case .failure(let error) = result {
                    print("Error: ", error)
                }
            }
        
        aespaSession
            .mute()
            .stabilization(mode: .auto)
        
        aespaSession.videoFilePublisher
            .receive(on: DispatchQueue.main)
            .map { result -> Image? in
                if case .success(let file) = result {
                    return file.thumbnailImage
                } else {
                    return nil
                }
            }
            .assign(to: \.videoAlbumCover, on: self)
            .store(in: &subscription)
        
        // Other settings...
    }
    
    func fetchVideoFiles() {
        // File fetching task can cause low reponsiveness when called from main thread
        Task(priority: .utility) {
            let fetchedFiles = await aespaSession.fetchVideoFiles()
            DispatchQueue.main.async { self.videoFiles = fetchedFiles }
        }
    }
    
    func getVidePath() {
        aespaSession.stopRecording { result in
            switch result {
            case .success(let file):
                print("recording ended. printing path")
                print(file.path ?? "path") // file://some/path
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func goToEntrySummary(path: URL) {
        let entry = EntryItem(id: UUID(), title: "", date: .now, status: "", duration: .seconds(59), location: "Kyoyo, Japan", comment: "T", entryType: "video", imageUrl: path)
        let vc = UIHostingController(rootView: EntrySummaryView(entry: entry))
    }
}

extension VideoContentViewModel {
    // Example for using custom session tuner
    struct WideColorCameraTuner: AespaSessionTuning {
        func tune<T>(_ session: T) throws where T : AespaCoreSessionRepresentable {
            session.avCaptureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
        }
    }
}
