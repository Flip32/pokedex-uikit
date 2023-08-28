import Foundation

final class ListViewModel: ListViewModelProtocol {
    var listDidChange: ((ListViewModelProtocol) -> ())?

    private let service: PokemonService
    var pokemonList: [Pokemon] = [] {
        didSet {
            // Updates
            self.listDidChange?(self)
        }
    }

    var pokemonListInitial: [Pokemon] = [] {
        didSet {
            // Updates
            self.listDidChange?(self)
        }
    }

    var error: Bool = false {
        didSet {
            // Updates
            self.listDidChange?(self)
        }
    }

    func sortPokemons(sortDirection: String) {
        // comprar o sortedList, se for up, ordena do menor para o maior, se for down, ordena do maior para o menor
        if sortDirection == "up" {
            pokemonList = pokemonList.sorted(by: { $0.id > $1.id })
        } else {
            pokemonList = pokemonList.sorted(by: { $0.id < $1.id })
        }
    }

    func findPokemon(textField: String, sortDirection: String) {
        print("sortDirection => ", sortDirection)
        if let searchText = textField as? String {
            if searchText.isEmpty {
                pokemonList = pokemonListInitial.sorted(by: sortDirection == "up" ? { $0.id < $1.id } : {$0.id > $1.id})
            } else {
                pokemonList = pokemonListInitial.filter {
                    $0.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }

    init(service: PokemonService) {
        self.service = service
    }

    func requestPokemons() {
        Task { [weak self] in
            guard let self else { return}
            do {
                let pokemons = try await service.fetchPokemonCachedList(genIDs: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
                pokemonList = pokemons.sorted(by: { $0.id < $1.id })
                pokemonListInitial = pokemons.sorted(by: { $0.id < $1.id })
            } catch let error {
                if let error = error as? ServiceError {
                    print("Deu ruim no requestPokemons: \(error)")
                    self.error = true
                }
            }
        }
    }
}
