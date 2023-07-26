//
//  ViewController.swift
//  Pokedex
//
//  Created by Filipe Lopes on 24/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
