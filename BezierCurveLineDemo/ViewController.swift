//
//  ViewController.swift
//  BezierCurveLineDemo
//
//  Created by zgzzzs on 2018/3/29.
//  Copyright © 2018年 zgzzzs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let kScreenWidth = UIScreen.main.bounds.size.width;
        
        let x_names = ["1年","2年","3年","4年","5年","6年","7年","8年","9年"];

        let targets = ["2","4","6","8","10","12","14"];


        
        let bezierView = BezierCurveView.init(frame: CGRect.init(x: 30, y: 30, width: kScreenWidth-60.0, height: 240+56))
        bezierView.center = self.view.center
        self.view.addSubview(bezierView)
        
        bezierView.drawLineChartView(xNames: x_names, targetValues: targets, lineType: .Straight)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

