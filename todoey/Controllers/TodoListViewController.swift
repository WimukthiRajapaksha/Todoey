//
//  ViewController.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/8/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    //    let defaults=UserDefaults.standard
    //    let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //        searchBar.delegate=self
        
//                print(dataFilePath)
        //        let newItem1=Item()
        //        newItem1.title="aaaa"
        //        //        newItem1.done=true
        //        itemArray.append(newItem1)
        //
        //        let newItem2=Item()
        //        newItem2.title="bbbb"
        //        itemArray.append(newItem2)
        //
        //        let newItem3=Item()
        //        newItem3.title="cccc"
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
        //        itemArray.append(newItem3)
        
        
        
        //        if let items=defaults.array(forKey: "TodoListArray") as? [Item]{
        //            itemArray=items
        //        }
        // Do any additional setup after loading the view, typically from a nib.
        
//        loadItems()
        
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
        
        //        itemArray[indexPath.row].setValue("done baby", forKey: "title")
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        //        if itemArray[indexPath.row].done==false{
        //            itemArray[indexPath.row].done=true
        //        }else{
        //            itemArray[indexPath.row].done=false
        //        }
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        }else{
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }
        //
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "add new todoe item", message: "aaaa", preferredStyle: .alert)
        let action=UIAlertAction(title: "add item", style: .default) { (action) in
            
            let newItem=Item(context: self.context)
            newItem.title=textField.text!
            newItem.done=false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
            //            print(textField.text!)
            
            //            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //            self.itemArray.append(textField.text!)
            
            
        }
        alert.addTextField { (alertTF) in
            alertTF.placeholder="create new item"
            textField=alertTF
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        //        let encoder=PropertyListEncoder()
        do{
            
            try context.save()
            //            let data=try encoder.encode(itemArray)
            //            try data.write(to: dataFilePath!)
        }catch{
            //            print("error encoding item array \(error)")
            print("error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    func loadItems(with request:NSFetchRequest<Item>=Item.fetchRequest(),predicate:NSPredicate?=nil){
        //        if let data = try? Data(contentsOf: dataFilePath!){
        //            let decoder=PropertyListDecoder()
        //            do{
        //            itemArray=try decoder.decode([Item].self, from: data)
        //            }catch{
        //                print("error docoding item array. \(error)")
        //            }
        //        }
        
        //        let request:NSFetchRequest<Item>=Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//        request.predicate = compoundPredicate
        if let additionalPredicate=predicate{
            request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }else{
            request.predicate=categoryPredicate
        }
        do{
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context, \(error)")
        }
        
    }
    
}

extension TodoListViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<Item>=Item.fetchRequest()
        //        print(searchBar.text!)
        let predicate=NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors=[NSSortDescriptor(key: "title", ascending: true)]
        //        let request:NSFetchRequest<Item>=Item.fetchRequest()
        loadItems(with: request,predicate: predicate)
        //        do{
        //            itemArray = try context.fetch(request)
        //        }catch{
        //            print("Error fetching data from context, \(error)")
        //        }
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
