//
//  FirstViewController.swift
//  ios-stations
//  made by iseki ryutaro
//

import UIKit

class FirstViewController: UIViewController{
    
    var books: [Book]? = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var bookAPIClient: BookAPIClientProtocol = BookAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookAPIClient.fetchBooks(offset: 10) { [weak self] fetchedBooks in
            guard let fetchedBooks = fetchedBooks else {
                print("Failed to fetch books.")
                return
            }
            DispatchQueue.main.async {
                self?.books = fetchedBooks
            }
        }
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? BookCell else {
            fatalError("Dequeue failed: AnimalTableViewCell.")
        }
        guard let books = books, indexPath.row < books.count else {
            return cell
        }
        let book =  books[indexPath.row]
        cell.images.image = UIImage(named: "Book")
        cell.text1.text = book.title
        cell.text2.text = book.id
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let books = books else {
            return 0
        }
        return books.count
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presentSecondViewController = storyboard!.instantiateViewController(identifier: "SecondView") as SecondViewController
        presentSecondViewController.url = books?[indexPath.row].url
        self.present(presentSecondViewController, animated: true, completion: nil)
    }
}
