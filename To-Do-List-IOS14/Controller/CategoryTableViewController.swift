//
//  CategoryTableViewController.swift
//  To-Do-List-IOS14
//
//  Created by 程式猿 on 2021/3/24.
//

import UIKit
import CoreData
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var itemArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = itemArray?[indexPath.row].name ?? "No add yet"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItem", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destnationVC = segue.destination as! TosoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destnationVC.selectCategor = itemArray?[indexPath.row]
        }
    }

    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "加新的 TODO", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "加一個項目", style: .default) { (action) in
            let newItem = Category()
            newItem.name = textField.text!
            self.saveItems(category: newItem)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "增加新項目"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletItem = itemArray![indexPath.row]
            try! realm.write {
                    realm.delete(deletItem)
                }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func saveItems(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error:\(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        itemArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}
