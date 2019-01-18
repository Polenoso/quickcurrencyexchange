//
//  Network.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

enum NetworkError: Swift.Error {
    case unreachable(String)
    case parsing(String)
    case invalid(String)
    
    var localizedDescription: String {
        switch self {
        case .unreachable(let data):
            return data
        case .parsing(let data):
            return data
        case .invalid(let data):
            return data
        }
    }
}

enum Result<T> {
    case success(T)
    case error(Swift.Error)
}

protocol NetworkProtocol {
    
}

final class Network: NetworkProtocol {
    
    static let shared: Network = Network()
    
    private init() {}
    
    func getData<T:Decodable>(type: T.Type, with path: String, from url: String, completion:((Result<T>) -> ())?) {
        
        guard let urlC = URL(string: url) else {
            completion?(Result.error(NetworkError.invalid("Invalid url")))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlC) { (data, response, error) in
            do {
                
                if let error = error {
                    throw NetworkError.invalid(error.localizedDescription)
                }
                
                guard let data = data else {
                    throw NetworkError.invalid("No data response")
                }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw NetworkError.parsing("Error parsing json")
                }
                
                let pathComponents: [String] = path.split(separator: ".").map({String($0)})
                
                var dataDict: [String : Any] = json
                if(pathComponents.count > 0) {
                    for path in pathComponents {
                        if (dataDict["error"] != nil) {
                            throw NetworkError.parsing("dataDict: \(dataDict)")
                        }
                        
                        if let dataPath = dataDict[path] as? [String : Any] {
                            dataDict = dataPath
                        } else {
                            guard let dataPath = dataDict[path] as? [[String : Any]] else {
                                throw NetworkError.parsing("Error parsing response at \(path)")
                            }
                            dataDict = ["result" : dataPath]
                        }
                        
                    }
                }
                
                let decodeddata = try JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                let dataResponse: T = try JSONDecoder().decode(T.self, from: decodeddata)
                
                completion?(Result.success(dataResponse))
                
            } catch {
                completion?(Result.error(error))
            }
        }
        let queue = DispatchQueue.init(label: "Networking", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
        
        queue.async {
            task.resume()
        }
    }
}
