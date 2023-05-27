//
//  FirstViewController.swift
//  ios-stations
//  made by iseki ryutaro
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    var books: [Book]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  //ミッション９
    @IBAction func changeButtonBackgroundColor() {
        self.button.backgroundColor = UIColor.random
    }
    
    @IBAction func presentSecondViewController(_ sender: Any) {
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

