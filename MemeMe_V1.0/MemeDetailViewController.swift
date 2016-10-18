//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Aabhimanyu Gupta on 18/10/16.
//  Copyright © 2016 Aabhimanyu Gupta. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    
    var meme : Meme!
    
    @IBOutlet weak var detailImagePickerView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.detailImagePickerView.contentMode = UIViewContentMode.scaleAspectFit
        self.detailImagePickerView.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            barButtonSystemItem: UIBarButtonSystemItem.edit,
            target: self,
            action: #selector(MemeDetailViewController.editMeme))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func editMeme() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController

        controller.editBottomText = meme.bottomTextField
        controller.editTopText = meme.topTextField
        controller.editImage = meme.originalImage
        
        present(controller, animated: true, completion: nil)
    }
}
