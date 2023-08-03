import UIKit
import SDWebImage


class CardPokemonView: UIView {
    
    var pokemon: Pokemon? {
        didSet {
            if let pokemon = pokemon {
//                imageView.image = pokemon.image
//                nameLabel.text = pokemon.name
//                idLabel.text = "00\(pokemon.id)"

                configure(with: pokemon)
            }
        }
    }
    
    private let buttonView: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear // Defina a cor de fundo como transparente
        button.isEnabled = true // Tornar o botão clicável
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initIU()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initIU()
    }
    
    private func initIU() {
        // Adicionar as subviews à cardView
        //        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])

        contentStackView.addArrangedSubview(imageView)
        infoStackView.addArrangedSubview(idLabel)
        infoStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(infoStackView)
        //        addSubview(infoStackView)
        addSubview(contentStackView)
        addSubview(buttonView)
        
        // Adicionar as constraints para posicionar os elementos dentro da cardView
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 200),
            heightAnchor.constraint(equalToConstant: 250),

            imageView.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
            
            buttonView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    // Configurar os dados do Pokémon na cardView
    func configure(with pokemon: Pokemon) {
//        backgroundColor = .darkGray

        if let imageUrl = URL(string: pokemon.image) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
        }
        nameLabel.text = pokemon.name
        idLabel.text = String(format: "%03d", pokemon.id)

    }
    
    @objc private func buttonTapped() {
        return // TODO - retirar assim q ajustar a navegação
        print("CardPokemonView foi clicado!")
        let pokemonController = PokemonController()
        pokemonController.pokemonId = pokemon?.id
        
        if let homeViewController = findParentViewController() as? HomeViewController {
                homeViewController.navigationController?.pushViewController(pokemonController, animated: true)
            }
    }
    
    private func findParentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
