//
//  DICProtocol.swift
//  AppMVVM
//
//  Created by Marcelo Daniel on 28/12/23.
//

import Foundation

protocol DICProtocol {
    func register<Service>(type: Service.Type, component: Any)
    func resolve<Service>(type: Service.Type) -> Service?
}
