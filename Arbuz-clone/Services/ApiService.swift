//
//  ApiService.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 18.05.2024.
//

import Foundation

class ApiService: ObservableObject{
    static let shared = ApiService()
    private let baseURL = "http://192.168.1.223:8000/api" // Поменятей на свой локалхост апи
    private var token: String?
    
    private init(){}
    
    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login/") else { completion(.failure(APIError.noData)); return }
        
        let body: [String: String] = ["username": username, "password": password]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do {
                    let decodedData = try JSONDecoder().decode([String: String].self, from: data)
                    DispatchQueue.main.async {
                        self.token = decodedData["access"]
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(APIError.noData))
                    print("Error decoding data: \(error)")
                }
            }
            
        }.resume()
    }
    
    func signup(username: String, password: String, email: String, completion: @escaping (Result<Bool, Error>) -> Void){
        guard let url = URL(string: "\(baseURL)/signup/") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let body: [String: String] = ["username": username, "password": password, "email": email]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data{
                do {
                    let decodedData = try JSONDecoder().decode([String: String].self, from: data)
                    DispatchQueue.main.async {
                        if username == decodedData["username"] && email == decodedData["email"]{
                            completion(.success(true))
                        }else {
                            completion(.failure(APIError.noData))
                        }
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
    func putProduct(_ product: Product, completion: @escaping (Result<Bool, Error>) -> Void){
        guard let url = URL(string: "\(baseURL)/products/\(product.id)/") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token{
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let jsonData = try JSONEncoder().encode(product)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(APIError.decodingError))
                return
            }
            completion(.success(true))
        }.resume()
        
    }
    
    func putCart(_ cart: Cart, completion: @escaping (Result<Bool, Error>) -> Void){
        guard let url = URL(string: "\(baseURL)/carts/\(cart.id)/update_cart/") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token{
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    
        
        do {
            let jsonData = try JSONEncoder().encode(cart)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            print(request.allHTTPHeaderFields)
            print(request.httpMethod)
            if let rawString = String(data: request.httpBody!, encoding: .utf8) {
                print("Response Data: \(rawString)")
            }
            
//            let r = response as? HTTPURLResponse
//            print(r)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(APIError.decodingError))
                return
            }
            completion(.success(true))
        }.resume()
        
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products/") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchCart(completion: @escaping (Result<Cart, Error>) -> Void){
        guard let url = URL(string: "\(baseURL)/carts/") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                var cart = try JSONDecoder().decode([Cart].self, from: data)
                cart.sort(by: {$0.id > $1.id})
                if cart.first != nil{
                    completion(.success(cart.first!))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchCollections(for product: Product?, completion: @escaping (Result<[Collection], Error>) -> Void){
        guard let url = URL(string: "\(baseURL)/collections/") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let collections = try JSONDecoder().decode([Collection].self, from: data)
                let collection = collections.randomElement()
                if var collection = collection {
                    if product != nil{
                        collection.products = collection.products.filter {$0.id != product!.id}
                        completion(.success([collection]))
                    } else {
                        completion(.success(collections))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func logout(){
        token = nil
    }
    
    func isLoggedIn() -> Bool{
        return token != nil
    }
    
    
    enum APIError: Error {
        case invalidURL
        case noData
        case decodingError
    }
}
