//
//  TodoVC.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 29.08.2022.
//

import UIKit
import CoreData

class TodoVC: UITableViewController {

    
    var items: [Item] = []
    
    var selectedCategory: Category? {
        // happens as soon as we set value
        didSet{
            loadItems()
        }
    }
    
    //CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    // NSCoder
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // UserDefaults
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults
//        if let itemsArr = defaults.array(forKey: "TodoItems") as? [String] {
//            items = itemsArr
//        }
        
        // request of all items
        
        //loadItems()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))


    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        // Configure the cell...
        
        
        let item = items[indexPath.row]
        
        
        
        cell.textLabel?.text = item.title
        
        
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(items[indexPath.row])
        
        //CRUD - update
        //items[indexPath.row].setValue("Completed", forKey: "title")
        
        //CRUD - delete
        // delete from context
        //context.delete(items[indexPath.row])
        // delete data from array
        //items.remove(at: indexPath.row)
        
        items[indexPath.row].done = !items[indexPath.row].done
        saveItems()
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDOEr Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // what will happen when when the user choose add item alert
            //print(textField.text)
            if let todo = textField.text {
                
                // NSCoder
                //let newItem = Item()
                
                //CoreData
                let newItem = Item(context: self.context)
                
                newItem.title = textField.text!
                newItem.done = false
                // set the relationship
                newItem.parentCategory = self.selectedCategory
                
                self.items.append(newItem)
                
                
                self.saveItems()
                
                // saving current changes
                //self.defaults.set(self.items, forKey: "TodoItems")
                
            }
            
            print("success")
        }
        
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - CRUD
    // Create / Update
    func saveItems() {
        
        // CoreData
        do {
            try context.save()
        } catch {
            print("Saving error: \(error.localizedDescription)")
        }
        self.tableView.reloadData()
        
        
        // NSCoder
//        let encoder = PropertyListEncoder()
//        do {
//            // trying to edcode data
//            let data = try encoder.encode(items)
//            // trying to save data to storage
//            try data.write(to: dataFilePath!)
//        } catch {
//            print(error.localizedDescription)
//        }
//        self.tableView.reloadData()
    }
    
    // Read                                         // default value
    func loadItems(request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        // CoreData
        //let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        
        // set loading for only proper items
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        // addition predicate
        if let additionalPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = categoryPredicate
        }
        
        
        
        do {
            items = try context.fetch(request)
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
        
        tableView.reloadData()
        //NSCoder
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                items = try decoder.decode([Item].self, from: data)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
    
    
    
    
    
    
    
    
}

//MARK: - SearchBar
extension TodoVC: UISearchBarDelegate {
    // Searching
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // read data
        let request: NSFetchRequest<Item> = Item.fetchRequest()
      //create a search method   // if title of Item  //Contains //value    //this value
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
      // set sort properties
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
      // perform reauest // request of proper items
        loadItems(request: request, predicate: predicate)
        
        // close the keyboard after search
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    // Get back to all items
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            
            // close the keybord and hide searchbar mark
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
        
    }
}
