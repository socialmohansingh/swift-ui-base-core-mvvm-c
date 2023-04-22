//  IndicatorView.swift
//  Created by bemohansingh on 4/28/20.

import UIKit

public protocol IndicatorConfig {
    var padding: CGFloat { get }
    var indicatorColor: UIColor { get }
    var indicatorDimension: CGSize { get }
    var startAngle: CGFloat { get }
    var endAngle: CGFloat { get }
}

struct DefaultConfig: IndicatorConfig {
    
    /// The padding of the indicator
    var padding: CGFloat = 10.0
    
    /// The color for the indicator
    var indicatorColor: UIColor = .red
    
    /// The dimension of the indicator
    var indicatorDimension: CGSize = CGSize(width: 60.0, height: 60.0)
    
    /// The angle at which the indicator circle starts
    var startAngle: CGFloat = .pi
    
    /// The angle at which the indicator circle ends
    var endAngle: CGFloat = (2 * .pi)

}

open class IndicatorView: UIView {
    
    /// initialize with frame
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// The animating layer
    private var animator: CAShapeLayer!
    
    /// Shows the indicator
    open func showIndicator(config: IndicatorConfig) {
        animator = getAnimatorLayer(config: config)
        animator.add(getRotatingAnimation(), forKey: "Rotator")
        layer.addSublayer(animator)
    }
    
    /// hides the indicator
    open func hideIndicator() {
        if animator != nil {
            animator.removeAllAnimations()
            animator.removeFromSuperlayer()
        }
        animator = nil
    }

    /// The animator layer
    private func getAnimatorLayer(config: IndicatorConfig) -> CAShapeLayer {
        let diameter = self.bounds.height - (config.padding * 2)
        let xFromCenter = (bounds.width / 2.0 - diameter / 2.0)
        let yFromCenter = (bounds.height - diameter) / 2.0
        let smallRect = CGRect(x: xFromCenter, y: yFromCenter, width: diameter, height: diameter)
        let path = UIBezierPath(arcCenter: CGPoint(x: smallRect.width / 2.0, y: smallRect.height / 2.0), radius: diameter / 2.0, startAngle: config.startAngle , endAngle: config.endAngle, clockwise: true)
        let shape = CAShapeLayer()
        shape.frame = smallRect
        shape.path = path.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = config.indicatorColor.cgColor
        shape.lineWidth = 2.0
        return shape
    }

    /// The basic rotating animation
    private func getRotatingAnimation() -> CABasicAnimation {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 1.0
        rotateAnimation.repeatCount = Float.infinity
        rotateAnimation.isRemovedOnCompletion = false
        return rotateAnimation
    }
}
