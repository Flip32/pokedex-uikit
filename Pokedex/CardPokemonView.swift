import UIKit


class CardPokemonView: UIView {
    
    var pokemon: Pokemon? {
        didSet {
            if let pokemon = pokemon {
                imageView.image = pokemon.image
                nameLabel.text = pokemon.name
                idLabel.text = "00\(pokemon.id)"
                // Adicionar o resto das subViews
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
            
            buttonView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
        
        buttonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    // Configurar os dados do Pokémon na cardView
    func configure(with pokemon: Pokemon) {
        imageView.image = pokemon.image
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        
        // Configure outras subviews conforme necessário com os dados do Pokémon
    }
    
    @objc private func buttonTapped() {
        print("CardPokemonView foi clicado!")
        let parentViewController = findParentViewController()
        parentViewController?.performSegue(withIdentifier: "goToPokemonController", sender: pokemon?.id)
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
