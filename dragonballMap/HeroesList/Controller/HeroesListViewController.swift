//
//  HeroesListViewController.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation
import UIKit
import CoreData

class HeroesListViewController : UIViewController {
    var mainView: HeroesListView { self.view as! HeroesListView}
    var heroes:  [HeroModel] = []
    
    var viewModel : HeroListViewModel?
    
    var tableViewDataSource: HeroesListTableViewDataSource?
    var tableViewDelegate : HeroesListTableViewDelegate?
    
    override func loadView(){
        
        view = HeroesListView()
        
        tableViewDataSource = HeroesListTableViewDataSource(tableView: mainView.heroesTableView)
        mainView.heroesTableView.dataSource = tableViewDataSource
        
        
        tableViewDelegate = HeroesListTableViewDelegate()
        mainView.heroesTableView.delegate = tableViewDelegate
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HeroListViewModel()
        //PREPARANDOME PARA RECIBIR LOS DATOS QUE VIENE DEL VIEWMODEL
        
        viewModel?.updateUI = { [weak self] heroes in
            self?.heroes = heroes
            self?.tableViewDataSource?.heroes = heroes
            
        // Access the managed object context from the CoreDataManager shared instance
            let context = AppDelegate.sharedAppDelegate.CoreDataManager.manageContext
            
            for hero in heroes {
                let heroEntity = NSEntityDescription.insertNewObject(forEntityName: "Heroe", into: context) as! Heroe
                heroEntity.name = hero.name
                heroEntity.photo = hero.photo
                heroEntity.id = UUID(uuidString: hero.id)
                heroEntity.favorite = hero.favorite
                heroEntity.descriptionCD = hero.description
                heroEntity.latitud = hero.latitud
                heroEntity.longitud = hero.longitud
                
                do {
                    try context.save()
                } catch let error as NSError{
                    debugPrint("Error during saving context \(error)")
                }
            }
            // Fetch the heroes from Core Data
            let request = NSFetchRequest<Heroe>(entityName: "Heroe")
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sortDescriptor]

            do {
                let heroesCD = try context.fetch(request)
                
                //regalo del chat:
                guard let heroes = self?.mapToHeroModel(heroesCD: heroesCD) else {
                    return
                }
                self?.tableViewDataSource?.heroes = heroes
                self?.mainView.heroesTableView.reloadData()

            } catch let error as NSError {
                debugPrint("Error during fetching from context \(error)")
            }

        }
        
        getData()
        setUpTableDelegate()
        
       
            
        }
        
        
        
        func getData(){
            /* traer los datos: CALL API TO GET HERO LIST*/
            viewModel?.fetchData()
        }
    
        func setUpTableDelegate(){
            tableViewDelegate?.didTapOnCell = { [weak self] index in
                guard let datasource = self?.tableViewDataSource else {
                    return
                }
                //Get the hero in the hero list according to thew position index
                let hero =  datasource.heroes[index]
                
                // prepare the viewcontroller that I want to present
                let heroDetailViewController = HeroDetailViewController(heroDetailModel: hero)
                
                //present the controller to show the details
                
                self?.present(heroDetailViewController,animated: true)
                
            }
    }
    
    private func mapToHeroModel(heroesCD: [Heroe]) -> [HeroModel] {
        var heroes = [HeroModel]()
        for heroCD in heroesCD {
            let hero = HeroModel(photo: heroCD.photo ?? "",
                                 id: heroCD.id?.uuidString ?? "",
                                 favorite: heroCD.favorite,
                                 name: heroCD.name ?? "",
                                 description: heroCD.descriptionCD ?? "",
                                 latitud: heroCD.latitud,
                                 longitud: heroCD.longitud)
            heroes.append(hero)
        }
        return heroes
    }



    
   
}
