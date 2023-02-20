//
//  HeroModel.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation

struct HeroModel: Decodable {
    let photo: String
    let id: String
    let favorite: Bool
    let name: String
    let description: String
    let latitud: String?
    let longitud: String?
}
