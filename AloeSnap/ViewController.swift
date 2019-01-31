//
//  ViewController.swift
//  AloeSnap
//
//  Created by Stephanie Chiu on 1/28/19.
//  Copyright © 2019 Stephanie Chiu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput = AVCapturePhotoOutput()

    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 5
        cameraButton.clipsToBounds = true
    }
    
    //Specify image quality in full resolution
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
    }
    
    //Finds and monitors camera
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        //Determines if camera is front or back
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    //Uses input from capture device (camera) to capture session as .jpeg format
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput)
        } catch {
            noCamera()
        }
    }
    //If camera isn't detected, then show alert message
    func noCamera() {
        let alertVC = UIAlertController(
            title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //Captured image preview
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
        //performSegue(withIdentifier: "photoPreviewSegue", sender: nil)
    }
    //Pass image to preview controller before segue to display preview image is enabled
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoPreviewSegue" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.image = self.image
        }
    }
}

    //Displays captured image when cameraButtonPressed is touched by user
    extension ViewController: AVCapturePhotoCaptureDelegate {
        func photoOutput (_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let imageData = photo.fileDataRepresentation(){
                image = UIImage(data: imageData)
                performSegue(withIdentifier: "photoPreviewSegue", sender: nil)
            }
        }
    }



