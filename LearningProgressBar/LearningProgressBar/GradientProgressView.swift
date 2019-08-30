//
//  GradientProgressView.swift
//  LearningProgressBar
//
//  Created by Changhao Li on 2019/8/29.
//  Copyright © 2019 Changhao Li. All rights reserved.
//

import UIKit
import SnapKit

class GradientProgressView: UIView {
    // 线宽
    var lineWitdh: CGFloat = 10.0

    var progress: CGFloat = 0.0 {
        didSet {
            progressLayer.strokeEnd = progress
            let percent = Int(progress * 100)
            progressTextLabel.text = "\(percent)%"
        }
    }

    let progressLayer: CAShapeLayer = CAShapeLayer()

    let whiteBallLayer: CAShapeLayer = CAShapeLayer()

    lazy var studyTextLabel: UILabel = {
        let studyTextLabel = UILabel()
        studyTextLabel.textAlignment = .center
        studyTextLabel.text = "学习进度"
        studyTextLabel.font = UIFont.systemFont(ofSize: 11)
        studyTextLabel.textColor = UIColor(red: 98 / 255.0, green: 98 / 255.0, blue: 98 / 255.0, alpha: 1.0)
        return studyTextLabel
    }()

    lazy var progressTextLabel: UILabel = {
        let progressTextLabel = UILabel()
        progressTextLabel.textAlignment = .center
        progressTextLabel.text = "0%"
        progressTextLabel.font = UIFont.systemFont(ofSize: 31)
        progressTextLabel.textColor = UIColor(red: 129 / 255.0, green: 188 / 255.0, blue: 98 / 255.0, alpha: 1.0)
        return progressTextLabel
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        drawScaleLine()
        drawSemicircle()
        setupViews()
    }

