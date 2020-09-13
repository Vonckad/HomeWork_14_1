//
//  ToDoViewController.swift
//  HomeWork_14_1
//
//  Created by Vlad Ralovich on 8/18/20.
//

import UIKit
import RealmSwift
import CoreData

class ToDoViewController: UITableViewController {
    
    @IBOutlet var tableViewRealm: UITableView!
    @IBOutlet var mySegment: SegmentView!
    @IBOutlet var clearButtonEnable: UIBarButtonItem!
    
    let tableViewCoreData = UITableView()
    var itemArrayCoreData = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var realm: Realm!
    var toDoList: Results<PersistanceRealm> {
        get {
            return realm.objects(PersistanceRealm.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mySegment.delegate = self
        
        tableViewCoreData.delegate = self
        tableViewCoreData.dataSource = self
        tableViewCoreData.backgroundColor = tableViewRealm.backgroundColor
        
        realm = try! Realm()
    }
    
    //MARK: UITableDataSourse
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView == tableViewCoreData ? itemArrayCoreData.count : toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewRealm.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        
        if tableView == tableViewCoreData {
            
        let item = itemArrayCoreData[indexPath.row]
        cell.nameLableCell.text = item.task
        
        } else {
            
        let item = toDoList[indexPath.row]
        cell.nameLableCell.text = item.name
        }
        
        return cell
    }
    
    //MARK: UITableDelegate
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            if self.tableView == self.tableViewCoreData {
                
            let item = itemArrayCoreData[indexPath.row]
            context.delete(item)
            itemArrayCoreData.remove(at: indexPath.row)
            tableViewCoreData.deleteRows(at: [indexPath], with: .automatic)
                
            saveItems()
            
            } else {
            
            let item = toDoList[indexPath.row]
            
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    @IBAction func addButtonBar(_ sender: UIBarButtonItem) {
        
        let allert = UIAlertController.init(title: "Новая задача", message: "Какую задачу добавить?", preferredStyle: .alert)
        allert.addTextField { (UITextField) in }
        
        let canceAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        allert.addAction(canceAction)
        let addAction = UIAlertAction(title: "Добавить", style: .default) { (UIAlertAction) -> Void in
            let toDoItemTextField = (allert.textFields?.first)! as UITextField
            
            if self.tableView == self.tableViewCoreData {
                
                let newItem = Item(context: self.context)
                newItem.task = toDoItemTextField.text!
                self.itemArrayCoreData.append(newItem)
                
                self.saveItems()
               
            } else {
                
            
            let todoListItem = PersistanceRealm()
            todoListItem.name = toDoItemTextField.text!
            try! self.realm.write({
                self.realm.add(todoListItem)
                
                self.tableViewRealm.insertRows(at: [IndexPath.init(row: self.toDoList.count-1, section: 0  )], with: .automatic)
                })
            }
        }
        allert.addAction(addAction)
        present(allert, animated: true, completion: nil)
    }
    
    func saveItems(){
    
        do{
            try context.save()
        }catch {
            print("Error saving context with \(error)")
        }
        
        self.tableViewCoreData.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        do {
            itemArrayCoreData = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        tableViewCoreData.reloadData()
        
    }
    
//    func DeleteAllData(){
//
//        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Item"))
//        do {
//            try context.execute(DelAllReqVar)
//        }
//        catch {
//            print(error)
//        }
//        tableViewCoreData.reloadData()
//    }
//
    @IBAction func editButtonBar(_ sender: Any) {
        
        tableView.isEditing = tableView.isEditing ? false : true
        clearButtonEnable.isEnabled = tableView.isEditing ? true : false
        
    }
    @IBAction func clearButton(_ sender: Any) {

        if self.tableView == self.tableViewCoreData {
            
            let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Item"))
            do {
                try context.execute(DelAllReqVar)
            }
            catch {
                print(error)
            }
            
        } else {
        
        try! self.realm.write({
            self.realm.delete(toDoList)
        })
//            tableViewRealm.reloadData()
        }
        tableView.reloadData()
    }
}

//MARK: extension ToDoViewController
// добавил мой сегмент для переключения таблиц

extension ToDoViewController: SegmentViewDelegate {
    func SegmentViewPressed(_ testView: String) {
        
        if testView == "Выбран Realm" {
            print(testView)
            self.tableView = tableViewRealm
            
        } else if testView == "Выбран CoreData" {
            print(testView)
            loadItems()
            self.tableView = tableViewCoreData
        }
    }
}
