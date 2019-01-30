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
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()

    }
    
    //Specify image quality we want. This will preset photo in full resolution
    func setupCaptureSession() {
        
    }
    
    //Finds and monitors camera
    func setupDevice() {

    }
    
    func setupInputOutput() {
        
    }
    
    
    func setupPreviewLayer() {
        
    }
    
    func startRunningCaptureSession() {
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "photoPreviewSegue", sender: nil)
    }
    

}

