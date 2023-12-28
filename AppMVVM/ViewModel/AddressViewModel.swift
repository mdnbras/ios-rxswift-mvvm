import RxSwift

class AddressViewModel {
    
    private let cepRepository: CepRepository
    
    var address: Observable<Address> {
        return addressSubject.asObservable()
    }
    
    private let addressSubject = PublishSubject<Address>()
    
    init(cepRepository: CepRepository) {
        self.cepRepository = cepRepository
    }
    
    func fetchAddress(for cep: String) {
        cepRepository.getAddress(for: cep)
            .subscribe(onNext: {[weak self] address in
                self?.addressSubject.onNext(address)
            }, onError: { error in
                print("Ocorreu um erro \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}
