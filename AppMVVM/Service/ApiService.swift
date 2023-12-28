
import RxSwift

class ApiService {
    
    func fetchCep(for cep: String) -> Observable<Address> {
        let apiURL = "https://viacep.com.br/ws/\(cep)/json"
        guard let url = URL(string: apiURL) else {
            return Observable.error(NSError(domain: "URL invalida", code: 0, userInfo: nil))
        }
        
        return Observable.create { observer in
            Task.init {
                   do {
                       let (data, _) = try await URLSession.shared.data(from: url)
                       let address = try JSONDecoder().decode(Address.self, from: data)
                       observer.onNext(address)
                       observer.onCompleted()
                   } catch {
                       observer.onError(error)
                   }
               }

               return Disposables.create()
           }
    }
}
