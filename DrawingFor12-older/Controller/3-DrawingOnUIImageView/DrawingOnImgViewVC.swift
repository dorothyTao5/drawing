//
//  DrawingOnImgViewVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/19.
//https://stackoverflow.com/questions/49919853/how-to-draw-doodle-line-on-uiimage-in-swift

import UIKit

class DrawingOnImgViewVC: UIViewController {
    
    
    fileprivate weak var savedImageView: UIImageView?
    fileprivate weak var drawnImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawnImageView = addImageView(image: UIImage(named: "CirecleIcon")) as DrawnImageView
        drawnImageView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        drawnImageView.shapeLayer.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        drawnImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        drawnImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3).isActive = true
        self.drawnImageView = addImageView(image: UIImage(named: "CirecleIcon")) as DrawnImageView
        
        let button = UIButton()
        button.setTitle("Save Image", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: drawnImageView.bottomAnchor, constant: 60).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(saveImageButtonTouchUpInside), for: .touchUpInside)
        
        let savedImageView = addImageView()
        savedImageView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 60).isActive = true
        savedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.savedImageView = addImageView()
    }
    
    private func addImageView<T: UIImageView>(image: UIImage? = nil) -> T {
        let imageView = T(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return imageView
    }
    
    @objc func saveImageButtonTouchUpInside(sender: UIButton) {
        savedImageView?.image = drawnImageView?.screenShot
    }

}
