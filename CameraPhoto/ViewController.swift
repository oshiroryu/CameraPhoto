//
//  ViewController.swift
//  CameraPhoto
//
//  Created by 大城琉斗 on 2019/04/23.
//  Copyright © 2019 大城　琉斗. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var PhotoImageView: UIImageView!
    
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.PhotoImageView = UIImageView()
        //制約
        self.PhotoImageView.frame = CGRect(x: 50, y: 130, width: 200, height: 200)
        //丸く
        self.PhotoImageView.layer.cornerRadius = 200 * 0.5
        
//        self.PhotoImageView.clipsToBounds = true
        
        PhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageViewTapped(_:))))
        self.view.addSubview(PhotoImageView)
        
    }


    
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
   
      }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] != nil {
            let image = info [.editedImage] as! UIImage
            PhotoImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // DocumentディレクトリのfileURLを取得
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0] as NSURL
        return documentsURL
    }
    
    // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
    func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }
    
    func saveImage(image: UIImage, path: String) -> Bool {
        let pngImageData = image.pngData()
        do {
            try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = .photoLibrary
        ipc.allowsEditing = true
        self.present(ipc, animated: true, completion: nil)
        
        
        
    }
    
    
}

