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
    private let pnlView = UIView()
    private let arrowImageView = UIImageView()
    private let pnlExpandableView = UIView()
    private var isExpanded = false
    
    
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
            bottomBar.heightAnchor.constraint(equalToConstant: 70),
            
            
        ])
        
        let options = [
            ("WatchList", "line.3.horizontal.decrease.circle"),
            ("Orders", "clock"),
            ("Portfolio", "briefcase"),
            ("Funds", "dollarsign.circle"),
            ("Invest", "percent")
        ]
        
        let buttonHorizontalPadding: CGFloat = 12.0
        let buttonBottomPadding: CGFloat = 8.0
        let totalHorizontalPadding = buttonHorizontalPadding * CGFloat(options.count + 1)
        let buttonWidth = (UIScreen.main.bounds.width - totalHorizontalPadding) / CGFloat(options.count)
        
        for (index, option) in options.enumerated() {
            let button = createBottomBarButton(title: option.0, systemSymbolName: option.1, tag: index)
            bottomBar.addSubview(button)
            bottomButtons.append(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: buttonBottomPadding),
                button.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -buttonBottomPadding),
                button.widthAnchor.constraint(equalToConstant: buttonWidth)
            ])
            
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor, constant: buttonHorizontalPadding).isActive = true
            } else if index == options.count - 1 {
                button.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor, constant: -buttonHorizontalPadding).isActive = true
                button.leadingAnchor.constraint(equalTo: bottomButtons[index - 1].trailingAnchor, constant: buttonHorizontalPadding).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: bottomButtons[index - 1].trailingAnchor, constant: buttonHorizontalPadding).isActive = true
            }
        }
    }
    
    private func createBottomBarButton(title: String, systemSymbolName: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bottomBarButtonTapped(_:)), for: .touchUpInside)
        
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
        
        button.addSubview(imageView)
        button.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.4),
            imageView.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.4),
            
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -4)
        ])
        
        return button
    }
    
    
    @objc private func bottomBarButtonTapped(_ sender: UIButton) {
        print("button tapped")
        
    }
    
    private func setupPnlView() {
        
        pnlView.translatesAutoresizingMaskIntoConstraints = false
        pnlView.backgroundColor =  UIColor(hex: "#F5F5F5")
        pnlView.isUserInteractionEnabled = true
        view.addSubview(pnlView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pnlTapped))
        pnlView.addGestureRecognizer(tapGesture)
        
        let titleLabel = UILabel()
        titleLabel.text = "Profit & Loss *"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        arrowImageView.image = UIImage(systemName: "arrow.up")
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = String(format: "%.2f", viewModel.todaysPNL)
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = viewModel.todaysPNL >= 0 ? UIColor.systemGreen : UIColor.red;
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pnlView.addSubview(titleLabel)
        pnlView.addSubview(arrowImageView)
        pnlView.addSubview(valueLabel)
        
        
        NSLayoutConstraint.activate([
            
            pnlView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60 ),
            pnlView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pnlView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            pnlView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.leadingAnchor.constraint(equalTo: pnlView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: pnlView.centerYAnchor),
            
            arrowImageView.centerYAnchor.constraint(equalTo: pnlView.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            arrowImageView.widthAnchor.constraint(equalToConstant: 15),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15),
            
            valueLabel.trailingAnchor.constraint(equalTo: pnlView.trailingAnchor, constant: -16),
            valueLabel.centerYAnchor.constraint(equalTo: pnlView.centerYAnchor)
        ])
        
    }
    
    private func setupPnlExpandableView() {
        pnlExpandableView.translatesAutoresizingMaskIntoConstraints = false
        pnlExpandableView.backgroundColor = UIColor(hex: "#F5F5F5")
        pnlExpandableView.isHidden = true
        view.addSubview(pnlExpandableView)
        
        let titleLabel1 = createLabel(text: "Current Value *", fontSize: 14)
        let valueLabel1 = createLabel(text: String(format: "%.2f", viewModel.currentValue), fontSize: 16, textColor: .black)
        
        let titleLabel2 = createLabel(text: "Total Investment *", fontSize: 14)
        let valueLabel2 = createLabel(text: String(format: "%.2f", viewModel.totalInvestment), fontSize: 16, textColor: .black)
        
        let titleLabel3 = createLabel(text: "Today's PNL *", fontSize: 14)
        let valueLabel3 = createLabel(text: String(format: "%.2f", viewModel.totalPNL), fontSize: 16, textColor: viewModel.totalPNL >= 0 ? UIColor.systemGreen : UIColor.red )
        
        pnlExpandableView.addSubview(titleLabel1)
        pnlExpandableView.addSubview(valueLabel1)
        pnlExpandableView.addSubview(titleLabel2)
        pnlExpandableView.addSubview(valueLabel2)
        pnlExpandableView.addSubview(titleLabel3)
        pnlExpandableView.addSubview(valueLabel3)
        
        NSLayoutConstraint.activate([
            titleLabel1.leadingAnchor.constraint(equalTo: pnlExpandableView.leadingAnchor, constant: 16),
            titleLabel1.topAnchor.constraint(equalTo: pnlExpandableView.topAnchor),
            valueLabel1.trailingAnchor.constraint(equalTo: pnlExpandableView.trailingAnchor, constant: -16),
            valueLabel1.centerYAnchor.constraint(equalTo: titleLabel1.centerYAnchor),
            
            titleLabel2.leadingAnchor.constraint(equalTo: pnlExpandableView.leadingAnchor, constant: 16),
            titleLabel2.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor),
            valueLabel2.trailingAnchor.constraint(equalTo: pnlExpandableView.trailingAnchor, constant: -16),
            valueLabel2.centerYAnchor.constraint(equalTo: titleLabel2.centerYAnchor),
            
            titleLabel3.leadingAnchor.constraint(equalTo: pnlExpandableView.leadingAnchor, constant: 16),
            titleLabel3.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor),
            valueLabel3.trailingAnchor.constraint(equalTo: pnlExpandableView.trailingAnchor, constant: -16),
            valueLabel3.centerYAnchor.constraint(equalTo: titleLabel3.centerYAnchor),
            
            titleLabel1.heightAnchor.constraint(equalTo: titleLabel2.heightAnchor),
            titleLabel2.heightAnchor.constraint(equalTo: titleLabel3.heightAnchor),
            titleLabel3.bottomAnchor.constraint(equalTo: pnlExpandableView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pnlExpandableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pnlExpandableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pnlExpandableView.bottomAnchor.constraint(equalTo: pnlView.topAnchor),
            pnlExpandableView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func createLabel(text: String, fontSize: CGFloat, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
    @objc private func pnlTapped() {
        isExpanded.toggle()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowImageView.transform = self.isExpanded
            ? CGAffineTransform(rotationAngle: .pi)
            : CGAffineTransform.identity
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pnlExpandableView.isHidden = !self.isExpanded
        })
    }
    
    
    private func fetchData() {
        viewModel.fetchHoldings { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.setupPnlView()
                    self?.setupPnlExpandableView()
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


