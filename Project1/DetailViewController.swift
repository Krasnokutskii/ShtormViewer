//
//  DetailViewController.swift
//  Project1
//
//  Created by Ярослав on 3/17/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var picturesNumber: Int = 0
    var imageIndex: Int = 0
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //testing assert
        assert(selectedImage != nil, "selected imgage = nil")
        
        title = "Image \(imageIndex) of \(picturesNumber) "
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    
}
