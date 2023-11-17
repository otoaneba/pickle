////
////  File.swift
////  pickle
////
////  Created by Naoto Abe on 11/14/23.
////
//
//import AVFoundation
//import UIKit
//
//
//class ViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
//    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//        <#code#>
//    }
//    
//
//    var captureSession = AVCaptureSession()
//    var sessionOutput = AVCapturePhotoOutput()
//    var movieOutput = AVCaptureMovieFileOutput()
//    var previewLayer = AVCaptureVideoPreviewLayer()
//
//    @IBOutlet var cameraView: UIView!
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.cameraView = self.view
//
//        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
//        for device in devices {
//            if device.position == AVCaptureDevicePosition.Front{
//
//
//                do{
//
//                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
//
//                    if captureSession.canAddInput(input){
//
//                        captureSession.addInput(input)
//                        sessionOutput.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
//
//                        if captureSession.canAddOutput(sessionOutput){
//
//                            captureSession.addOutput(sessionOutput)
//
//                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
//                            cameraView.layer.addSublayer(previewLayer)
//
//                            previewLayer.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
//                            previewLayer.bounds = cameraView.frame
//
//
//                        }
//
//                        captureSession.addOutput(movieOutput)
//
//                        captureSession.startRunning()
//
//                        let paths = NSFileManager.defaultManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
//                        let fileUrl = paths[0].URLByAppendingPathComponent("output.mov")
//                        try? NSFileManager.defaultManager().removeItemAtURL(fileUrl)
//                        movieOutput.startRecordingToOutputFileURL(fileUrl, recordingDelegate: self)
//
//                        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
//                        dispatch_after(delayTime, dispatch_get_main_queue()) {
//                            print("stopping")
//                            self.movieOutput.stopRecording()
//                        }
//                    }
//
//                }
//                catch{
//
//                    print("Error")
//                }
//
//            }
//        }
//
//    }
//
//    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
//        print("FINISHED \(error)")
//        // save video to camera roll
//        if error == nil {
//            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path!, nil, nil, nil)
//        }
//    }
//
//}
