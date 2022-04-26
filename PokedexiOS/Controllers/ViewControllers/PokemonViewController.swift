//
//  ViewController.swift
//  PokedexiOS
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import UIKit

class PokemonViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }

    
    //MARK: - Helper Methods

    func fetchSpriteAndUpdateViews(pokemon: Pokemon){
        PokemonController.fetchSprite(for: pokemon) { result in
            
            DispatchQueue.main.async {
                switch result{
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name
                    self.pokeIDLabel.text = String(pokemon.id)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }//End of function
    
}//End of class

extension PokemonViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchterm = searchBar.text,
              !searchterm.isEmpty
        else { return }
        
        PokemonController.fetchPokemon(searchterm: searchterm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
    }//End of function
    
}//End of extension
