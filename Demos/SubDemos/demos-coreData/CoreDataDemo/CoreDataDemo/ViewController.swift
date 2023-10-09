//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by zhouweijie on 2019/4/25.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var container: DemoPersistentContainer!
    
    var people = [NSManagedObject]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        
        tableView.register(UINib(nibName: "TableViewCellXib", bundle: nil), forCellReuseIdentifier: "identifier")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            try people = container.viewContext.fetch(fetchRequest)
        } catch {
            print("fetch failed")
        }
    }

    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "增", message: nil, preferredStyle: UIAlertController.Style.alert)
        let checkAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
            let context = self.container.viewContext
            let person = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: "Person", in: context)!, insertInto: context)
            context.insert(person)
            person.setValue(alert.textFields?[0].text, forKeyPath: "name")
            person.setValue(Int((alert.textFields?[1].text)!), forKeyPath: "age")
            person.setValue(alert.textFields?[2].text, forKeyPath: "from")
            self.people.append(person)
            self.container.saveContext()
            self.tableView.reloadData()
        })
        alert.addAction(checkAction)
        alert.preferredAction = checkAction;
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "名字："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.borderStyle = .roundedRect
        }
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "年龄："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.borderStyle = .roundedRect
        }
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "来自："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.borderStyle = .roundedRect
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deletePerson(_ sender: Any) {
        let alert = UIAlertController(title: "确定要删除已选中的数据吗？", message: nil, preferredStyle: UIAlertController.Style.alert)
        let checkAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
            guard let selectedIndexPaths = self.tableView.indexPathsForSelectedRows else {return}
            let context = self.container.viewContext
            for indexPath in selectedIndexPaths {
                let person = self.people[indexPath.row]
                self.people.remove(at: indexPath.row)
                context.delete(person)
            }
            self.container.saveContext()
            self.tableView.reloadData()
        })
        alert.addAction(checkAction)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func modify(_ sender: Any) {
        guard let selectedIndexPaths = self.tableView.indexPathsForSelectedRows else {return}
        let context = self.container.viewContext
        let indexPath = selectedIndexPaths[0]
        let oldPerson = self.people[indexPath.row]
        let alert = UIAlertController(title: "改", message: nil, preferredStyle: UIAlertController.Style.alert)
        let checkAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
            let name = alert.textFields?[0].text ?? ""
            let age = Int(alert.textFields?[1].text ?? "")
            let from = alert.textFields?[2].text ?? ""
            let person = NSManagedObject(entity: NSEntityDescription.entity(forEntityName: "Person", in: context)!, insertInto: context)
            person.setValue(name, forKeyPath: "name")
            person.setValue(age, forKeyPath: "age")
            person.setValue(from, forKeyPath: "from")
            self.people.remove(at: indexPath.row)
            context.delete(oldPerson)
            self.people.insert(person, at: indexPath.row)
            context.insert(person)
            self.container.saveContext()
            self.tableView.reloadData()
        })
        alert.addAction(checkAction)
        alert.preferredAction = checkAction;
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "名字："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.borderStyle = .roundedRect
            textField.text = oldPerson.value(forKeyPath: "name") as? String
        }
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "年龄："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.borderStyle = .roundedRect
            let age = oldPerson.value(forKeyPath: "age") as? Int ?? 0
            textField.text = "\(age)"
        }
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "来自："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .never
            textField.borderStyle = .roundedRect
            textField.text = oldPerson.value(forKeyPath: "from") as? String
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func query(_ sender: Any) {
        let alert = UIAlertController(title: "输入你要查询的条件", message: nil, preferredStyle: UIAlertController.Style.alert)
        let checkAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
            guard let predicateString = alert.textFields?[0].text else {return}
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
            if predicateString != "" {
                fetchRequest.predicate = NSPredicate(format: predicateString)
            }
            do{
                try self.people = self.container.viewContext.fetch(fetchRequest)
                self.tableView.reloadData()
            } catch {
            }
        })
        alert.addAction(checkAction)
        alert.addTextField { (textField) in
            let leftView = UILabel()
            leftView.text = "条件："
            leftView.frame = CGRect(origin: .zero, size: leftView.intrinsicContentSize)
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.borderStyle = .roundedRect
            textField.text = "age < 30"
        }
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sort(_ sender: Any) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        let sortDescriptor = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            try self.people = self.container.viewContext.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch {
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! TableViewCell
        let person = people[indexPath.row]
        cell.name.text = person.value(forKeyPath: "name") as? String
        let age = person.value(forKeyPath: "age") as? Int ?? 0
        cell.age.text = "\(age)"
        cell.from.text = person.value(forKeyPath: "from") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

