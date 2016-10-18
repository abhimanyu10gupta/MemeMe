//
//  sentMemesCollectionView.swift
//  MemeMe
//
//  Created by Aabhimanyu Gupta on 14/10/16.
//  Copyright © 2016 Aabhimanyu Gupta. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionView : UICollectionViewController {
    
    @IBOutlet weak var addMeme: UIBarButtonItem!
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    override func viewDidLoad() {
        print("memes are : \(memes.count)")
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = self.memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCollectionViewCell
        cell.memeCellImageView?.contentMode = UIViewContentMode.scaleToFill
        cell.memeCellImageView?.image = meme.memedImage
        return cell
    }
    
    @IBAction func MemeEditor(_ sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(controller, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        controller.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
