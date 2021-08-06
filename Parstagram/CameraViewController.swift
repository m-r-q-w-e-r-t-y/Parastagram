//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Anthony Mendez on 8/2/21.
//

import UIKit
import AlamofireImage
import Parse

// Extend "UIImagePickerControllerDelegate"
class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlet Setup
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // Action Setup
    @IBAction func onSubmitButton(_ sender: Any) {
        
        // Uploading Image Object
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text!
        post["author"]  = PFUser.current()!
        
        // Store Image as binary
        let imageData = imageView.image?.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = file
        
        // Place On Database
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            }
            else {
                print("Error!")
            }
        }
        
        // Saving an Object
//        let pet = PFObject(className: "Pets")
//
//        // Columns (i.e. schema)
//        pet["name"] = "Spencer"
//        pet["weight"] = 50
//        pet["owner"] = PFUser.current()!
//
//        pet.saveInBackground { (success, error) in
//            if success {
//                print("Saved!")
//            }
//            else {
//                print("Error!")
//            }
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // Launches Camera
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // Check If Camera Is Available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    // Updates imageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
