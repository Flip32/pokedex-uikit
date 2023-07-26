//
//  ViewController.swift
//  Pokedex
//
//  Created by Filipe Lopes on 24/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    func printPokemonDetails(_ pokemon: Pokemon) {
        print("Primeira tela")
        print("Nome do Pokémon: \(pokemon.name)")
        print("Bio do Pokémon: \(pokemon.bio)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for pokemon in pokemonList {
            printPokemonDetails(pokemon)
        }
    }
    
    @IBAction func goToPokemon(_ sender: UIButton) {
        let pokemonId = sender.tag
        print("clicou no \(pokemonId)")
        self.performSegue(withIdentifier: "goToPokemonController", sender: pokemonId)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToPokemonController" {
                if let destinationVC = segue.destination as? PokemonController,
                   let pokemonId = sender as? Int {
                    destinationVC.pokemonId = pokemonId
                }
            }
        }
    

}
