//
//  ImagePreviewViewController.swift
//  AloeSnap
//
//  Created by Stephanie Chiu on 1/29/19.
//  Copyright © 2019 Stephanie Chiu. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    
    @IBOutlet weak var photo: UIImageView!
    
    //Displays photo on Preview screen
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
    }

    @IBAction func cancelImageButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveImageButton(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    
}
