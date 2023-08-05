import UIKit

class HomeView: UIView {
    var cardViews: [CardPokemonView] = []

    /*private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
    }()*/
    
    /*private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()*/

    // MARK: - Init
    init() {
        super.init(frame: .zero)

//        addSubview(scrollView)
//        addSubview(contentView)

//        addMyConstraint()
        
        for pokemon in pokemonList {
            createCardView(for: pokemon)
        }
        
        if let lastCardView = cardViews.last {
            bottomAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: 16).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Constraints
    private func addMyConstraint() {

        /*NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])*/
        
/*        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])*/
    }
    
    // MARK: - CardLayout
    func createCardView(for pokemon: Pokemon) {
        let cardView = CardPokemonView() // Crie uma nova instância da CardPokemonView
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cardView)
        cardView.backgroundColor = .clear
        
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: cardViews.last?.bottomAnchor ?? topAnchor, constant: 16),
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            //                    cardView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        cardViews.append(cardView)
        cardView.pokemon = pokemon
    }

}
