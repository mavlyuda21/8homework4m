//
//  ViewController.swift
//  8homework4m
//
//  Created by mavluda on 6/5/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(CustomCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .orange
        return view
    }()
    
    private var array = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    private func loadData(){
        NetworkManager.shared.getRequest { array in
            self.array = array
            self.reloadTable()
        }
    }
    
    private func reloadTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.fill(model: array[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EditorController()
        controller.fill(model: array[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}


