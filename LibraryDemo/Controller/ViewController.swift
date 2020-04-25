//
//  ViewController.swift
//  LibraryDemo
//
//  Created by Nanda Mochammad on 25/04/20.
//  Copyright © 2020 Nanda Mochammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func requestCity(){
        Webservice().requestGET(resource: GetProvinceResponse.resourceRequest()) { (response) in
            switch response{
            case .success(let result):
                print("Sukses", result)
            case .failure(let err):
                print("Error", err.localizedDescription)
            }
        }
    }
}

