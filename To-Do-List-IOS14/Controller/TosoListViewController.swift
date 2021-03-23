//
//  ViewController.swift
//  To-Do-List-IOS14
//
//  Created by 程式猿 on 2021/3/22.
//

import UIKit
import CoreData

class TosoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "加新的 TODO", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "加一個項目", style: .default) { (action) in
            let newItem = Item(context: self.context!)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "增加新項目"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        do {
            try context!.save()
        } catch {
            print("Error:\(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
//        let request = NSFetchRequest<NSFetchRequestResult> (entityName: "Item")
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context!.fetch(request)
//            for data in result as! [NSManagedObject] {
////                let title = data.value(forKey: "title") as! String
////                let done = data.value(forKey: "done") as! Bool
//                itemArray.append(data as! Item)
//            }
//        } catch {
//            print("Error: \(error)")
//        }
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context!.fetch(request)
        } catch {
            print(error)
        }
    }
        
}

