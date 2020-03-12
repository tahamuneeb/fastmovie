//
//  ViewController.swift
//  FastMovies
//
//  Created by Taha Muneeb on 14/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // Generic Alert
    func showAlert(title: String, message: String, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: action)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)

    }

}
