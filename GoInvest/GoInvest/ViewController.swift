//
//  ViewController.swift
//  GoInvest
//
//  Created by Grigorii Rassadnikov on 11.04.2023.
//

import UIKit
import DomainModels

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let m = MyLibrary()
        print(m.text)
        // Do any additional setup after loading the view.
    }


}

