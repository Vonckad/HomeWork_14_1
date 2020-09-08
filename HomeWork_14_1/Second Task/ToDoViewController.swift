//
//  ToDoViewController.swift
//  HomeWork_14_1
//
//  Created by Vlad Ralovich on 8/18/20.
//

import UIKit
import RealmSwift

class ToDoViewController: UITableViewController {

    @IBOutlet var clearButtonEnable: UIBarButtonItem!
    var realm: Realm!
    
    var toDoList: Results<PersistanceRealm> {
        get {
            return realm.objects(PersistanceRealm.self)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
    }
    
    //MARK: UITableDataSourse
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        let item = toDoList[indexPath.row]
        cell.nameLableCell.text = item.name
        
        return cell
    }
    
    //MARK: UITableDelegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = toDoList[indexPath.row]
            
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    @IBAction func addButtonBar(_ sender: UIBarButtonItem) {
        
        let allert = UIAlertController.init(title: "Новая задача", message: "Какую задачу добавить?", preferredStyle: .alert)
        allert.addTextField { (UITextField) in
            
        }
        
        let canceAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        allert.addAction(canceAction)
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (UIAlertAction) -> Void in
           
            let toDoItemTextField = (allert.textFields?.first)! as UITextField
    
            let todoListItem = PersistanceRealm()
            todoListItem.name = toDoItemTextField.text!
            
            try! self.realm.write({
                self.realm.add(todoListItem)
                
                self.tableView.insertRows(at: [IndexPath.init(row: self.toDoList.count-1, section: 0  )], with: .automatic)
            })
           
        }
        allert.addAction(addAction)
        present(allert, animated: true, completion: nil)
    }
    @IBAction func editButtonBar(_ sender: Any) {
        
        tableView.isEditing = tableView.isEditing ? false : true
        clearButtonEnable.isEnabled = tableView.isEditing ? true : false
    }
    @IBAction func clearButton(_ sender: Any) {

        try! self.realm.write({
            self.realm.delete(toDoList)
        })
        tableView.reloadData()
    }
}
