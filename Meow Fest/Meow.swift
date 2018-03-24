//
//  Meow.swift
//  Meow Fest
//
//  Created by Nicholas Ollis on 3/24/18.
//  Copyright © 2018 Nicholas Ollis. All rights reserved.
//

import Foundation

typealias Meows = [Meow]

struct Meow: Decodable {
    let title: String
    let timestamp: Date
    let image_url: URL
    let description: String
}
