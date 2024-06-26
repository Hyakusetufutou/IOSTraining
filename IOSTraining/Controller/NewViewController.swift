//
//  NewViewController.swift
//  IOSTraining
//  
//  
//

import UIKit

class NewViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
//        performSegue(withIdentifier: "next", sender: nil)
        let controller = ViewController.getInstance(weatherFetching: WeatherManager())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        print("viewIsAppearing")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }





    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
