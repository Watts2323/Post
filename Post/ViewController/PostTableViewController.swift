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
//        presentAlertController()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
//        PostController.fetchPosts { (post) in
//            if post{
//                DispatchQueue.main
//            }
//        }
    }
    
    
    func fetchPosts() {
//        PostController.fetchPosts { (success) in
//            if success{
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }else {
//                DispatchQueue.main.async {
//                    self.title = "There was an error fetching your title"
//                }
//            }
//        }
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postController.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = postController.posts[indexPath.row]
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(indexPath.row) \(post.timestamp)"

        return cell
    }

}
