import UIKit


class PokemonView: UIView {
    var pokemonId: Int?
    var pokemon: Pokemon?
    
    private var img: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    
    private var bioDescription: UILabel = {
        let bio = UILabel()
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.textColor = .darkGray
        bio.numberOfLines = 0
        return bio
    } ()
    
    private var name: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.textColor = .darkGray
        n.numberOfLines = 1
        n.font = UIFont.systemFont(ofSize: 20)
        n.font = UIFont.boldSystemFont(ofSize: 18)
        n.textAlignment = .center
        return n
    } ()
    
    init(pokemonId: Int?) {
        super.init(frame: .zero)
        self.pokemonId = pokemonId
        backgroundColor = .black
        
        if let id = pokemonId {
            pokemon = pokemonList.first { $0.id == id }
            
            if let pokemon = pokemon {
                print(pokemon.name)
                name.text = pokemon.name
//                img.image = pokemon.image
                bioDescription.text = pokemon.bioDescription
                
                addSubview(name)
//                addSubview(img)
                addSubview(bioDescription)
                addMyConstraints()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addMyConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.widthAnchor.constraint(equalToConstant: 250),

        ])
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: centerXAnchor),
            img.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            img.widthAnchor.constraint(equalToConstant: 250),
            img.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            bioDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            bioDescription.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10),
            bioDescription.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
}
