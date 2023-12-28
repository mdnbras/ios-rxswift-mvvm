//
//  DIContainer.swift
//  AppMVVM
//
//  Created by Marcelo Daniel on 28/12/23.
//

import Foundation

class DIContainerFactory {

    static let ci: DICProtocol = DIContainer.instance
    
    static func create() -> Void {
        ci.register(type: ApiServiceProtocol.self, component: ApiService())
        ci.register(type: CepRepositoryProtocol.self, component: CepRepository())
    }
}


fileprivate class DIContainer: DICProtocol {
    
    static let instance = DIContainer()
    
    private init() {}
    
    var services: [String: Any] = [:]
    
    func register<Service>(type: Service.Type, component: Any) {
        services["\(type)"] = component
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"] as? Service
    }
}
