//
//  HomePageVC.swift
//  DrawingFor12-older
//
//  Created by dorothyLiu on 2021/4/16.
//

import UIKit

class HomePageVC: UIViewController {

    @IBOutlet weak var tbv: UITableView!
    
    var arr = ["繪圖","客製化SegmentController"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier : "Cell")!
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HapticsUtil.feedbackMedium()
        switch indexPath.row {
        
        case 0:
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "DrawingVC") as! DrawingVC
           
            navigationController?.pushViewController(vc, animated: true)
        case 1 :
            let vc = CustomSegmentVC()
            navigationController?.pushViewController(vc, animated: true)
        default:
            print("HomePageVC tbv error" )
        }
        
    }
    
    
}
