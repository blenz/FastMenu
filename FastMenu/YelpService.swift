//
//  YelpService.swift
//  FastMenu
//
//  Created by Brett Lenz on 4/10/24.
//

import Foundation

class YelpService {
    private let baseURL = "https://api.yelp.com/v3/businesses"
    private let apiKey = ""
    
    func searchBusinesses(lat: Double, long: Double, completion: @escaping ([String: Any]?, Error?) -> Void) {
        var url = URL(string: "\(baseURL)/search")!
        url.append(queryItems: [
            URLQueryItem(name: "term", value: "restaurants"),
            URLQueryItem(name: "latitude", value: String(lat)),
            URLQueryItem(name: "longitude", value: String(long)),
            URLQueryItem(name: "radius", value: "10"),
        ])
        
        // Create URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")
        
        // Send the request
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            // Parse JSON response
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict = jsonResponse as? [String: Any] {
                    completion(jsonDict, nil)
                } else {
                    completion(nil, NSError(domain: "Invalid JSON response", code: 0, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func getBusiness(id: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = URL(string: "\(baseURL)/\(id)")!
        
        // Create URL request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer " + apiKey, forHTTPHeaderField: "Authorization")
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            // Parse JSON response
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict = jsonResponse as? [String: Any] {
                    completion(jsonDict, nil)
                } else {
                    completion(nil, NSError(domain: "Invalid JSON response", code: 0, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
