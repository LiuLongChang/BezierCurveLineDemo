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
        
        let x_names = ["语文","数学","英语","物理","化学","生物","政治","历史","地理"];
        let targets = ["20","40","20","50","30","90","30","100","70"];
        
        let bezierView = BezierCurveView.init(frame: CGRect.init(x: 30, y: 30, width: kScreenWidth-60.0, height: 280))
        bezierView.center = self.view.center
        self.view.addSubview(bezierView)
        
        bezierView.drawLineChartView(xNames: x_names, targetValues: targets, lineType: .Straight)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

