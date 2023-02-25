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
            /*
             por error en construccion de coredata se me multiplacaron los datos. Este codigo se encarga de poner el coredata a 0
            let coreDataManager = CoredataManager(modelName: "HeroesCD")
            coreDataManager.deleteAllHeroes()
             */
            

            // Check if heroes are already in Core Data, add new heroes to Core Data if necessary
            self?.saveToCoreDataIfNeeded(heroes)

            // Use heroes from Core Data
            let heroesCD = self?.fetchHeroesFromCoreData()

            // Map heroesCD to HeroModel
            let heroesModel = heroesCD?.map { hero in
                return HeroModel(photo: hero.photo ?? "",
                                 id: hero.id?.uuidString ?? "",
                                 favorite: hero.favorite,
                                 name: hero.name ?? "",
                                 description: hero.descriptionCD ?? "",
                                 latitud: hero.latitud,
                                 longitud: hero.longitud)
            } ?? []

            // Update table view data source with heroesModel
            self?.tableViewDataSource?.heroes = heroesModel
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
    
    func saveToCoreDataIfNeeded(_ heroes: [HeroModel]) {
        let context = AppDelegate.sharedAppDelegate.CoreDataManager.manageContext

        // Filter the list of heroes to only include new ones
        let newHeroes = heroes.filter { hero in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Heroe")
            request.predicate = NSPredicate(format: "id = %@", hero.id)
            let count = try? context.count(for: request)
            return count == 0
        }

        // Add new heroes to Core Data
        for hero in newHeroes {
            let heroEntity = NSEntityDescription.insertNewObject(forEntityName: "Heroe", into: context) as! Heroe
            heroEntity.name = hero.name
            heroEntity.photo = hero.photo
            heroEntity.id = UUID(uuidString: hero.id)
            heroEntity.favorite = hero.favorite
            heroEntity.descriptionCD = hero.description
            heroEntity.latitud = hero.latitud
            heroEntity.longitud = hero.longitud
        }
        
        // Save the context
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Error during saving context \(error)")
        }
    }
    
    func fetchHeroesFromCoreData() -> [Heroe] {
        let context = AppDelegate.sharedAppDelegate.CoreDataManager.manageContext
        let request = NSFetchRequest<Heroe>(entityName: "Heroe")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]

        do {
            let heroesCD = try context.fetch(request)
            return heroesCD
        } catch let error as NSError {
            debugPrint("Error during fetching from context \(error)")
            return []
        }
    }
}


