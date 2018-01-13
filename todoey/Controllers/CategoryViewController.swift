//
//  CategoryViewController.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/11/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm=try! Realm()
    
    var categories:Results<Category>!
//    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text=categories?[indexPath.row].name ?? "No Categories Yet Added"
        return cell
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert=UIAlertController(title: "add new category", message: "", preferredStyle: .alert)
        let action=UIAlertAction(title: "add", style: .default) { (action) in
            let newCategory=Category()
            newCategory.name=textField.text!
//            self.categories.append(newCategory)
            self.save(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField=field
            textField.placeholder="add a new category"
        }
        present(alert, animated: true, completion: nil)
        
    }
    func save(category:Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    func loadCategories(){
        categories=realm.objects(Category.self)
        
//        let request:NSFetchRequest<Category>=Category.fetchRequest()
//        do{
//            categories = try context.fetch(request)
//        }catch{
//            print("Error loading categories \(error)")
//        }
//        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC=segue.destination as! TodoListViewController
        if let indexPath=tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}
