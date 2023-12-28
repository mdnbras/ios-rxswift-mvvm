//
//  CepRepository.swift
//  AppMVVM
//
//  Created by Marcelo Daniel on 27/12/23.
//

import RxSwift

class CepRepository {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getAddress(for cep: String) -> Observable<Address> {
        return apiService.fetchCep(for: cep)
    }
}
