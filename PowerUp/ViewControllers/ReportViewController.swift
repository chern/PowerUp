//
//  ReportViewController.swift
//  PowerUp
//
//  Created by William Chern on 3/30/19.
//  Copyright © 2019 William Chern. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var annualKWHOutputLabel: UILabel?
    @IBOutlet weak var revenuePerYearLabel: UILabel!
    @IBOutlet weak var poundsCO2OffsetPerYearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
