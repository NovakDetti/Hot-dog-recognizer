//
//  ViewController.swift
//  SeeFood
//
//  Created by Novák Bernadett on 2019. 08. 22..
//  Copyright © 2019. Novák Bernadett. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var recognizerImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }


    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
    }
}

