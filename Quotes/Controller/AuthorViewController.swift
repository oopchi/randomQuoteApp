//
//  AuthorViewController.swift
//  Author
//
//  Created by Calvin Alfrido on 16/12/21.
//

import UIKit

class AuthorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var authors: Author?
    var selectedAuthor: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
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
        if let authorLoaded = authors?.authors {
            cell.textLabel?.text = authorLoaded[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors?.authors.count ?? 0
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
