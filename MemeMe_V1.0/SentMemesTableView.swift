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

    @IBOutlet weak var addMeme: UIBarButtonItem!
    
    override func viewDidLoad() {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCells")
        let meme = self.memes[indexPath.row]
        
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel?.text = ("\(meme.topTextField!) \(meme.bottomTextField!)")
        
        return cell!
    }

    @IBAction func MemeEditor(_ sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(controller, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            appDelegate.memes.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        controller.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}
