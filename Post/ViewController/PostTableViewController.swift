//
//  PostTableViewController.swift
//  Post
//
//  Created by Xavier on 10/15/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    
    let postController = PostController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func addPostButtonTapped(_ sender: UIBarButtonItem) {
        presentNewPostAlert()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        PostController.fetchPosts { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        func fetchPosts() {
            PostController.fetchPosts { (_) in
                if self.postController.posts != nil{
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        
        // MARK: - Table view data source
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return postController.posts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
            
            let post = postController.posts[indexPath.row]
            cell.textLabel?.text = post.text
            cell.detailTextLabel?.text = "\(indexPath.row) \(post.timestamp)"
            
            return cell
        }
        
    }
}

extension PostTableViewController {
    
    func presentNewPostAlert() {
        let alertController = UIAlertController(title: "ADD NEW POST", message: "Add your unique post", preferredStyle: .alert)
        let dissMissAction = UIAlertAction(title: "DISSMISS", style: .cancel, handler: nil)
        
        var usernameTextField: UITextField?
        alertController.addTextField { (texfield) in
            usernameTextField?.text = texfield.text
        }
        
        var messageTextField: UITextField?
        alertController.addTextField { (textField) in
            messageTextField = textField
        }
        
        let addPostAction = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let userNameText = usernameTextField?.text, usernameTextField?.text != "",
                let postMessage = messageTextField?.text, messageTextField?.text != "" else { self.presentErrorAlert(); return }
            PostController.addNewPostWith(userName: userNameText, text: postMessage, completion: { (true) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            
            self.tableView.reloadData()
        }
        alertController.addAction(addPostAction)
        alertController.addAction(dissMissAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        // MARK: - Error Alert
        
    }
    
    func presentErrorAlert() {
        let errorAlertController = UIAlertController(title: "Enter in User Name and message", message: "Fill it out", preferredStyle: .alert)
        let dissmissAction = UIAlertAction(title: "Dissmiss", style: .default) { (_) in
            self.presentNewPostAlert()
        }
        
        errorAlertController.addAction(dissmissAction)
        self.present(errorAlertController, animated: true, completion: nil)
    }
}
