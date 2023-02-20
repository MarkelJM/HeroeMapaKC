//
//  HeroListViewModel.swift
//  dragonballMap
//
//  Created by Markel Juaristi on 11/2/23.
//

import Foundation

class HeroListViewModel: NSObject{
    override init() {
        
    }
    
    var updateUI: ((_ heroes: [HeroModel]) -> Void)?
    
    func fetchData(){
        
        let myToken = "eyJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUiLCJ0eXAiOiJKV1QifQ.eyJpZGVudGlmeSI6IkUzNkM5REU4LUIxQ0QtNDM5NS04MkJGLTVFNTU3RThDQTRENyIsImVtYWlsIjoibWFya2p1YXJpc3RpQGdtYWlsLmNvbSIsImV4cGlyYXRpb24iOjY0MDkyMjExMjAwfQ.5-qOCbTIIllJry65kp0PKpI9CNDaAhUApD6xo7QyBOc"
        
        let apiClient = ApiClient(token: myToken)
        apiClient.getHeroes{[weak self] heroes, error in
            self?.updateUI?(heroes)
            
        }
        
    }
    
    func login(){
        
    }
    
}
