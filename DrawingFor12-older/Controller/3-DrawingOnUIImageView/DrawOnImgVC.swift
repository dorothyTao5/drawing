//
//  DrawOnImgVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/22.
//

import UIKit

class DrawOnImgVC: UIViewController {
    @IBOutlet weak var cvColor: UICollectionView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgV: DrawnImageView!
    
    fileprivate weak var drawnImageView: DrawnImageView?

    
    var arrColors: [UIColor]  = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),#colorLiteral(red: 0.9294117647, green: 0.03921568627, blue: 0.2470588235, alpha: 1),#colorLiteral(red: 1, green: 0.2470588235, blue: 0.2039215686, alpha: 1),#colorLiteral(red: 1, green: 0.5254901961, blue: 0.1215686275, alpha: 1),#colorLiteral(red: 0.6862745098, green: 0.3490196078, blue: 0.2431372549, alpha: 1),#colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.4392156863, alpha: 1),#colorLiteral(red: 0.7725490196, green: 0.8823529412, blue: 0.4784313725, alpha: 1),#colorLiteral(red: 0.003921568627, green: 0.6392156863, blue: 0.4078431373, alpha: 1),#colorLiteral(red: 0.462745098, green: 0.8431372549, blue: 0.9176470588, alpha: 1),#colorLiteral(red: 0, green: 0.4, blue: 1, alpha: 1),#colorLiteral(red: 0.5137254902, green: 0.3490196078, blue: 0.6392156863, alpha: 1)]
    
    var  arrPanData  = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let drawnImageView = addImageView(image: UIImage(named: "CirecleIcon")) as DrawnImageView
        drawnImageView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        drawnImageView.shapeLayer.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        drawnImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        drawnImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3).isActive = true
        self.drawnImageView = addImageView(image: UIImage(named: "CirecleIcon")) as DrawnImageView
        
        
//        imgV.translatesAutoresizingMaskIntoConstraints = false
//        imgV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        imgV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        imgV.shapeLayer.strokeColor = arrPanData
        
        
       
        setUpCv()
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
    
    func setUpCv() {
        cvColor.delegate = self
        cvColor.dataSource = self
        cvColor.register(UINib(nibName: "PickColorCVCell", bundle: nil), forCellWithReuseIdentifier: "PickColorCVCell")
       
    }

}

//MARK: - *UICollectionView
extension DrawOnImgVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return arrColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickColorCVCell", for: indexPath) as! PickColorCVCell
        cell.backgroundColor = arrColors[indexPath.row]
        
        return cell
    }
    

    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        arrPanData = arrColors[indexPath.row].cgColor
        drawnImageView!.shapeLayer.strokeColor = arrColors[indexPath.row].cgColor
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
