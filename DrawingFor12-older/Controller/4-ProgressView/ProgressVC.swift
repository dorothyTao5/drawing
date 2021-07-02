//
//  ProgressVC.swift
//  DrawingFor12-older
//
//  Created by dorothy on 2021/6/12.
//

import UIKit

class ProgressVC: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.progress = 0
        progressView.setProgress(0, animated: false)
        
//       let progress = Progress()
//        progressView.observedProgress = progress
        
        //多執行緒： async
        DispatchQueue.global(qos: .background).async {
            for i in 0...10{
//                sleep(1)
                print(" background = \(i)")
                DispatchQueue.main.async {
                        self.progressView.setProgress(Float(i)/10, animated: true)
                        print(" main thread = \(i)")
                    
                }
            }
        }
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)

      
        
    }
   
    
    
    
    

}
