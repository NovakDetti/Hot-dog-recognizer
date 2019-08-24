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
    
    @IBOutlet weak var upArrow: UIImageView!
    @IBOutlet weak var recognizerImageView: UIImageView!
    @IBOutlet weak var hotdogBun: UIImageView!
    @IBOutlet weak var ingredients: UIImageView!
    @IBOutlet weak var cucumber: UIImageView!
    @IBOutlet weak var text: UILabel!
    
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
            guard let ciiImage = CIImage(image: userPickedimage) else{fatalError()}
            detect(image: ciiImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    func detect(image: CIImage) {
        upArrow.isHidden = true
        hotdogBun.isHidden = true
        cucumber.isHidden = true
        ingredients.isHidden = true
        text.isHidden = true
            guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            if topResult.identifier.contains("hotdog") {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Hotdog!"
                    self.navigationController?.navigationBar.barTintColor = UIColor(red: 51.0/255.0, green: 142.0/255.0, blue: 96.0/255.0, alpha: 1.0)
                    self.navigationController?.navigationBar.isTranslucent = false
                    
                    
                }
            }
            else {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Not Hotdog!"
                    self.navigationController?.navigationBar.barTintColor = UIColor(red: 172.0/255.0, green: 34.0/255.0, blue: 48.0/255.0, alpha: 1.0)
                    self.navigationController?.navigationBar.isTranslucent = false
                    
                }
            }
            
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do { try handler.perform([request]) }
        catch { print(error) }
        
        
        
    }
   


    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated:  true, completion: nil)
    }
}

