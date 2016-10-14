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
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = self.memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCollectionViewCell
        
        cell.memeCellImageView?.image = meme.memedImage
        
        return cell
    }
}
