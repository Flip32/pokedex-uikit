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
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStackView: UIStackView = {
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
        addSubview(imageView)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(idLabel)
        addSubview(infoStackView)
        addSubview(buttonView)
        
        // Adicionar as constraints para posicionar os elementos dentro da cardView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            //            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            //            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            //            idLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            //            idLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            
            buttonView.topAnchor.constraint(equalTo: topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            infoStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ])
        
        // Adicionar outras constraints conforme necessário para posicionar os elementos corretamente
        
        // Exemplo: Constraints para ajustar o conteúdo à direita da cardView
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 16)
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
