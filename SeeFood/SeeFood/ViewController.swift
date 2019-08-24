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
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedimage = info[.originalImage] as? UIImage {
            recognizerImageView.image = userPickedimage
            let ciiImage = CIImage(image: userPickedimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    func detect(image : CIImage){
        guard let model = try? VNCoreMLModel(for: SqueezeNet().model) else{ fatalError()}
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {fatalError()}
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        }catch{
            print(error)
        }
    }
   


    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated:  true, completion: nil)
    }
}

