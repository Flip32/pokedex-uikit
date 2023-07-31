import UIKit

class ViewController: UIViewController {
    
    //    var scrollView: UIScrollView!
    //    var previousCardView: CardPokemonView?
    var cardViews: [CardPokemonView] = []
    
    private let logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logo)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        for pokemon in pokemonList {
            createCardView(for: pokemon)
        }
        
        if let lastCardView = cardViews.last {
            contentView.bottomAnchor.constraint(equalTo: lastCardView.bottomAnchor, constant: 16).isActive = true
        }
    }
    
    //    @IBAction func goToPokemon(_ sender: UIButton) {
    //        let pokemonId = sender.tag
    //        print("clicou no \(pokemonId)")
    //        self.performSegue(withIdentifier: "goToPokemonController", sender: pokemonId)
    //
    //    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemonController" {
            if let destinationVC = segue.destination as? PokemonController,
               let pokemonId = sender as? Int {
                destinationVC.pokemonId = pokemonId
            }
        }
    }
    
    
    func createCardView(for pokemon: Pokemon) {
        let cardView = CardPokemonView() // Crie uma nova instância da CardPokemonView
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cardView)
        cardView.backgroundColor = .clear
        
        // Constraints
        //        NSLayoutConstraint.activate([
        //            cardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        //
        //        ])
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
