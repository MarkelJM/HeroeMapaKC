//
//  HeroesListTableViewDataSource.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation
import UIKit

class HeroesListTableViewDataSource: NSObject, UITableViewDataSource{
    
    let tableView: UITableView
    //var heroes:  [HeroModel] = []
    
    var heroes: [HeroModel] = [] {
        
        didSet{
            /* explicacion 22:10 dia 1*/
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
            
        
    }
    
    init(tableView: UITableView,  heroes: [HeroModel] = []) {
        self.heroes = heroes
        self.tableView = tableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*cuantos datos va a tener la fuente de datos*/
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroesListViewCell", for: indexPath) as! HeroListViewCell
        
        let hero = heroes[indexPath.row]
        
        cell.configure(hero)
        
        return cell
    }
    
    
}
