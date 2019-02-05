//
//  ViewController.swift
//  Todoey
//
//  Created by Mohammad Aq on 2/4/19.
//  Copyright © 2019 Masashi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController
{

    var itemArray = [String]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if items = self.defaults.array(forKey: "TodoListArray")
        {
            self.itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Add Item", style: UIAlertActionStyle.default) { (action) in
            
            // what happens when user clicks the Add Item button
            
            if !(alert.textFields?.first?.text?.isEmpty)!
            {
                self.itemArray.append((alert.textFields?.first?.text!)!)
                
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "Create new item"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

