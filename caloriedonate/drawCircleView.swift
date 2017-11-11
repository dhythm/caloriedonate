
import Foundation
import UIKit

class drawCircleView: UIView {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var total: Int?
    var goal: Int?
    
    let radius: CGFloat = 120
    let circleWidth: CGFloat = 20.0
    
    var ratio: Float?
    var ratioCircle: Float?
    var endCircle: Float?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        total = self.appDelegate._total
        goal  = self.appDelegate._goal
        
        //print(super.total)
        
        let cX: CGFloat = rect.size.width/2
        let cY: CGFloat = rect.size.height/2
        let circlePoint = CGPoint(x: cX, y: cY)
        
        ratio = Float(total!) / Float(goal!)
        ratioCircle = ratio! * Float(M_PI*2)
        endCircle = ratioCircle! + Float(-M_PI/2)
        
        /*
        // donate area
        let donateCircle: UIBezierPath = UIBezierPath(arcCenter: CGPoint(x: cX/2,y: cY/2), radius: radius/2, startAngle: 0.0, endAngle: CGFloat(M_PI - M_PI/3), clockwise: false)
        UIColor.cyan.setStroke()
        donateCircle.lineWidth = 5.0
        donateCircle.stroke()
         */
        
        // draw circle
        let goalCircle: UIBezierPath = UIBezierPath(arcCenter: circlePoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(M_PI*2), clockwise: true)
        UIColor.cyan.setStroke()
        goalCircle.lineWidth = circleWidth
        goalCircle.stroke()

        let totalCircle: UIBezierPath = UIBezierPath(arcCenter: circlePoint, radius: radius, startAngle: CGFloat(-M_PI/2), endAngle: CGFloat(endCircle!), clockwise: true)
        UIColor.red.setStroke()
        totalCircle.lineWidth = circleWidth
        totalCircle.stroke()

        // draw line
        let startLinePoint = CGPoint(x: cX + (radius - circleWidth), y: cY)
        let endLinePoint   = CGPoint(x: cX - (radius - circleWidth), y: cY)
        let separator: UIBezierPath = UIBezierPath()
        UIColor.gray.setStroke()
        separator.move(to: startLinePoint)
        separator.addLine(to: endLinePoint)
        separator.lineWidth = 2.5
        separator.apply(CGAffineTransform(translationX: cX, y: cY).inverted())
        separator.apply(CGAffineTransform(rotationAngle: CGFloat(M_PI*5/6)))
        separator.apply(CGAffineTransform(translationX: cX, y: cY))
        separator.stroke()

        // background circle
        let bgCircle: UIBezierPath = UIBezierPath(arcCenter: circlePoint, radius: 20, startAngle: 0.0, endAngle: CGFloat(M_PI*2), clockwise: true)
        UIColor.white.setFill()
        bgCircle.lineWidth = 0.0
        bgCircle.fill()
        bgCircle.stroke()

        
    }
    
}
