
//
import UIKit
import Lottie


class BaseVC: UIViewController {
    var isRemovedPullUp: (() -> Void)?
    lazy private var activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = .black
        activity.backgroundColor = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
  
    lazy var dotsAnimationView: AnimationView = {
        let anView = AnimationView()
        anView.backgroundColor = UIColor.clear
        anView.animation = Animation.named(LottieFiles.Dots.getFileName(), bundle: .main, subdirectory: nil, animationCache: nil)
        anView.loopMode = .loop
        anView.animationSpeed = 2.0
        anView.contentMode = .scaleAspectFill
        return anView
    }()
    
    lazy var lineAnimation: AnimationView = {
        let anView = AnimationView()
        anView.backgroundColor = UIColor.clear
        anView.animation = Animation.named(LottieFiles.Uploading.getFileName(), bundle: .main, subdirectory: nil, animationCache: nil)
        anView.animationSpeed = 2.0
        anView.loopMode = .loop
        anView.contentMode = .scaleAspectFit
        return anView
    }()
    
    lazy var uploadAnimation: AnimationView = {
        let anView = AnimationView()
        anView.backgroundColor = UIColor.clear
        anView.animation = Animation.named(LottieFiles.Uploading.getFileName(), bundle: .main, subdirectory: nil, animationCache: nil)
        anView.animationSpeed = 2.0
        anView.loopMode = .loop
        anView.contentMode = .scaleAspectFit
        return anView
    }()
    
    lazy var errorView: ErrorView = {
        let eView: ErrorView = .fromNib()
        return eView
    }()
    
    @IBOutlet var btnBack : UIButton!
    @IBOutlet var lblHeaderTitle : UILabel!
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
       // self.isRemovedPullUp?()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    public func playLineAnimation() {
        activityView.removeFromSuperview()
        activityView.backgroundColor = .clear
        activityView  = UIActivityIndicatorView(frame: CGRect(x: view.frame.size.width/2-15 , y: view.frame.size.height-60, width: 30, height: 30))
        activityView.startAnimating()
        activityView.color = .black
        activityView.style = .medium
        activityView.isHidden = false
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
    }
    
    public func stopLineAnimation() {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
    
    
    public func playUploadAnimation(on sampleView: UIView) {
        uploadAnimation.frame = sampleView.bounds
        sampleView.addSubview(uploadAnimation)
        uploadAnimation.play()
    }
    
    public func stopUploadAnimation() {
        uploadAnimation.stop()
        uploadAnimation.removeFromSuperview()
    }
    
    public func showVCPlaceholder(type: NoDataType, scrollView: UIScrollView?) {
        guard let scrollableView = scrollView else {
            return
        }
        errorView.frame = scrollableView.bounds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            scrollableView.addSubview(self.errorView)
            self.errorView.showNoDataWithImage(type: type)
        }
    }
    
    public func showErrorView(error: String, scrollView: UIScrollView?, tapped: (() -> Void)?) {
        guard let scrollableView = scrollView else {
            return
        }
        errorView.frame = scrollableView.bounds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let customErrorView = self?.errorView {
                scrollableView.addSubview(customErrorView)
                customErrorView.handleErrorView(animation: .Error, text: error, btnTitle: "RETRY") {
                    tapped?()
                }
            }
        }
    }
  
}
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
}
