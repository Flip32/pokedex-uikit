import UIKit

class PokemonController: UIViewController {
    
    var pokemonId: Int?
    var pokemon: Pokemon?
    
    private var img: UIImageView
    private var bioDescription: UILabel
    
    init() {
        img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        
        bioDescription = UILabel()
        bioDescription.translatesAutoresizingMaskIntoConstraints = false
        bioDescription.textColor = .white
        bioDescription.numberOfLines = 0
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addMyConstraints() {
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            img.widthAnchor.constraint(equalToConstant: 250),
            img.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            bioDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bioDescription.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10),
            bioDescription.widthAnchor.constraint(equalToConstant: 250),
            bioDescription.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("Chegou na Pokemon controller \(pokemonId!)")
        
        if let id = pokemonId {
            pokemon = pokemonList.first { $0.id == id }
            
            if let pokemon = pokemon {
                print("Nome do Pokémon: \(pokemon.name)")
                print("Bio do Pokémon: \(pokemon.bioDescription)")
                img.image = pokemon.image
                bioDescription.text = pokemon.bioDescription
                
                view.addSubview(img)
                view.addSubview(bioDescription)
                addMyConstraints()
            }
        }
    }
    
}
