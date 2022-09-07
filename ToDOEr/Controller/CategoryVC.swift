//
//  CategoryVC.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 04.09.2022.
//

import UIKit
import CoreData
import RealmSwift

class CategoryVC: UITableViewController {

    
    // Realm
    let realm = try! Realm()
    var categoriesRealm: Results<CategoryRealm>?
    
    
    // CoreData
    //var categories = [Category]()
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
    }


//MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //CoreData
        //return categories.count
        
        //Realm
        return categoriesRealm?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        //CoreData
//        if let name = categories[indexPath.row].name {
//            cell.updateView(string: name)
//        }
        
        //Realm
         let name = categoriesRealm?[indexPath.row].name ?? "Add your category"
         cell.updateView(string: name)
        
        
        
        //cell.textLabel?.text = name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
//MARK: - Prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todoVC = segue.destination as? TodoVC {
            // set index path of selected row
            if let indexPath = tableView.indexPathForSelectedRow {
                // set the value for selectedCategories in TodoVC
                
                //CoreData
                //todoVC.selectedCategory = categories[indexPath.row]
                
                //Realm
                todoVC.selectedCategory = categoriesRealm?[indexPath.row]
            }
            
            let backBtn = UIBarButtonItem()
            backBtn.title = ""
            backBtn.tintColor = #colorLiteral(red: 0.1225796863, green: 0.7601103187, blue: 0.06077206135, alpha: 1)
            
            navigationItem.backBarButtonItem = backBtn
        }
    }
    
    
//MARK: - Add Button
    @IBAction func addBtnWasPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { action in
            
            if let text = textField.text {
                // CoreData
                //let newCategory = Category(context: self.context)
                //newCategory.name = textField.text!
                //self.categories.append(newCategory)
                //self.saveCategories()
                
                // Realm
                var newCategory = CategoryRealm()
                newCategory.name = textField.text!
                self.save(category: newCategory)
                
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Input category name"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
        
        
    }
    
    
    //MARK: - CRUD
    
    // save
    
    //CoreData
//    func saveCategories() {
//
//        do {
//            try context.save()
//        } catch {
//            print("Saving categories erro: \(error.localizedDescription)")
//        }
//        tableView.reloadData()
//    }
    
    // Realm
    func save(category: CategoryRealm) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Saving realm error: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    // read
    
    // CoreData
//    func loadCategories() {
//        let request = Category.fetchRequest()
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Loading categories error: \(error.localizedDescription)")
//        }
//        tableView.reloadData()
//    }
    
    // Realm
    func loadCategories() {
        categoriesRealm = realm.objects(CategoryRealm.self)
        tableView.reloadData()
    }
    

  

}
