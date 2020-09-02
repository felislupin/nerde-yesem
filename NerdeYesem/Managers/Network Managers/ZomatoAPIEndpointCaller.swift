//
//  ZomatoAPIEndpointCaller.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 30.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import Foundation

class ZomatoAPIEndpointCaller  {
    
    public static let shared = ZomatoAPIEndpointCaller()
    private let baseURL: String = "https://developers.zomato.com/api/v2.1/"
    private let apiKey: String = "e4ed256669c2149e08f764e373b550c8"
    
    func fetchNeariestRestaurants(lat: Double, long: Double, onSuccess: @escaping (SearchRestaurantsResponseModel) -> Void, onError: @escaping (String) -> Void) {
        APIManager.shared.setBaseURL(baseURL)
        let headers = [["user-key": apiKey]]
        APIManager.shared.get(path: "search?entity_type=group&count=5&lat=\(lat)&lon=\(long)&radius=1000&sort=real_distance&order=desc", headers: headers, params: nil, success: { (data) in
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SearchRestaurantsResponseModel.self, from: data)
                onSuccess(response)

            } catch {
                onError(error.localizedDescription)
                print("> \(String(describing: type(of: self))): \(#function): Error: \(error.localizedDescription)")
            }
        }) { (code, message) in
            onError(message)
        }
    }
    
    
}

