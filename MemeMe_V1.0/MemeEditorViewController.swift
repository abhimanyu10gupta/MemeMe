//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Aabhimanyu Gupta on 29/09/16.
//  Copyright © 2016 Aabhimanyu Gupta. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let textFieldDelegate = TextFieldDelegate()

    var editBottomText : String?
    var editTopText : String?
    var editImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editTopText == nil {
            topTextField.text = "TOP"
            bottomTextField.text = "BOTTOM"
        } else {
            topTextField.text = editTopText
            bottomTextField.text = editBottomText
            imagePickerView.image = editImage
        }
        
        textAttributes(topTextField)
        textAttributes(bottomTextField)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        if imagePickerView.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
        imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func textAttributes (_ textField : UITextField ) {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
            ] as [String : Any]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.textColor = UIColor.white
        textField.delegate = textFieldDelegate
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        cancelButton.isEnabled = true
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
            imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func pickAnImage(type : Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        if type == 1 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        if type == 2 {
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        }
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: AnyObject) {
        pickAnImage(type: 2)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: AnyObject) {
        pickAnImage(type: 1)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
        viewDidLoad()
        cancelButton.isEnabled = false
        resignFirstResponder()
        imagePickerView.image = nil
    }
    
    @IBAction func share(_ sender: AnyObject) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        self.present(controller, animated: true, completion: nil)
        controller.completionHandler = {(activityType, completed:Bool) in
            if completed {
                self.save()
                controller.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func save() {
        let meme = Meme( topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, originalImage:
            imagePickerView.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
}
