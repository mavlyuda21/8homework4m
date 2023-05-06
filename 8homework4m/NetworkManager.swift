//
//  NetworkManager.swift
//  8homework4m
//
//  Created by mavluda on 6/5/23.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    
    func getRequest(completed: @escaping([Data]) -> ()) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error == nil {
                do {
                    let response = try JSONDecoder().decode([Data].self, from: data!)
                    DispatchQueue.main.async {
                        completed(response)
                    }
                } catch {
                    print("JSON Error")
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
    func putRequest(id: Int,userId: Int, title: String, body: String) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")
        
        let body = [
            "id": "\(id)",
            "userId": "\(userId)",
            "title": title,
            "body": body
        ]
        
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        
        let jsonData = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            let responseCode = urlResponse as! HTTPURLResponse
            print(responseCode.statusCode)
            
            if error == nil {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!)
                    print(result)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
}
