//
//  CategoryVC.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 04.09.2022.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
    }


//MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let name = categories[indexPath.row].name
        
        
        cell.textLabel?.text = name
        
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
                todoVC.selectedCategory = categories[indexPath.row]
            }
        }
    }
    
    
//MARK: - Add Button
    @IBAction func addBtnWasPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { action in
            
            if let text = textField.text {
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
                self.categories.append(newCategory)
                self.saveCategories()
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
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Saving categories erro: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    // read
    func loadCategories() {
        let request = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Loading categories error: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    

  

}
