//
//  ViewController.swift
//  Project1
//
//  Created by Ярослав on 3/16/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        if let savedData = UserDefaults.standard.data(forKey: "pictures"){
            do{
                pictures = try  JSONDecoder().decode([Picture].self, from: savedData)
            } catch {
                print("loading from user defaults failed")
            }
        }
        
        if pictures.isEmpty{
            DispatchQueue.global(qos: .userInitiated).async {
                [weak self] in
                let fm = FileManager.default
                let path = Bundle.main.resourcePath!
                let items = try! fm.contentsOfDirectory(atPath: path)
                
                for item in items{
                    if item.hasPrefix("nssl"){
                        self?.pictures.append(Picture(name: item, amountOfViews: 0))
                    }
                }
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].name
        cell.detailTextLabel?.text = String(pictures[indexPath.row].amountOfViews)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].name
            vc.imageIndex = indexPath.row + 1
            vc.picturesNumber = pictures.count
            pictures[indexPath.row].amountOfViews += 1
            save()
        navigationController?.pushViewController(vc, animated: true)
        }else{
            print("if let brocken")
        }
        
        
    }
    
    func save(){
        if let savedImages = try? JSONEncoder().encode(pictures){
            UserDefaults.standard.setValue(savedImages, forKey: "pictures")
        }
        pictures.sort()
        tableView.reloadData()
    }
   
    
  
    
}

