//
//  CameraViewController.swift
//  pickle
//
//  Created by Naoto Abe on 11/10/23.
//

import AVFoundation
import UIKit
import SwiftUI
import MobileCoreServices

class CameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // Capture Session
    var session: AVCaptureSession?
    // Photo Output
    let output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    // Video Preview for the camera feed
    let previewLayer = AVCaptureVideoPreviewLayer()
    // Define video output
    var movieOutput = AVCaptureMovieFileOutput()
    // File manager
    let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let manager = LocalFileManager.instance
    var saveImageStatus: (status: String, url: URL?)?
    
    private var microPhonePermission: Bool = false
    // shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private let switchCameraButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "arrow.triangle.2.circlepath.camera.fill")
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.configuration = config
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
//        view.addSubview(switchCameraButton)
        checkCameraPermissions()

        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
//        switchCameraButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 100)
        switchCameraButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return }
                DispatchQueue.main.async {
                    //self is optional because we're going to capture weak self to prevent memory leak
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func checkMicrophonePermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
                guard granted else { return }
                self?.checkCameraPermissions()
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            print(device)
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
    
                DispatchQueue.main.async {
                    session.startRunning()
                    self.session = session
                }
            }
            catch {
                print("error: ", error)
            }
        }
    }
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Error getting image data.")
            return
        }
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpg") else {
            print("Error getting path.")
            return
        }
        do {
            try data.write(to: path)
            print(path)
            print("Successfully saved data!")
            goToEntrySummary(path: path)
           
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    @objc private func didTapTakePhoto() {
        print("didTapTakePhoto: \(output)")
        output.capturePhoto(with: AVCapturePhotoSettings()
                            , delegate: self)
    }

    @objc func goToEntrySummary(path: URL) {
        let entry = EntryItem(id: UUID(), title: "", date: .now, status: "", duration: .seconds(59), location: "Kyoyo, Japan", comment: "T", entryType: "video", imageUrl: path)
        let vc = UIHostingController(rootView: EntrySummaryView(entry: entry))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func switchCamera() {
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        guard let image = UIImage(data: data) else {
            return
        }
        session?.stopRunning()
        saveImageStatus = manager.saveImage(image: image, name: "test")
//        saveImage(image: image, name: "test")
        
        
        guard let imagePath = saveImageStatus?.url else { return }
        goToEntrySummary(path: imagePath)
        
//        saveImage(image: image, name: "test")
       
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFill
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
    }
}
