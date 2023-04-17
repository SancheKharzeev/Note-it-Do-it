//
//  FooterTableView.swift
//  Note it Do it
//
//  Created by Александр Х on 16.04.2023.
//

import UIKit

class FooterTableView: UITableViewHeaderFooterView {
    static let identifier = "FooterTableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 0,
                             y: contentView.frame.size.height+10+label.frame.size.height,
                             width: contentView.frame.size.width,
                             height: label.frame.size.height)
    }
}

