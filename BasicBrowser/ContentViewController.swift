import UIKit
import WebKit

class ContentViewController: UIViewController {
    
    var urlString: String = ""
    var viewTitle: String = ""
    private var webVC: WBWebViewContainerController?
    
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
        
        // WebView Container
        let webViewController = WBWebViewContainerController()
        self.webVC = webViewController
        addChild(webViewController)
        webViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webViewController.view)
        webViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            
            webViewController.view.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 8),
            webViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // URL laden nach View erscheint
        if let url = URL(string: urlString) {
            webVC?.loadURL(url)
        }
    }
    
    @objc private func goHome() {
        dismiss(animated: true)
    }
}
