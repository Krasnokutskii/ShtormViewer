//
//  ViewController.swift
//  Project1
//
//  Created by Ярослав on 3/16/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items{
                if item.hasPrefix("nssl"){
                    self?.pictures.append(item)
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.pictures.sort()
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageIndex = indexPath.row + 1
            vc.picturesNumber = pictures.count
        navigationController?.pushViewController(vc, animated: true)
        }else{
            print("if let brocken")
        }
        
        
    }
   
    
  
    
}

