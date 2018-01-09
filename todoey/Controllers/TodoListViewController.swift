//
//  ViewController.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/8/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults=UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1=Item()
        newItem1.title="aaaa"
//        newItem1.done=true
        itemArray.append(newItem1)
        
        let newItem2=Item()
        newItem2.title="bbbb"
        itemArray.append(newItem2)
        
        let newItem3=Item()
        newItem3.title="cccc"
        itemArray.append(newItem3)
        
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)
//        itemArray.append(newItem3)

        
        
        if let items=defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray=items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item=itemArray[indexPath.row]
        cell.textLabel?.text=item.title
        cell.accessoryType=item.done ? .checkmark : .none
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done==false{
//            itemArray[indexPath.row].done=true
//        }else{
//            itemArray[indexPath.row].done=false
//        }
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "add new todoe item", message: "aaaa", preferredStyle: .alert)
        let action=UIAlertAction(title: "add item", style: .default) { (action) in
            
            let newItem=Item()
            newItem.title=textField.text!
            self.itemArray.append(newItem)
//            print(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
//            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTF) in
            alertTF.placeholder="create new item"
            textField=alertTF
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


}

