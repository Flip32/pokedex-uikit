import UIKit

class HomeView: UIView {
    var cardViews: [CardPokemonView] = []
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        return image
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        addSubview(logo)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addMyConstraint()
        
        for pokemon in pokemonList {
            createCardView(for: pokemon)
        }
        
        if let lastCardView = cardViews.last {
            contentView.bottomAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: 16).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Constraints
    private func addMyConstraint() {
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.topAnchor.constraint(equalTo: topAnchor, constant: 40)
            
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    // MARK: - CardLayout
    func createCardView(for pokemon: Pokemon) {
        let cardView = CardPokemonView() // Crie uma nova instância da CardPokemonView
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cardView)
        cardView.backgroundColor = .clear
        
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: cardViews.last?.bottomAnchor ?? contentView.topAnchor, constant: 16),
            cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //                    cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 250), // Altura fixa para a cardView (ajuste conforme necessário)
        ])
        
        cardViews.append(cardView)
        cardView.pokemon = pokemon
    }
}
