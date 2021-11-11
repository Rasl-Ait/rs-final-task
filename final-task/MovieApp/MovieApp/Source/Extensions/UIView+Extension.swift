
import UIKit.UIView

extension UIView {
  var safeAreaTop: CGFloat {
    if #available(iOS 11, *) {
      if let window = UIApplication.shared.keyWindowInConnectedScenes {
        return window.safeAreaInsets.top
      }
    }
    return 0
  }
  
  var width: CGFloat {
    return frame.size.width
  }
  
  var height: CGFloat {
			return frame.size.height
	}

	var left: CGFloat {
			return frame.origin.x
	}

	var right: CGFloat {
			return left + width
	}

	var top: CGFloat {
			return frame.origin.y
	}

	var bottom: CGFloat {
			return top + height
	}

	func circle() {
		let raduis = self.bounds.width / 2
		self.layer.cornerRadius = raduis
		self.clipsToBounds = true
	}
	
	func centerCrop() {
		contentMode = .scaleAspectFill
		clipsToBounds = true
	}
  
  func addShadow(ofColor color: UIColor = .black, radius: CGFloat = 1, offset: CGSize = .init(width: 0, height: 2), opacity: Float = 0.15) {
      layer.shadowColor = color.cgColor
      layer.shadowOffset = offset
      layer.shadowRadius = radius
      layer.shadowOpacity = opacity
      layer.masksToBounds = false
  }
	
	func borderColorView(borderWidht: CGFloat, borderColor: UIColor) {
		layer.borderColor = borderColor.cgColor
		layer.borderWidth = borderWidht
	}
	
	func radius() {
		layer.cornerRadius = layer.bounds.height / 2
		// layer.masksToBounds = false
	}
	
	func disableAutoresizingMask() {
		self.translatesAutoresizingMaskIntoConstraints = false
	}
  
  func addBlurToView() {
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(blurEffectView)
  }
  
  func removeBlurView() {
    for view in subviews where view is UIVisualEffectView {
        view.removeFromSuperview()
    }
  }
  
  func shake(for duration: TimeInterval = 0.4, withTranslation translation: CGFloat = 10) {
      let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
          self.transform = CGAffineTransform(translationX: translation, y: 0)
      }

      propertyAnimator.addAnimations({
        self.transform = .identity
      }, delayFactor: 0.2)

      propertyAnimator.startAnimation()
  }
  
  func scale(_ duration: TimeInterval, view: UIView, scaleX: CGFloat, scaleY: CGFloat) {
    UIView.animate(withDuration: duration) {
      view.transform = .init(scaleX: scaleX, y: scaleY)
    }
  }
}
