//
//  CustomCell.swift
//  8homework4m
//
//  Created by mavluda on 6/5/23.
//

import Foundation
import UIKit
import SnapKit

class CustomCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var topLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var middleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private lazy var bottomLabel: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textAlignment = .center
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        addSubview(middleLabel)
        middleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(middleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    func fill(model: Data){
        topLabel.text = "#" + String(model.id) + " Post | " + String(model.userId) + " ID"
        middleLabel.text = model.title
        bottomLabel.text = model.body
    }
    
}
