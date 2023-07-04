//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Beste Kocaoglu on 3.07.2023.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.colorArray = [
        
            UIColor(red: 170/255, green: 100/255, blue: 150/255, alpha: 1.0),
            UIColor(red: 115/255, green: 90/255, blue: 60/255, alpha: 1.0),
            UIColor(red: 134/255, green: 100/255, blue: 150/255, alpha: 1.0),
            UIColor(red: 100/255, green: 170/255, blue: 100/255, alpha: 1.0),
            UIColor(red: 45/255, green: 70/255, blue: 100/255, alpha: 1.0),
            UIColor(red: 200/255, green: 167/255, blue: 180/255, alpha: 1.0)
        ]
        
        
        
        getData()
        
    }
    
    func getData() {
        
        let url = URL( string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        Webservice().downloadCurrencies(url: url) { (crytops) in
            if let crytops = crytops {
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: crytops)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as!
        CryptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(index: indexPath.row)
        
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        
        return cell
    }
    


}

