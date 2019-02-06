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

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Mike 2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Mike 3"
        itemArray.append(newItem3)
        
        
        if let items = self.defaults.array(forKey: "TodoListArray") as? [Item]
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
                let newItem = Item()
                newItem.title = (alert.textFields?.first?.text!)!
                self.itemArray.append(newItem)
                
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
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
        
    }
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.cellForRow(at: indexPath)?.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

