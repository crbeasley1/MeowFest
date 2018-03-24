//
//  ViewController.swift
//  Meow Fest
//
//  Created by Nicholas Ollis on 3/24/18.
//  Copyright © 2018 Nicholas Ollis. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var meows: Meows? = Meows()
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        meows = getData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meows?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meowCell", for: indexPath) as! MeowTableViewCell;
        
        guard let meow = meows?[indexPath.row] else {
            return cell
        }
        
        return cell.set(meow: meow)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260.5
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let meowsCount = meows?.count, indexPath.row + 1 == meowsCount, meowsCount > 0 {
            currentPage += 1
            _ = getData()
        }
    }

}

extension ViewController: Networkable {
    
    func newCats(_ meows: Meows) {
        if self.meows != nil {
            self.meows!.append(contentsOf: meows)
        } else {
            self.meows = meows
        }
        tableView.reloadData()
    }
    
    
    var testing: Bool {
        return false
    }
    
}

