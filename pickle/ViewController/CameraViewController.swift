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

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
    
    
    // Capture Session
    var session: AVCaptureSession!
    // Photo Output
    let output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    // Video Preview for the camera feed
    var previewLayer = AVCaptureVideoPreviewLayer()
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
    
    //MARK:- View Components
    let switchCameraButton : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "switchcamera")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let vc = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        
        present(vc, animated: true)
//        view.layer.addSublayer(previewLayer)
//        view.addSubview(shutterButton)
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
    
    private func setUpAndStartCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async{
            self.session = AVCaptureSession()
            self.session.beginConfiguration()
            
            if (self.session.canSetSessionPreset(.hd1920x1080)) {
                self.session.sessionPreset = .hd1920x1080
            }
            
            self.session.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            DispatchQueue.main.async {
                //setup preview layer
                self.setupPreviewLayer()
            }
            
            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }
    
    func setupPreviewLayer(){
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        view.layer.insertSublayer(previewLayer, below: switchCameraButton.layer)
        previewLayer.frame = self.view.layer.frame
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
    
    //MARK:- Actions
    @objc func captureImage(_ sender: UIButton?){
        
    }
    
    @objc func switchCamera(_ sender: UIButton?){
        
    }
    
    func chooseCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: image)
        
//        saveImage(image: image, name: "test")
       
//        let imageView = UIImageView(image: image)
//        imageView.contentMode = .scaleAspectFill
//        imageView.frame = view.bounds
//        view.addSubview(imageView)
    }
    
    
}
