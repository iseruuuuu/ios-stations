//
//  FirstViewController.swift
//  ios-stations
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    var books: [Book]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ミッション２？で設定した背景色の追加
        self.view.backgroundColor = UIColor(named: "Main")
        button.backgroundColor = UIColor.random
        //iself.view.backgroundColor = UIColor.Theme.main
    }
    
    
    @IBAction func presentSecondViewController(_ sender: Any) {
        //ミッション９
        //button.backgroundColor = UIColor.random
        let presentSecondViewController = storyboard!.instantiateViewController(identifier: "SecondView") as SecondViewController
        presentSecondViewController.url = ""
        self.present(presentSecondViewController, animated: true, completion: nil)
        
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

