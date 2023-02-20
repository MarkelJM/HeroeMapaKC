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
                heroEntity.id = hero.id.uuidString
                heroEntity.favorite = hero.favorite
                heroEntity.descriptionCD = hero.descriptionCD
                heroEntity.latitud = hero.latitud
                heroEntity.longitud = hero.longitud
                
                do {
                    try context.save()
                } catch let error as NSError{
                    debugPrint("Error during saving context \(error)")
                }
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
    
   
}
