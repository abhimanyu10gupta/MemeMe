//
//  ViewController.swift
//  MemeMe_V1.0
//
//  Created by Aabhimanyu Gupta on 29/09/16.
//  Copyright © 2016 Aabhimanyu Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let memeTextAttributes = [
        NSForegroundColorAttributeName : UIColor.black,
        NSStrokeColorAttributeName : UIColor.black,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 72)!,
        NSStrokeWidthAttributeName : 3.0
    ] as [String : Any]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification: notification) * -1
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ TextField: UITextField) {
        topTextField.text = ""
        bottomTextField.text = ""

    }
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return false
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
