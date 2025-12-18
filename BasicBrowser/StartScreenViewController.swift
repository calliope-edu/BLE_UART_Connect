import UIKit

class StartScreenViewController: UIViewController {
    
    // URLs für die 4 Views
    let urls = [
        "https://cardboard.lofirobot.com/control-calliope/",  // View 1 - FEST
        "https://cardboard.lofirobot.com/face-app/",  // View 2 - FEST
        "https://go.calliope.cc/teachablemachine/",  // View 3 - FEST
        ""                             // View 4 - EDITIERBAR
    ]
    
    let colors: [UIColor] = [
        .systemBlue,
        .systemGreen,
        .systemRed,
        .systemYellow
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Start"
        setupButtons()
    }
    
    private func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Obere Reihe (1, 2)
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.distribution = .fillEqually
        topRow.spacing = 8
        
        // Untere Reihe (3, 4)
        let bottomRow = UIStackView()
        bottomRow.axis = .horizontal
        bottomRow.distribution = .fillEqually
        bottomRow.spacing = 8
        
        for i in 0..<4 {
            let button = UIButton(type: .system)
            button.setTitle("\(i + 1)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 48)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = colors[i]
            button.layer.cornerRadius = 12
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            if i < 2 {
                topRow.addArrangedSubview(button)
            } else {
                bottomRow.addArrangedSubview(button)
            }
        }
        
        stackView.addArrangedSubview(topRow)
        stackView.addArrangedSubview(bottomRow)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        if index == 3 {
            // View 4 = Editierbare URL
            let contentVC = EditableURLViewController()
            contentVC.modalPresentationStyle = .fullScreen
            present(contentVC, animated: true)
        } else {
            // View 1-3 = Feste URLs
            let contentVC = ContentViewController()
            contentVC.urlString = urls[index]
            contentVC.viewTitle = "View \(index + 1)"
            contentVC.modalPresentationStyle = .fullScreen
            present(contentVC, animated: true)
        }
    }
}
