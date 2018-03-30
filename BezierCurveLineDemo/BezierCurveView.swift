//
//  BezierCurveView.swift
//  BezierCurveLineDemo
//
//  Created by zgzzzs on 2018/3/29.
//  Copyright © 2018年 zgzzzs. All rights reserved.
//

import UIKit

//坐标轴与画布间距
let Margin : CGFloat = 30

//y轴每一个值的间隔数
let Y_Every_Margin : CGFloat = 30

let X_Every_Margin : CGFloat = 28


//颜色RGB
func RGBColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat)->UIColor{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

func RGBAlphaColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ alpha:CGFloat)->UIColor{
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

//随机色
func RandomColor()->UIColor{
    return RGBColor(CGFloat(arc4random()%256), CGFloat(arc4random()%256), CGFloat(arc4random()%256))
}

enum LineType {//折线 曲线
    case Straight,Curve,NoneMeaning
}



class BezierCurveView: UIView {

    static var myFrame : CGRect! = nil

    //初始化画布
    override init(frame: CGRect) {
        super.init(frame: frame)
        let backView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backView.backgroundColor = RGBColor(255, 255, 255)
        self.addSubview(backView)
        BezierCurveView.myFrame = frame
    }

    /*画坐标轴*/
    func drawXYLine(x_names:[String]){
        let path = UIBezierPath.init()
        //1. Y轴、X轴的直线
        path.move(to: CGPoint.init(x: Margin, y: BezierCurveView.myFrame.height-Margin))
        path.addLine(to: CGPoint.init(x: Margin, y: Margin))

        path.move(to: CGPoint.init(x: Margin, y: BezierCurveView.myFrame.height-Margin))
        path.addLine(to: CGPoint.init(x: Margin+BezierCurveView.myFrame.width-2*Margin, y: BezierCurveView.myFrame.height-Margin))

        //2.添加索引格  X轴
        for idx in 0..<x_names.count {
            let x = Margin+Margin*CGFloat(idx+1)
            let point = CGPoint.init(x: x, y: BezierCurveView.myFrame.height-Margin)
            path.move(to: point)
            path.addLine(to: CGPoint.init(x: point.x, y: point.y-3))
        }

        //Y轴 实际长度为200，此处比例缩小一倍使用
        let yArray = [0,2,4,6,8,10,12,14]
        for idx in 0..<yArray.count{
            let y = BezierCurveView.myFrame.height - Margin - Y_Every_Margin*CGFloat(idx)
            let point = CGPoint.init(x: Margin, y: y)
            path.move(to: point)
            path.addLine(to: CGPoint.init(x: point.x+3, y: point.y))
        }

        //添加索引格文字 X轴
        for idx in 0..<x_names.count {
            let x = Margin+15+X_Every_Margin*CGFloat(idx)
            let textLabel = UILabel(frame: CGRect.init(x:x, y: BezierCurveView.myFrame.height-Margin, width: Margin, height: 20))
            if idx % 2 == 1 {textLabel.isHidden = true}
            textLabel.textAlignment = .center
            textLabel.text = x_names[idx]
            textLabel.font = UIFont.systemFont(ofSize: 12)
            textLabel.textColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
            self.addSubview(textLabel)
        }

        //添加索引格文字  Y轴
        for (idx,obj) in yArray.enumerated(){
            let y = BezierCurveView.myFrame.height - Margin - Y_Every_Margin*CGFloat(idx);
            let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: y-5, width: Margin, height: 10))
            textLabel.text = "\(obj)k";
            textLabel.font = UIFont.systemFont(ofSize: 12)
            textLabel.textAlignment = .center
            textLabel.textColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
            self.addSubview(textLabel)
        }

        //渲染路径
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.init(red: 230/255.0, green: 235/255.0, blue: 245/255.0, alpha: 1).cgColor
        shapeLayer.fillColor = UIColor.init(red: 230/255.0, green: 235/255.0, blue: 245/255.0, alpha: 1).cgColor
        shapeLayer.borderWidth = 2.0
        self.subviews[0].layer.addSublayer(shapeLayer)
    }


    //画折线图
    func drawLineChartView(xNames:[String],targetValues:[String],lineType:LineType){
        //画坐标轴
        self.drawXYLine(x_names: xNames)
        //获取目标值点坐标
        let allPoints = NSMutableArray()
        for idx in 0..<targetValues.count{
            let doubleValue = 2*Float(targetValues[idx])!;//目标值放大两倍
            let x = Margin+X_Every_Margin*CGFloat(idx+1)
            let y = BezierCurveView.myFrame.height-Margin-CGFloat(doubleValue)*15/2.0; 
            let point = CGPoint.init(x: x, y: y)
            var path : UIBezierPath! = nil;
            if idx % 2 == 1 {
                path = UIBezierPath.init(roundedRect: CGRect.init(x: point.x-1, y: point.y-1, width: 0, height: 0), cornerRadius: 2.5)
            }else{
                path = UIBezierPath.init(roundedRect: CGRect.init(x: point.x-1, y: point.y-1, width: 2.5, height: 2.5), cornerRadius: 2.5)
            }

            let layer = CAShapeLayer()
            layer.strokeColor = UIColor.purple.cgColor
            layer.fillColor = UIColor.purple.cgColor
            layer.path = path.cgPath
            self.subviews[0].layer.addSublayer(layer)
            allPoints.add(point)
        }
        //坐标连线
        let path = UIBezierPath()
        path.move(to: allPoints[0] as! CGPoint)
        var prePoint:CGPoint! = nil
        switch lineType {
        case .Straight:
            for idx in 1..<allPoints.count{
                let point = allPoints[idx]
                path.addLine(to: point as! CGPoint)
            }
        case .Curve:
            for idx in 0..<allPoints.count{
                if idx == 0 {
                    prePoint = allPoints[0] as! CGPoint
                }else{
                    let nowPoint = allPoints[idx]
                    path.addCurve(to: nowPoint as! CGPoint, controlPoint1: CGPoint.init(x: (prePoint.x + (nowPoint as! CGPoint).x), y: prePoint.y), controlPoint2: CGPoint.init(x: (prePoint.x+(nowPoint as! CGPoint).x)/2.0, y: (nowPoint as! CGPoint).y))
                    prePoint = nowPoint as! CGPoint;
                }
            }
        default:
            break;
        }

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.borderWidth = 2.0
        self.subviews[0].layer.addSublayer(shapeLayer)
        //添加目标值文字
        for idx in 0..<allPoints.count{
            let label = UILabel()
            label.textColor = UIColor.purple
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 10)
            self.subviews[0].addSubview(label)

            if idx % 2 == 0 {
                label.isHidden = false
            }else{
                label.isHidden = true
            }


            if idx == 0{
                let nowPoint = allPoints[0]
                label.text = "\((BezierCurveView.myFrame.height-(nowPoint as! CGPoint).y-Margin)/2.0)"
                label.frame = CGRect.init(x: (nowPoint as! CGPoint).x-Margin/2.0, y: (nowPoint as! CGPoint).y-20, width: Margin, height: 20)
                prePoint = nowPoint as! CGPoint
            }else{
                let nowPoint:CGPoint = allPoints[idx] as! CGPoint
                if(nowPoint.y < prePoint.y){//文字置于点上方
                    label.frame = CGRect.init(x: nowPoint.x-Margin/2.0, y: nowPoint.y-20, width: Margin, height: 20)
                }else{//文字置于点下方
                    label.frame = CGRect.init(x: nowPoint.x - Margin/2, y: nowPoint.y, width: Margin, height: 20)
                }
                label.text = "\((BezierCurveView.myFrame.height-nowPoint.y-Margin)/2.0)"
                prePoint = nowPoint
            }
        }
    }





    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
