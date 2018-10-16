//
//  PostController.swift
//  Post
//
//  Created by Xavier on 10/15/18.
//  Copyright © 2018 Xavier ios dev. All rights reserved.
//

import Foundation

class PostController {
    
    //Shared Function, dont neeed to do this because there will be only one view controller, but it's good to get in the habbit
    //    static let sharedInstance: PostController()
    
//    //Source of truth
    var posts: [Post] = []
    
    static let baseURL = URL(string: "https://devmtn-posts.firebaseio.com/posts")
    
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        
        // Step 1 - construct the URL
        guard var url = baseURL else { completion([]) ; return}
        let getterEndPoint = url.appendingPathExtension("json")
        print("getter Endpoint")
        
        // Step 2 - Create the URLRequest
        var request = URLRequest(url: getterEndPoint)
        //This is "GET" because we are only getiing from the server.
        request.httpMethod = "GET"
        //This is nil because we are not posting anything to the server
        request.httpBody = nil
        
        // Step 3 - Data task + RESUME
        //This method will make the network call and call the completion closer with the data, URLResponse, and a error
         URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            //Checking for the error and if there is one then we will Handle it. Also we are using if let because we dont want to jump out the function if the error is nil
            if let error = error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                completion([])
            }
            guard let data = data else {completion([]); return}
            let decoder = JSONDecoder()
            do{
                let postDictionary = try decoder.decode([String : Post].self, from: data)
                var posts = [Post]()
                
                for (_, value) in postDictionary {
                    posts.append(value)
                }
                
                completion(posts)
                
            } catch let error {
                print("There was an error in \(#function) ; \(error) ; \(error.localizedDescription) ")
                
            }
            
            
            
            
            //Cant forget this or the network call wont work.
            }.resume()
    }
    
}
