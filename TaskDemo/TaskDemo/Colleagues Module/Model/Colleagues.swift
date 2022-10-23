//
//  Colleagues.swift
//  TaskDemo
//
//  Created by raghavareddy.m on 22/10/22.
//


import Foundation

struct Person: Codable {
    var createdAt       : String?
    var firstName       : String?
    var avatar          : String?
    var lastName        : String?
    var email           : String?
    var jobtitle        : String?
    var favouriteColor  : String?
    var id              : String?
    var PersonOccupancy : PersonOccupancy?
}
struct PersonOccupancy : Codable {
    var createdAt     : String?
    var isOccupied    : Bool?
    var maxOccupancy  : Int?
    var id            : String?
}

