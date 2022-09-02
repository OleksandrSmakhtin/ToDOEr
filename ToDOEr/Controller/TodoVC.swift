//
//  TodoVC.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 29.08.2022.
//

import UIKit

class TodoVC: UITableViewController {

    
    var items = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    // a user data base for storing keys and values
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        
//        if let itemsArr = defaults.array(forKey: "TodoItems") as? [String] {
//            items = itemsArr
//        }


        loadItems()


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
        
        items[indexPath.row].done = !items[indexPath.row].done
        saveItems()
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDOEe Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // what will happen when when the user choose add item alert
            print(textField.text)
            if let todo = textField.text {
                
                let newItem = Item()
                newItem.title = textField.text!
                
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
    
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            // trying to edcode data
            let data = try encoder.encode(items)
            // trying to save data to storage
            try data.write(to: dataFilePath!)
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            
            
            
            
        }
        
        
    }
    
    
    
}
