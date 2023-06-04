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
    let refreshControl = UIRefreshControl()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchBooksFromAPI()
    }
    
    //APIクライアントを使用して書籍データを非同期にFetchし、成功した場合は、TableViewの更新、失敗した場合は、エラーダイアログを出す。
    func fetchBooksFromAPI() {
        showLoading()
        bookAPIClient.fetchBooks(offset: 10) { [weak self] fetchedBooks in
            DispatchQueue.main.async {
                self?.stopLoading()
            }
            
            guard let fetchedBooks = fetchedBooks else {
                DispatchQueue.main.async {
                    self?.showErrorAlert()
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.books = fetchedBooks
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func refreshTableView() {
        //変化が確認できるように一度リストを空にする。
        books?.removeAll()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
        fetchBooksFromAPI()
    }
    
    @IBAction func fetchBooks(_ sender: Any) {
        refreshTableView()
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Failed to fetch books.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
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
        cell.text2.text = book.detail
        cell.text2.numberOfLines = 3
        cell.text2.sizeToFit()
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
