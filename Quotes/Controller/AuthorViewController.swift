//
//  AuthorViewController.swift
//  Author
//
//  Created by Calvin Alfrido on 16/12/21.
//

import UIKit
import DSGradientProgressView

class AuthorViewController: UIViewController {
    @IBOutlet weak var progressView: DSGradientProgressView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var authors: Author?
    var authorArray: [AuthorMember]?
    var selectedAuthor: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView.wait()
        
        hideKeyboard()
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAuthors()
    }
    
    func fetchAuthors() {
        let urlString: String = "https://goquotes-api.herokuapp.com/api/v1/all/authors"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data , response , error in
                if let e = error {
                    print(e)
                }
                else if let authorJson = data {
                    let decoder = JSONDecoder()
                    do {
                        self.authors = try decoder.decode(Author.self, from: authorJson)
                        self.authorArray = self.authors?.authors
                        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? QuoteViewController {
            destinationVC.selectedAuthor = selectedAuthor!
        }
    }


}

//MARK: - Table View DataSource Methods

extension AuthorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.authorCellIdentifier)!
        if let authorArrayNotEmpty = authorArray {
            cell.textLabel?.text = authorArrayNotEmpty[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authorArray?.count ?? 0
    }
}


//MARK: - Table View Delegate Methods

extension AuthorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedAuthor = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        performSegue(withIdentifier: K.authorToQuoteSegue, sender: self)
    }
}

//MARK: - Search Bar Delegate Methods

extension AuthorViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let authorTemp = authors?.authors {
            if searchText.count == 0 {
                authorArray = authorTemp
            }
            else {
                authorArray = authorTemp.filter { author in
                    return author.name.localizedStandardContains(searchText)
                }
            }
        }
        tableView.reloadData()
    }
}
