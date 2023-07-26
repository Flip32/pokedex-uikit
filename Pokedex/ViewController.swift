import UIKit

class ViewController: UIViewController {
    
    var previousCardView: CardPokemonView?
    
    @IBOutlet weak var logo: UIImageView!
    
    
    func printPokemonDetails(_ pokemon: Pokemon) {
        print("Primeira tela")
        print("Nome do Pokémon: \(pokemon.name)")
        print("Bio do Pokémon: \(pokemon.bio)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for pokemon in pokemonList {
            printPokemonDetails(pokemon)
            createCardView(for: pokemon)
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
        cardView.translatesAutoresizingMaskIntoConstraints = false // Desative a criação automática de constraints
        
        // Adicione a nova cardView à ViewController
        view.addSubview(cardView)
        cardView.backgroundColor = .blue
        
        // Constraints
        NSLayoutConstraint.activate([
            //                cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            //                cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            //            cardView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 24)
            
        ])
        
        if let previousCardView = previousCardView {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView.bottomAnchor, constant: 16)
            ])
        } else {
            // Primeiro Card
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 24)
            ])
        }
        
        previousCardView = cardView
        cardView.pokemon = pokemon
    }
    
    
}
