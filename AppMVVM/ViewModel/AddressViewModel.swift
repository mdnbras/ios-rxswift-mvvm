import RxSwift

final class AddressViewModel {
    
    private let cepRepository: CepRepositoryProtocol
    
    private let addressSubject = PublishSubject<Address>()
    var address: Observable<Address> {
        return addressSubject.asObservable()
    }
    
    let loadingSubject: PublishSubject<Bool> = PublishSubject()
    var loading: Observable<Bool> {
        return loadingSubject.asObservable()
    }
    
    init(cepRepository: CepRepositoryProtocol = DIContainerFactory.ci.resolve(type: CepRepositoryProtocol.self)!) {
        self.cepRepository = cepRepository
    }
    
    func fetchAddress(for cep: String) {
        self.loadingSubject.onNext(true)
        
        cepRepository.getAddress(for: cep)
            .subscribe(onNext: {[weak self] address in
                self?.addressSubject.onNext(address)
            }, onError: { error in
                print("Ocorreu um erro \(error.localizedDescription)")
            }, onCompleted: {
                self.loadingSubject.onNext(false)
            })
            .disposed(by: disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}
