//
//  SentMemesTableView.swift
//  MemeMe
//
//  Created by Aabhimanyu Gupta on 14/10/16.
//  Copyright © 2016 Aabhimanyu Gupta. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableView : UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")
        let meme = self.memes[indexPath.row]
        
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel?.text = ("\(meme.topTextField) + \(meme.bottomTextField)")
        
        return cell!
    }
}
