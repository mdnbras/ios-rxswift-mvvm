import UIKit
import RxSwift
import FirebaseFirestore

class CepViewController: UIViewController {
    
    @IBOutlet weak var logradouro: UILabel!
    @IBOutlet weak var bairro: UILabel!
    @IBOutlet weak var complemento: UILabel!
    @IBOutlet weak var uf: UILabel!
    @IBOutlet weak var localidade: UILabel!
    @IBOutlet weak var cepTextField: UITextField!
    @IBOutlet weak var buttonPesquisar: UIButton!
    
    private let viewModel = AddressViewModel()
    private let disposeBag = DisposeBag()
    
    @IBAction func searchButton(_ sender: UIButton) {
        guard let cep = cepTextField.text else { return }
        
        DispatchQueue.main.async {
            self.viewModel.fetchAddress(for: cep)
        }
    }
    
    func carregarDadosNaUI() {
        let observableAddress = viewModel.address
        
        _ = observableAddress
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { address in
                    self.updateUI(with: address)
                },
                onError: { error in
                    print("Erro: \(error)")
                },
                onCompleted: {
                    print("Observação concluída.")
                }
            ).disposed(by: disposeBag)
        
        viewModel.loading
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { loading in
                    self.buttonPesquisar.configuration?.showsActivityIndicator = loading
                },
                onError: { error in
                    print("Erro: \(error)")
                },
                onCompleted: {
                    print("Observação concluída.")
                },
                onDisposed: {}
            ).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        carregarDadosNaUI()
        setupFirestore()
    
    }
    
    func exibirAlerta() {
        let alertController = UIAlertController(title: "Busca concluída", message: "Pesquisa realizada", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateUI(with address: Address) {
        logradouro.text = address.logradouro
        complemento.text = address.complemento
        bairro.text = address.bairro
        uf.text = address.uf
        localidade.text = address.localidade
    }
    
    private func setupFirestore() {
        let db = Firestore.firestore()
        
        db.collection("configuracoes").document("JOKx6aj3zqCpnOXZJ1GY")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                print("Current data: \(data)")
            }
        
    }
    
    func setupConfiguration() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Api Via CEP"
        
        buttonPesquisar.setTitle("Pesquisar", for: .normal)
        buttonPesquisar.tintColor = .blue
    }
    
}
