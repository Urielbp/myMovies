//
//  AppDelegate.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        //TODO: Save shared data into json files
        let documentsFolderURL = documentsURL()
        let encoder = JSONEncoder()
        
        let localFiles = listOfSandboxFilesIn(directory: documentsFolderURL, withExtension: "json")
        if (localFiles.filter {$0.lastPathComponent == "movies.json"}.count == 0) {
            let localMoviesJsonURL = documentsFolderURL.appendingPathComponent("movies.json")
            do {
                let moviesJsonData = try encoder.encode(MoviesList.shared)
                try moviesJsonData.write(to: localMoviesJsonURL)
                //print("DEBUG>>Saving App data to local movie.json")
            }
            catch {
                print("Error writing to local movies.json")
                print(error)
            }
        }
        
        if (localFiles.filter {$0.lastPathComponent == "actors.json"}.count == 0) {
            let localActorsJsonURL = documentsFolderURL.appendingPathComponent("actors.json")
            do {
                let actorsJsonData = try encoder.encode(ActorsList.shared)
                try actorsJsonData.write(to: localActorsJsonURL)
                //print("DEBUG>>Saving App data to local actors.json")
            }
            catch {
                print("Error writing to local actors.json")
                print(error)
            }
        }
        
        if (localFiles.filter {$0.lastPathComponent == "directors.json"}.count == 0) {
            let localDirectorsJsonURL = documentsFolderURL.appendingPathComponent("directors.json")
            do {
                let directorsJsonData = try encoder.encode(DirectorsList.shared)
                try directorsJsonData.write(to: localDirectorsJsonURL)
                //print("DEBUG>>Saving App data to local directors.json")
            }
            catch {
                print("Error writing to local directors.json")
                print(error)
            }
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