    convenience init(frame: CGRect, lineWith: CGFloat) {
        self.init(frame: frame)
        self.lineWitdh = lineWith
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let circleLayer: CAShapeLayer = CAShapeLayer()
        circleLayer.frame = bounds
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1.0).cgColor
        circleLayer.lineWidth = lineWitdh
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd = 1
        circleLayer.lineCap = .round

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height - lineWitdh / 2), radius: rect.size.height - lineWitdh, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
        circleLayer.path = circlePath.cgPath
        layer.addSublayer(circleLayer)

        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.lineWidth = lineWitdh
        progressLayer.strokeStart = 0
        progressLayer.lineCap = .round
        progressLayer.path = circlePath.cgPath
        layer.addSublayer(progressLayer)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)

        let leftGradientLayer = CAGradientLayer()
        leftGradientLayer.frame = CGRect(x: 0, y: 0, width: rect.size.width / 2, height: rect.size.height)
        leftGradientLayer.colors = [UIColor(red: 240 / 255.0, green: 214 / 255.0, blue: 100 / 255.0, alpha: 1.0).cgColor, UIColor(red: 182 / 255.0, green: 213 / 255.0, blue: 141 / 255.0, alpha: 1.0).cgColor]
        leftGradientLayer.locations = [0, 0.9]
        leftGradientLayer.startPoint = CGPoint(x: 0, y: 1)
        leftGradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.addSublayer(leftGradientLayer)

        let rightGradientLayer = CAGradientLayer()
        rightGradientLayer.frame = CGRect(x: rect.size.width / 2, y: 0, width: rect.size.width / 2, height: rect.size.height)
        rightGradientLayer.colors = [UIColor(red: 182 / 255.0, green: 213 / 255.0, blue: 141 / 255.0, alpha: 1.0).cgColor, UIColor(red: 129 / 255.0, green: 188 / 255.0, blue: 98 / 255.0, alpha: 1.0).cgColor]
        rightGradientLayer.locations = [0.1, 1]
        rightGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        rightGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.addSublayer(rightGradientLayer)
    }

    public func animateToProgress(_ progress: CGFloat) {
        self.progress = progress
        let animation = CABasicAnimation()
        animation.keyPath = "strokeEnd"
        animation.duration = 1.2
        animation.fromValue = 0
        progressLayer.strokeEnd = progress
        progressLayer.add(animation, forKey: nil)
    }

    private func drawScaleLine() {
        let radius = frame.size.height - lineWitdh - 8
        let squareLength = sqrt(2) / 2 * radius

        let leftHorizontalLinePath = UIBezierPath()
        leftHorizontalLinePath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height))
        leftHorizontalLinePath.addLine(to: CGPoint(x: frame.size.width / 2 - radius, y: frame.size.height))
        let leftHorizontalLineLayer = CAShapeLayer()
        leftHorizontalLineLayer.lineWidth = 1
        leftHorizontalLineLayer.strokeColor = UIColor(red: 196 / 255.0, green: 223 / 255.0, blue: 181 / 255.0, alpha: 1.0).cgColor
        leftHorizontalLineLayer.path = leftHorizontalLinePath.cgPath
        leftHorizontalLineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(leftHorizontalLineLayer)

        let rightHorizontalLinePath = UIBezierPath()
        rightHorizontalLinePath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height))
        rightHorizontalLinePath.addLine(to: CGPoint(x: frame.size.width / 2 + radius, y: frame.size.height))
        let rightHorizontalLineLayer = CAShapeLayer()
        rightHorizontalLineLayer.lineWidth = 1
        rightHorizontalLineLayer.strokeColor = UIColor(red: 196 / 255.0, green: 223 / 255.0, blue: 181 / 255.0, alpha: 1.0).cgColor
        rightHorizontalLineLayer.path = rightHorizontalLinePath.cgPath
        rightHorizontalLineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(rightHorizontalLineLayer)

        let verticalLinePath = UIBezierPath()
        verticalLinePath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height))
        verticalLinePath.addLine(to: CGPoint(x: frame.size.width / 2, y: lineWitdh + 8))
        let verticalLineLayer = CAShapeLayer()
        verticalLineLayer.lineWidth = 1
        verticalLineLayer.strokeColor = UIColor(red: 196 / 255.0, green: 223 / 255.0, blue: 181 / 255.0, alpha: 1.0).cgColor
        verticalLineLayer.path = verticalLinePath.cgPath
        verticalLineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(verticalLineLayer)

        let left45DegreesLinePath = UIBezierPath()
        left45DegreesLinePath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height))
        left45DegreesLinePath.addLine(to: CGPoint(x: frame.size.width / 2 - squareLength, y: frame.size.height - squareLength))
        let left45DegreesLineLayer = CAShapeLayer()
        left45DegreesLineLayer.lineWidth = 1
        left45DegreesLineLayer.strokeColor = UIColor(red: 196 / 255.0, green: 223 / 255.0, blue: 181 / 255.0, alpha: 1.0).cgColor
        left45DegreesLineLayer.path = left45DegreesLinePath.cgPath
        left45DegreesLineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(left45DegreesLineLayer)

        let right45DegreesLinePath = UIBezierPath()
        right45DegreesLinePath.move(to: CGPoint(x: frame.size.width / 2, y: frame.size.height))
        right45DegreesLinePath.addLine(to: CGPoint(x: frame.size.width / 2 + squareLength, y: frame.size.height - squareLength))
        let right45DegreesLineLayer = CAShapeLayer()
        right45DegreesLineLayer.lineWidth = 1
        right45DegreesLineLayer.strokeColor = UIColor(red: 196 / 255.0, green: 223 / 255.0, blue: 181 / 255.0, alpha: 1.0).cgColor
        right45DegreesLineLayer.path = right45DegreesLinePath.cgPath
        right45DegreesLineLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(right45DegreesLineLayer)
    }

    private func drawSemicircle() {
        let radius = frame.size.height - lineWitdh - 8 - 8
        let semicirclePath = UIBezierPath()
        semicirclePath.addArc(withCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height), radius: radius, startAngle: .pi, endAngle: 2 * .pi, clockwise: true)
        semicirclePath.lineWidth = radius
        semicirclePath.addLine(to: CGPoint(x: frame.size.width / 2, y: frame.size.height))
        semicirclePath.close()
        let semicircleLayer = CAShapeLayer()
        semicircleLayer.frame = bounds
        semicircleLayer.path = semicirclePath.cgPath
        semicircleLayer.fillColor = UIColor.white.cgColor
        semicircleLayer.strokeColor = UIColor.white.cgColor
        semicircleLayer.shadowColor = UIColor(red: 196 / 255.0, green: 223 / 255.0, blue: 181 / 255.0, alpha: 1.0).cgColor
        semicircleLayer.shadowOpacity = 0.6
        semicircleLayer.shadowOffset = CGSize(width: 0, height: -2)
        layer.addSublayer(semicircleLayer)
    }

    private func setupViews() {
        addSubview(studyTextLabel)
        addSubview(progressTextLabel)

        studyTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }

        progressTextLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(studyTextLabel.snp.bottom).offset(14)
        }
    }

}
