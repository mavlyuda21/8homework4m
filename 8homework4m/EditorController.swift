//
//  EditorController.swift
//  8homework4m
//
//  Created by mavluda on 6/5/23.
//

import Foundation
import UIKit
import SnapKit

class EditorController: UIViewController{
    
    private lazy var topLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        view.text = "Title:"
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter Data"
        return view
    }()
    
    private lazy var middleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.text = "Body:"
        view.textAlignment = .center
        return view
    }()
    
    private lazy var bodyTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter Data"
        return view
    }()
    
    private lazy var putButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("PUT", for: .normal)
        view.backgroundColor = .orange
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(putButtonTapped(view:)), for: .touchUpInside)
        return view
    }()
    
    private var id = 0
    private var userId = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        layoutSubviews()
    }
    
    func layoutSubviews(){
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(middleLabel)
        middleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(bodyTextField)
        bodyTextField.snp.makeConstraints { make in
            make.top.equalTo(middleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(putButton)
        putButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bodyTextField.snp.bottom).offset(28)
            make.height.equalTo(50)
            make.width.equalTo(70)
        }
    }
    
    @objc func putButtonTapped(view: UIButton){
        if !(titleTextField.text?.isEmpty ?? true) && !(bodyTextField.text?.isEmpty ?? true){
            NetworkManager.shared.putRequest(id: id, userId: userId, title: titleTextField.text!, body: bodyTextField.text!)
            navigationController?.popToRootViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "No input data", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    func fill(model: Data){
        self.id = model.id
        self.userId = model.userId
        self.titleTextField.text = model.title
        self.bodyTextField.text = model.body
    }
}
