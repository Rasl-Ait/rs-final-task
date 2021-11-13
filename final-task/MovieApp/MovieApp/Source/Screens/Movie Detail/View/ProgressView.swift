//
//  ProgressView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

final class ProgressView: UIView {
  
  // MARK: - Properties
  private lazy var label = makeLabel()
  private let shapeLayer = CAShapeLayer()
  private var timer: Timer?
  private var time = 0
  private var average = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(movie: MovieDetailModel) {
    time = 0
    average = movie.score.toInt
    runTimer()
  }
  
  func runTimer() {
    let timer = Timer.scheduledTimer(timeInterval: 0.015,
                                     target: self, selector: #selector(update),
                                     userInfo: nil, repeats: true)
    RunLoop.current.add(timer, forMode: .common)
    self.timer = timer
  }
  
  @objc func update() {
    time += 1
    if time == average {
      timer?.invalidate()
     
    }
    
    mainQueue {
      self.label.text = "\(self.time)%"
      
      if self.time < 30 {
        self.shapeLayer.strokeColor = UIColor.red.cgColor
      } else if self.time < 50 {
        self.shapeLayer.strokeColor = UIColor.yellow.cgColor
      } else {
        self.shapeLayer.strokeColor = UIColor.green.withAlphaComponent(0.5).cgColor
      }
      
      self.shapeLayer.strokeEnd = CGFloat(Double(self.time) / 100)
    }
  }
}

private extension ProgressView {
  func setupView() {
    backgroundColor = .black
    addBlurToView()
    layer.cornerRadius = 60 / 2
    clipsToBounds = true
    addSubview(label)
    setupLayoutUI()
    
    // create my track layer
    let center = CGPoint(x: 30, y: 30)
    let circularPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    let trackLayer = CAShapeLayer()
    trackLayer.path = circularPath.cgPath
    
    trackLayer.strokeColor = UIColor.lightGray.cgColor
    trackLayer.lineWidth = 8
    trackLayer.fillColor = UIColor.clear.cgColor
    trackLayer.lineCap = .round
    layer.addSublayer(trackLayer)
    
    shapeLayer.path = circularPath.cgPath

    shapeLayer.strokeColor = UIColor.red.cgColor
    shapeLayer.lineWidth = 8
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.lineCap = .round
    shapeLayer.strokeEnd = 0
  
    layer.addSublayer(shapeLayer)
  }
  
  func setupLayoutUI() {
    label.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func makeLabel() -> UILabel {
    let view = UILabel("0%",
                       alignment: .center,
                       color: .averageTintColor,
                       fontName: .avenir(.fontML, .Bold)
    )
    return view
  }
}

#if DEBUG
import SwiftUI

struct ProgressViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ProgressView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ProgressView_Preview: PreviewProvider {
  static var previews: some View {
    ProgressViewRepresentable()
      .frame(width: 60, height: 60)
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewLayout(.fixed(width: 100, height: 100))
  }
}
#endif
