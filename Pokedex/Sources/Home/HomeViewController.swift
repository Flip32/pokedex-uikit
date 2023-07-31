import UIKit

class HomeViewController: UIViewController {
    private var customView: HomeView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    private func buildView(){
        view = HomeView()
        customView = view as? HomeView
    }
    

    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "goToPokemonController" {
             if let destinationVC = segue.destination as? PokemonController,
                let pokemonId = sender as? Int {
                 destinationVC.pokemonId = pokemonId
             }
         }
     }

}
