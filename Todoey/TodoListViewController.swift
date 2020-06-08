//
//  ViewController.swift
//  Todoey
//
//  Created by Mac on 04/06/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Udemy course", "web series", "Buy Cosmatics"]
    let defaults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //to save current added item in app list
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Tableview datasourse method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //Tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       // code for select and deselct row and add checkmaek to it
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item to Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the clicks add item
            self.itemArray.append(textField.text!)
            
           self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //add and display added item to table view reload() method used
            
            self.tableView.reloadData() 
        }
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new item"
            print(alertTextFeild.text)
            textField = alertTextFeild
            
            print(alertTextFeild.text)
        }
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    



