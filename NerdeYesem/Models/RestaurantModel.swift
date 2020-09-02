//
//  RestaurantModel.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 30.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import Foundation

//Resaurant Response Model structs for ZOMATO API...
struct GetRestaurantResponseModel: Codable {
    var R: RestaurantHeaderModel
    var id: String
    var name: String
    var url: String
    var location: LocationModel
    var switch_to_order_menu: Int
    var cuisines: String
    var timings: String
    var highlights: [String]
    var user_rating: UserRatingModel
    var photos_url: String
    var featured_image: String
    var has_online_delivery: Int
    var establishment: [String]
}

struct SearchRestaurantsResponseModel: Codable {
    var restaurants: [RestaurantArrayModel]
}

struct RestaurantModel: Codable {
    var id: String
    var name: String
    var url: String
    var location: LocationModel
    var user_rating: UserRatingModel
    var cuisines: String
    var has_online_delivery: Int
    var featured_image: String
    var timings: String
}

struct RestaurantArrayModel: Codable {
    var restaurant: RestaurantModel
}

struct LocationModel: Codable {
    var address: String
    var locality: String
    var city: String
    var city_id: Int
    var latitude: String
    var longitude: String
    var locality_verbose: String
    var country_id: Int
}

struct UserRatingModel: Codable {
    //var aggregate_rating: String // inconsistent rating
    var rating_text: String
    var votes: Int
}

struct RestaurantHeaderModel: Codable {
    var res_id: Int
}


