//
//  HoldingsViewController.swift
//  Assignment
//
//  Created by Sapna Fulwani on 18/11/24.
//

import UIKit

class HoldingsViewController: UIViewController {
    private let viewModel = HoldingsViewModel()
    private let tableView = UITableView()
    private let headerLabel = UILabel()
    private var bottomButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBottomBar()
        fetchData()
        view.backgroundColor = UIColor(hex: "#003264")
        print("HoldingsVC is loaded successfully!")
    }
    
    private func setupUI() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.backgroundColor = UIColor(hex: "#003264")
        headerLabel.textColor = .white
        headerLabel.clipsToBounds = true
        
        let profileImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        profileImageView.tintColor = .white
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = UILabel()
        textLabel.text = "Portfolio"
        textLabel.textColor = .white
        textLabel.font = UIFont.systemFont(ofSize: 19, weight: .light)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSAttributedString.Key: Any] = [.kern: 0.5]
        let attributedString = NSAttributedString(string: "Portfolio", attributes: attributes)
        textLabel.attributedText = attributedString
        
        let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.up.arrow.down"))
        arrowImageView.tintColor = .white
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = .white
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        headerLabel.addSubview(profileImageView)
        headerLabel.addSubview(textLabel)
        headerLabel.addSubview(arrowImageView)
        headerLabel.addSubview(searchImageView)
        
        
        view.addSubview(headerLabel)
        
        let positionsLabel = UILabel()
        positionsLabel.translatesAutoresizingMaskIntoConstraints = false
        positionsLabel.text = "POSITIONS"
        positionsLabel.font = UIFont.boldSystemFont(ofSize: 12)
        positionsLabel.textColor = .lightGray
        
        let holdingsLabel = UILabel()
        holdingsLabel.translatesAutoresizingMaskIntoConstraints = false
        holdingsLabel.text = "HOLDINGS"
        holdingsLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1.0
        
        containerView.addSubview(positionsLabel)
        containerView.addSubview(holdingsLabel)
        
        view.addSubview(containerView)
        
        
        tableView.dataSource = self
        tableView.register(HoldingCell.self, forCellReuseIdentifier: "HoldingCell")
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            profileImageView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor, constant: 12),
            profileImageView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 23),
            profileImageView.heightAnchor.constraint(equalToConstant: 23),
            
            
            textLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            textLabel.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            
            arrowImageView.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 10),
            arrowImageView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            
            searchImageView.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 35),
            searchImageView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: -15),
            searchImageView.centerYAnchor.constraint(equalTo:headerLabel.centerYAnchor),
            searchImageView.widthAnchor.constraint(equalToConstant: 20),
            searchImageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            containerView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            positionsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60),
            positionsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            holdingsLabel.leadingAnchor.constraint(equalTo: positionsLabel.trailingAnchor, constant: 120),
            holdingsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            holdingsLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10),
            
            
            
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func setupBottomBar() {
        let bottomBar = UIView()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = .white
        view.addSubview(bottomBar)
        
        NSLayoutConstraint.activate([
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        bottomBar.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: bottomBar.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor)
        ])
        
        let options = [
            ("WatchList", "line.3.horizontal.decrease.circle"),
            ("Orders", "clock"),
            ("Portfolio", "briefcase"),
            ("Funds", "dollarsign.circle"),
            ("Invest", "percent")
        ]
        
        for (index, option) in options.enumerated() {
            let button = createBottomBarButton(title: option.0, systemSymbolName: option.1, tag: index)
            stackView.addArrangedSubview(button)
            bottomButtons.append(button)
        }
    }
    
    
    
    private func createBottomBarButton(title: String, systemSymbolName: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.addTarget(self, action: #selector(bottomBarButtonTapped(_:)), for: .touchUpInside)
        
        let imageView = UIImageView(image: UIImage(systemName: systemSymbolName))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.8)
        ])
        
        return button
    }
    
    private func fetchData() {
        viewModel.fetchHoldings { [weak self] success in
            DispatchQueue.main.async {
                if success {
                   // self?.updateSummary()
                    self?.tableView.reloadData()
                } else {
                    self?.showError()
                }
            }
        }
    }
    
    
    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Failed to fetch data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension HoldingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.holdings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCell", for: indexPath) as! HoldingCell
        let holding = viewModel.holdings[indexPath.row]
        let pnl = (holding.ltp - holding.avgPrice) * Double(holding.quantity)
        cell.configure(with: holding, pnl: pnl)
        return cell
    }


}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


