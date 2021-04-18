//
//  SavedImgVC.swift
//  DrawingOnImage
//
//  Created by 2010011NB01 on 2021/1/7.
//

import UIKit

class PreviewImgVC: UIViewController {

    @IBOutlet weak var imgSaved: UIImageView!
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgSaved.image = img
    }
    

  
    

}
