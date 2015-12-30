//
//  ViewController.swift
//  ColumnView
//
//  Created by xuemincai on 15/12/28.
//  Copyright © 2015年 xuemincai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let colView = ColumnView(frame: self.view.frame)
        colView.columnarValues?.append(1000)
        colView.columnarValues?.append(2000)
        colView.columnarValues?.append(1500)
        colView.columnarValues?.append(2500)
        colView.columnarValues?.append(5000)
        colView.columnarValues?.append(16000)
        colView.columnarValues?.append(8000)
        self.view = colView
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

