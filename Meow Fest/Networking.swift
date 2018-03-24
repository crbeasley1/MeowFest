//
//  Networking.swift
//  Meow Fest
//
//  Created by Nicholas Ollis on 3/24/18.
//  Copyright © 2018 Nicholas Ollis. All rights reserved.
//

import Foundation

protocol Networkable {
    var testing: Bool { get }
    var currentPage: Int { get }
    func newCats(_ meows: Meows) -> Void
}

extension Networkable {
    
    func getData() -> Meows? {
        guard !testing, let url = URL.init(string: "https://chex-triplebyte.herokuapp.com/api/cats?page=\(self.currentPage)") else { return getWithTestData() }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let meows = try? self.decoder.decode(Meows.self, from: data)
                else { return }
            DispatchQueue.main.async() {
                self.newCats(meows)
            }
            }.resume()
        return nil
    }
    
    func getWithTestData() -> Meows? {
        guard  let jsonData = testData.data(using: .utf8) else { return nil; }
        return try? decoder.decode(Meows.self, from: jsonData)
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
    
    private var testData: String { return """
[{"title":"Space Keybaord Cat","timestamp":"2018-03-24T17:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/space.jpg","description":"In space, no one can hear you purr."},{"title":"Jiji","timestamp":"2018-03-24T16:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/jiji.png","description":"You'd think they'd never seen a girl and a cat on a broom before"},{"title":"Limecat","timestamp":"2018-03-24T15:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/lime.jpg","description":"Destroyer of Clockspider and his evil followers, Limecat is the one true god."},{"title":"Astronaut Cat","timestamp":"2018-03-24T14:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/astronaut.jpg","description":"Houston, we have a purroblem"},{"title":"Grumpy Cat","timestamp":"2018-03-24T13:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/grumpy.jpg","description":"Queen of the RBF"},{"title":"Soviet cat","timestamp":"2018-03-24T12:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/soviet.jpg","description":"In soviet Russia cat pets you!"},{"title":"Serious Business Cat","timestamp":"2018-03-24T11:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/serious.jpg","description":"SRSLY GUISE"},{"title":"Sophisticated Cat","timestamp":"2018-03-24T10:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/sophisticated.PNG","description":"I should buy a boat"},{"title":"Shironeko","timestamp":"2018-03-24T09:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/shironeko.png","description":"The zen master kitty"},{"title":"Puss in Boots","timestamp":"2018-03-24T08:36:34Z","image_url":"https://triplebyte-cats.s3.amazonaws.com/puss.jpg","description":"Don't you dare do the litter box on me!"}]
""" }
}
