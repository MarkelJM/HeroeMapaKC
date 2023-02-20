//
//  HeroesListTableViewDelegate.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation
import UIKit

class HeroesListTableViewDelegate: NSObject  , UITableViewDelegate{
    var didTapOnCell: ((Int) -> Void)?
    
    /* altura de la celda*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    /* para cuando tocamos una celda haga algo*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when tapping on a specific cell
        //open another view controller to show the hero details
        
        didTapOnCell?(indexPath.row)
    }
}
