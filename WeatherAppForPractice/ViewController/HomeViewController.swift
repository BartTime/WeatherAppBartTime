//
//  HomeViewController.swift
//  WeatherAppForPractice
//
//  Created by Alex on 22.06.2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items: [Cities]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBackground()
        title = "Города"
        fetchCities()
    }
    
    func fetchCities() {
        do{
            self.items = try context.fetch(Cities.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }catch{
            
        }
        
    }
    
    func createBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, at: 0)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("HomeTableViewCell", owner: self, options: nil)?.first
                as? HomeTableViewCell else { return UITableViewCell() }
        
        let someCity            = self.items![indexPath.section]
        cell.cityLabel.text     = someCity.city
        cell.backgroundColor    = UIColor(cgColor: CGColor(red:  240/255, green: 176/255, blue: 183/255, alpha: 0.6))
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.city = items![indexPath.section].city!
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let allertController = UIAlertController(title: "Добавить город", message: "Введите город который хотите добавить", preferredStyle: .alert)

        let buttonCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        allertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Введите город"
        })

        let buttonOk = UIAlertAction(title: "Добавить", style: .default) { action in
            let textField = allertController.textFields![0] as UITextField
            let newCity = Cities(context: self.context)
            newCity.id = Int16(self.items?.count ?? 0 + 1)
            newCity.city = textField.text ?? "Moscow"
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            self.fetchCities()
        }

        allertController.addAction(buttonOk)
        allertController.addAction(buttonCancel)

        present(allertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cityToRemove = self.items![indexPath.section]
            self.context.delete(cityToRemove)
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            self.fetchCities()
            
        }
    }
    
    
}
