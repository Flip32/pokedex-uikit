//
// Created by Filipe Lopes on 28/08/23.
//

import Foundation
protocol ListViewModelProtocol {
    // Observer
    var listDidChange: ((ListViewModelProtocol) -> ())? { get set }

    var pokemonList: [Pokemon] { get }
    var pokemonListInitial: [Pokemon] { get }

    // Sort is a function that receives a string and returns nothing
    func sortPokemons(sortDirection: String)

    func findPokemon(textField: String, sortDirection: String)

    func requestPokemons()

}