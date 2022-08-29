//
//  TodoVC.swift
//  ToDOEr
//
//  Created by Oleksandr Smakhtin on 29.08.2022.
//

import UIKit

class TodoVC: UITableViewController {

    
    var items = [String]()
    
    // a user data base for storing keys and values
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let itemsArr = defaults.array(forKey: "TodoItems") as? [String] {
            items = itemsArr
        }



    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
        
        
        
        
        
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDOEe Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // what will happen when when the user choose add item alert
            print(textField.text)
            if let todo = textField.text {
                self.items.append(todo)
                
                // saving current changes
                self.defaults.set(self.items, forKey: "TodoItems")
                
                self.tableView.reloadData()
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
    
}
