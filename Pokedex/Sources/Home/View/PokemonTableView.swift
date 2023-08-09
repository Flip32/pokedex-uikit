import UIKit
import SDWebImage

class PokemonTableView: UITableView {

    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        backgroundColor = .black
        separatorStyle = .none


        delegate = self
        dataSource = self
        register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
    }
}


extension PokemonTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PokemonTableViewCell.reuseIdentifier,
                for: indexPath) as? PokemonTableViewCell
        else {
            return UITableViewCell()
        }

        let pokemon = pokemonList[indexPath.row]
        cell.configure(with: pokemon)
        return cell
    }
}

extension PokemonTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Chegou no delegate", pokemonList.count)
        return pokemonList.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = pokemonList[indexPath.row]
        print("Pokémon selecionado:", selectedPokemon.name)

        // TODO - Melhorar essa forma de navegar
        func findParentViewController() -> UIViewController? {
            var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder?.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
        let pokemonController = PokemonController()
        pokemonController.pokemonId = selectedPokemon.id
        if let homeViewController = findParentViewController() as? HomeViewController {
            homeViewController.navigationController?.pushViewController(pokemonController, animated: true)
        }
    }
}
