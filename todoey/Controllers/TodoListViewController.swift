//
//  ViewController.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/8/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    var toDoItems:Results<Item>?
    let realm=try! Realm()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    //    let defaults=UserDefaults.standard
    //    let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //        searchBar.delegate=self
        
        //                print(dataFilePath)
        //        let newItem1=Item()
        //        newItem1.title="aaaa"
        //        //        newItem1.done=true
        //        toDoItems.append(newItem1)
        //
        //        let newItem2=Item()
        //        newItem2.title="bbbb"
        //        toDoItems.append(newItem2)
        //
        //        let newItem3=Item()
        //        newItem3.title="cccc"
        //        toDoItems.append(newItem3)
        
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        //        toDoItems.append(newItem3)
        
        
        
        //        if let items=defaults.array(forKey: "TodoListArray") as? [Item]{
        //            toDoItems=items
        //        }
        // Do any additional setup after loading the view, typically from a nib.
        
        //        loadItems()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item=toDoItems?[indexPath.row]{
            cell.textLabel?.text=item.title
            cell.accessoryType=item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text="No Items Added."
        }
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item=toDoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }}catch{
                    print("error saving done status \(error)")
            }
        }
        tableView.reloadData()
        //        print(toDoItems[indexPath.row])
        //        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //        toDoItems[indexPath.row].setValue("done baby", forKey: "title")
        
        //        toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
        //        saveItems()
        
        //        if toDoItems[indexPath.row].done==false{
        //            toDoItems[indexPath.row].done=true
        //        }else{
        //            toDoItems[indexPath.row].done=false
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
            
            if let currentCategory=self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem=Item()
                        newItem.title=textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }}catch{
                        print("error saving new items \(error)")
                }
            }
            self.tableView.reloadData()
            //            newItem.parentCategory = self.selectedCategory
            //            self.toDoItems.append(newItem)
            //            self.saveItems()
            //            print(textField.text!)
            
            //            self.defaults.set(self.toDoItems, forKey: "TodoListArray")
            
            //            self.toDoItems.append(textField.text!)
            
            
        }
        alert.addTextField { (alertTF) in
            alertTF.placeholder="create new item"
            textField=alertTF
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //    func saveItems(){
    //        //        let encoder=PropertyListEncoder()
    //        do{
    //
    //            try context.save()
    //            //            let data=try encoder.encode(toDoItems)
    //            //            try data.write(to: dataFilePath!)
    //        }catch{
    //            //            print("error encoding item array \(error)")
    //            print("error saving context, \(error)")
    //        }
    //
    //        self.tableView.reloadData()
    //    }
    func loadItems(){
        toDoItems=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        //        if let data = try? Data(contentsOf: dataFilePath!){
        //            let decoder=PropertyListDecoder()
        //            do{
        //            toDoItems=try decoder.decode([Item].self, from: data)
        //            }catch{
        //                print("error docoding item array. \(error)")
        //            }
        //        }
        
        //        let request:NSFetchRequest<Item>=Item.fetchRequest()
        //        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        ////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
        ////        request.predicate = compoundPredicate
        //        if let additionalPredicate=predicate{
        //            request.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        //        }else{
        //            request.predicate=categoryPredicate
        //        }
        //        do{
        //            toDoItems = try context.fetch(request)
        //        }catch{
        //            print("Error fetching data from context, \(error)")
        //        }
        
        
    }
    
}

extension TodoListViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems=toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
//        let request:NSFetchRequest<Item>=Item.fetchRequest()
//        //        print(searchBar.text!)
//        let predicate=NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors=[NSSortDescriptor(key: "title", ascending: true)]
//        //        let request:NSFetchRequest<Item>=Item.fetchRequest()
//        loadItems(with: request,predicate: predicate)
//        //        do{
//        //            toDoItems = try context.fetch(request)
//        //        }catch{
//        //            print("Error fetching data from context, \(error)")
//        //        }
//        tableView.reloadData()
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

