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
        
//        let kScreenWidth = UIScreen.main.bounds.size.width;
//        let x_names = ["1","3","5","7","9"];
//        let targets = ["2","6","4","8","10"];
//        let bezierView = BezierCurveView.init(frame: CGRect.init(x: 30, y: 30, width: kScreenWidth-60.0, height: 240+56))
//        bezierView.center = self.view.center
//        self.view.addSubview(bezierView)
//        bezierView.drawLineChartView(xNames: x_names, targetValues: targets, lineType: .Straight)

        
        let kScreenWidth = UIScreen.main.bounds.size.width;
        let itemNames = ["销售业务","行政/文秘/后勤","翻译","采购/贸易","教育","其它"];
        let targets = ["20%","60%","60%","9%","9%","29%"];
        let bezierView = BezierCurveView.init(frame: CGRect.init(x: 30, y: 30, width: kScreenWidth-60.0, height: 240+56))
        bezierView.center = self.view.center
        self.view.addSubview(bezierView)
        bezierView.drawBarChartView(itenName: itemNames, targetValues: targets)
        
        
        //drawBarChartView
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

