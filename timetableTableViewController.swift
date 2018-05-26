//
//  timetableTableViewController.swift
//  cellFun
//
//  Created by Qin Mao on 2018/5/26.
//  Copyright © 2018年 MAGNUMIUM. All rights reserved.
//

import UIKit


class timetableViewController: UITableViewController{
    
    @IBOutlet weak var timetableView: UITableView!
    
    var data = [Employee]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData();
    }
    var filepath: String{
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: . userDomainMask).first;
        return  url!.appendingPathComponent("data").path;
    }
    
    private func loadData(){
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filepath)as?[Employee]{
            data = ourData;
        }
    }
    private func saveData(employee: Employee) {
        data.append(employee);
        
        NSKeyedArchiver.archiveRootObject(data, toFile: filepath);
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   override func numberOfSections(in timetableView: UITableView) -> Int {
        
        return 1
    }
    
    func timetableView(_ timetableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count;
    }
  func timetableView(_ timetableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath);
        
        cell.textLabel?.text = data[indexPath.row].name;
        cell.detailTextLable?.text = data[indexPath.row].days;
        
        return cell;
        
    }
   
    
    
    func timetableView(_ timetableView: UITableView, didSelectRowAt indexpath: IndexPath) {
        let index = timetableView.indexPathForRow.row;
        
        performSegue(withIdentifier: "EditSegue", sender: index);
    }
    
    @IBAction func addnew(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add new employee",
                                      message: "Enter employee's name",
                                      preferredStyle: .alert);
        
        let save = UIAlertAction(title:"save", style: .default ){
            (alertAction:UIAlertAction) in
            
            let name = alert.textFields?[0].text!;
            let days = alert.textFields?[1].text!;
            let newEmpolyee = Employee(name: name!, days: days!);
            
            
            self.saveData(employee: newEmpolyee);
            
            self.timetableView.reloadData();
            
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .default, handler: nil);
        
        alert.addTextField(configurationHandler: nil);
        alert.addTextField(configurationHandler: nil);
        
        alert.addAction(save);
        alert.addAction(cancel);
        
        self.present(alert, animated: true, completion: nil);
    
        
        func prepare(for segue: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>){
            
            if let destination = segue.destination as? ViewController2 {
                
                if let index = sender as？ Int {
                    destination.index = index;
                    destination.data = data;
                    destination.path = filepath;
                }
                }
            }
        }
}
