//
//  Address.swift
//  AppMVVM
//
//  Created by Marcelo Daniel on 27/12/23.
//

import Foundation

struct Address: Codable {
    let cep: String
    let logradouro: String
    let complemento: String
    let bairro: String
    let localidade: String
    let uf: String
}
