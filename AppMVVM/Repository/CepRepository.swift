//
//  CepRepository.swift
//  AppMVVM
//
//  Created by Marcelo Daniel on 27/12/23.
//

import RxSwift

protocol CepRepositoryProtocol  {
    func getAddress(for cep: String) -> Observable<Address>
}

final class CepRepository : CepRepositoryProtocol {
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = DIContainerFactory.ci.resolve(type: ApiServiceProtocol.self)!) {
        self.apiService = apiService
    }
    
    func getAddress(for cep: String) -> Observable<Address> {
        return apiService.fetchCep(for: cep)
    }
}
