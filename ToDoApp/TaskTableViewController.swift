//
//  TaskTableViewController.swift
//  Task
//
//  Created by Smart on 2019/07/11.
//  Copyright © 2019 Smart. All rights reserved.
//
import UIKit
import RealmSwift

class TaskTableViewController: UITableViewController {

    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

      @IBAction func didTapAddTask(_ sender: Any) {

        let alertController = UIAlertController(title: "タスクを追加しますか", message: nil, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "追加", style: .default) { action -> Void in
            let textField = alertController.textFields![0] as UITextField
            if let text = textField.text {
                let task = Task()
                task.text = text
                try! self.realm.write {
                    self.realm.add(task)
                }
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "タスクを追加"
        }
        alertController.addAction(action)
        alertController.addAction(cancel)

        present(alertController, animated: true, completion: nil)

    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let tasks = realm.objects(Task.self)
        return tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let tasks = realm.objects(Task.self)
        let task = tasks[indexPath.row]

        cell.textLabel?.text = task.text

        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let tasks = realm.objects(Task.self)
            let task = tasks[indexPath.row]

            try! realm.write {
                realm.delete(task)
            }

            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
