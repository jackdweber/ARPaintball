//
//  Games.swift
//  Examples
//
//  Created by Jack Weber on 7/21/18.
//  Copyright © 2018 MapBox. All rights reserved.
//

//old zoom 16
struct Games {
    let library: [[String: [String: (Double, Double, Double, Double)]]] = [["US Cities":
        ["Kansas City": (-94.5979983667, 39.092684077, -94.5678816825, 39.1112113279)
        ,"St. Louis": (-90.205954,38.616596,-90.179346,38.63403),
         "Washington, DC": (-77.05898,38.875956,-77.008624,38.901761),
         "Los Angeles": (-118.274394,34.02177,-118.203497,34.059869),
         "San Fransico": (-122.4596959,47.496118386, -122.251990473, 47.6433924527)]
        ],["National Parks":
            ["Grand Canyon": (-112.723314,36.216808,-112.661345,36.253639),
             "Yosemite": (-119.577271,37.721167,-119.547488,37.738546),
             "Great Smokey Mountains": (-83.454654,35.594896,-83.38162,35.645349),
             "Hawaii Volcanos": (-155.337018,19.376624,-155.244371,19.439965),
             "Zion": (-112.974465,37.244819,-112.944679,37.266187)]
        ]]
    
    func getAll() -> [String: (Double, Double, Double, Double)] {
        var ret = [String: (Double, Double, Double, Double)]()
        for game in library {
            for item in game.first!.value.enumerated() {
                ret.updateValue(item.element.value, forKey: item.element.key)
            }
        }
        return ret
    }
}
//[[[-122.4596959,47.496118386],[-122.251990473,47.496118386],[-122.251990473,47.6433924527],[-122.4596959,47.6433924527],[-122.4596959,47.496118386]]]
