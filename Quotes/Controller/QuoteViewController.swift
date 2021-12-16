//
//  QuoteViewController.swift
//  Quotes
//
//  Created by Calvin Alfrido on 16/12/21.
//

import UIKit
import DSGradientProgressView

class QuoteViewController: UITableViewController {
    @IBOutlet weak var progressView: DSGradientProgressView!
    
    var quotes: Quote? = nil
    var selectedAuthor: String?{
        didSet{
            fetchQuotes(with: selectedAuthor!)
        }
    }
    
    override func viewDidLoad() {
        progressView.wait()
        tableView.register(UINib(nibName: K.quoteNibName, bundle: nil), forCellReuseIdentifier: K.quoteCellIdentifier)
        tableView.reloadData()
    }
    
    func fetchQuotes(with author: String) {
        var urlComp = URLComponents(string: "https://goquotes-api.herokuapp.com/api/v1/random/1")
        urlComp?.queryItems = [
            URLQueryItem(name: "type", value: "author"),
            URLQueryItem(name: "val", value: author)
        ]
        if let url = urlComp?.url {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data , response , error in
                if let e = error {
                    print(e)
                }
                if let quoteJson = data {
                    let decoder = JSONDecoder()
                    do {
                        self.quotes = try decoder.decode(Quote.self, from: quoteJson)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.progressView.signal()
                        }
                    }catch {
                        print(error)
                    }
                }
            }
            task.resume()
            
        }
    }
    
//MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes?.quotes.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: K.quoteCellIdentifier)) as! QuoteTableViewCell
        if let quotesLoaded = quotes?.quotes {
            cell.content.text = quotesLoaded[indexPath.row].text
            cell.tagLabel.text = "Tag : #" + quotesLoaded[indexPath.row].tag
        }
        
        return cell
    }
}
