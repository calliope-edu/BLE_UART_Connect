import UIKit

class EditableURLViewController: UIViewController {
    
    private let urlTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Zurück-Button
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        backButton.tintColor = .systemBlue
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        view.addSubview(backButton)
        
        // URL TextField
        urlTextField.placeholder = "URL eingeben..."
        urlTextField.borderStyle = .roundedRect
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.returnKeyType = .go
        urlTextField.delegate = self
        view.addSubview(urlTextField)
        
        // WebView Container
        let webVC = WBWebViewContainerController()
        addChild(webVC)
        webVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webVC.view)
        webVC.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            urlTextField.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            urlTextField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            urlTextField.heightAnchor.constraint(equalToConstant: 40),
            
            webVC.view.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 8),
            webVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func goHome() {
        dismiss(animated: true)
    }
}

extension EditableURLViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let urlString = textField.text, let url = URL(string: urlString) {
            // WebView mit URL laden
            if let webVC = children.first as? WBWebViewContainerController {
                webVC.loadURL(url)
            }
        }
        return true
    }
}

