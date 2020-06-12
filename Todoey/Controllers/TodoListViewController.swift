//
//  ViewController.swift
//  Todoey
//
//  Created by Mac on 04/06/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first?.appendingPathComponent("Items.plist")
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(dataFilePath)
        
        
        let newItem = Item()
        newItem.title = "Udemy course"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Max shopping"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Nykyaa delivery"
        itemArray.append(newItem3)
        //to save current added item in app list
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
      //     itemArray = items
    //    }

        
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary operator ==>
        //value =  condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
    }
    
    //Tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       saveIrems()
    
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item to Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the clicks add item
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.saveIrems()
            
          
        }
        
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new item"
            print(alertTextFeild.text)
            textField = alertTextFeild
            
            
        }
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        }
    
    //Model Manupulation Methods
    
    func saveIrems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        
        
        //add and display added item to table view reload() method used
        
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error is print, \(error)")
            }
    }
        
        
    }
}
    



