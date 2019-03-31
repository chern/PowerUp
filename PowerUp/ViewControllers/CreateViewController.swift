//
//  ViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var newSolarPlantButton: UIButton!
    @IBOutlet weak var newWindFarmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newSolarPlantButton.layer.cornerRadius = 8
        newWindFarmButton.layer.cornerRadius = 8
    }


}

