import AudioToolbox
import Theme
import UIKit

public class LoginViewController: UIViewController {
    public var loginButtonHandler: ((String, String) -> Void)?

    let signUpLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Sign in"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        return label
    }()

    let imageViewUser = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(systemName: "person.circle.fill")
        view.contentMode = .scaleAspectFill
        view.image = image
        return view
    }()

    let loginTextField = {
        let textField = UITextField()
        textField.text = "Admin@yandex.ru"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.backgroundColor = .lightText
        textField.autocapitalizationType = .none
        return textField
    }()

    let passwordTextField = {
        let textField = UITextField()
        textField.text = "123456"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.backgroundColor = .lightText
        textField.isSecureTextEntry = true
        return textField
    }()

    let glassView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 280)
        view.layer.cornerRadius = 30
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = CGColor(red: 238 / 255, green: 238 / 255, blue: 238 / 255, alpha: 0.65)
        return view
    }()

    let animateButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.Colors.yellow
        setGlassViewSettings()
        setAnimateButtonSettings()
        setImageViewUser()
        setLoginTextField()
        setPasswordTextField()
        setSingUpLabel()
    }

    func setSingUpLabel() {
        view.addSubview(signUpLabel)
        view.sendSubviewToBack(signUpLabel)
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpLabel.topAnchor.constraint(equalTo: glassView.topAnchor, constant: -80).isActive = true
        signUpLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }

    func setImageViewUser() {
        glassView.addSubview(imageViewUser)
        imageViewUser.translatesAutoresizingMaskIntoConstraints = false
        imageViewUser.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewUser.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewUser.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewUser.topAnchor.constraint(equalTo: glassView.topAnchor, constant: 20).isActive = true
    }

    func setLoginTextField() {
        glassView.addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.centerXAnchor.constraint(equalTo: glassView.centerXAnchor).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: 240).isActive = true
        loginTextField.topAnchor.constraint(equalTo: imageViewUser.bottomAnchor, constant: 20).isActive = true
    }

    func setPasswordTextField() {
        glassView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: glassView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 240).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20).isActive = true
    }

    func setAnimateButtonSettings() {
        view.addSubview(animateButton)
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        animateButton.topAnchor.constraint(equalTo: glassView.bottomAnchor, constant: 20).isActive = true
        animateButton.rightAnchor.constraint(equalTo: glassView.rightAnchor).isActive = true
        animateButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        animateButton.addTarget(self, action: #selector(action), for: .touchUpInside)
    }

    @objc func action() {
        if let loginText = loginTextField.text, let passwordText = passwordTextField.text {
            loginButtonHandler?(loginText, passwordText)
        }
    }

   public func wrongDataAnimate() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: glassView.center.x - 10, y: glassView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: glassView.center.x + 10, y: glassView.center.y))
        glassView.layer.add(animation, forKey: "position")
    }

    func setGlassViewSettings() {
        glassView.applyBlurEffect()
       // imageView.addSubview(glassView)
        view.addSubview(glassView)
        glassView.clipsToBounds = true

        glassView.translatesAutoresizingMaskIntoConstraints = false
        glassView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        glassView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        glassView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        glassView.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }
}

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        blurEffectView.clipsToBounds = true
    }

    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 10
        layer.shadowOffset = .zero
        layer.shadowRadius = 100
    }
}
