//
//  CitiesViewModel.swift
//  Weather
//
//  Created by wiley on 2020/1/3.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

class CitiesViewModel {
    
    let bag = DisposeBag()
    let cities: BehaviorRelay<[City]>
    private let storeCities: Observable<[City]>
    
    init(initialCities: [City] = Store.shared.storeCities) {
//        cities = BehaviorRelay(value: initialCities)
        cities = BehaviorRelay(value: [City.test, City.test])
        storeCities = cities.asObservable()
        
        obserNotification()
    }
    
    func obserNotification() {
        NotificationCenter.default
            .rx
            .notification(Store.storeChanged)
            .subscribe(onNext: { _ in
                self.cities.accept(Store.shared.storeCities)
            })
            .disposed(by: bag)
    }
    
    func addCity(_ city: City) {
        Store.shared.addCity(city: city)
    }
    
    func deleteCity(_ city: City) {
        Store.shared.deleteCity(city: city)
    }
    
    var titles: Observable<[String]> {
        return Observable.from(optional: cities.value.map { $0.name })
    }
    
    var searchText: ControlProperty<String?>?
}
