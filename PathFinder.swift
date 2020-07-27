//
//  PathFinder.swift
//  SCAVHUNT
//
//  Created by sahil.khanna on 7/22/20.
//  Copyright © 2020 sahil.khanna. All rights reserved.
//

import Foundation

private class Place {
    var name: String!;
    var previousPlace: Place?;
    var nextPlace: Place?;
    
    init(name: String) {
        self.name = name;
    }
    
    func path() -> [String] {
        var path: [String] = [];
        var currentPlace: Place? = self;
        
        while (currentPlace?.nextPlace != nil) {
            path.append(currentPlace!.name);
            currentPlace = currentPlace!.nextPlace;
        }
        
        path.append(currentPlace!.name);
        
        return path;
    }
}

class PathFinder {
    
    private static func mapPlaces(paths: [String]) -> [String] {
        var firstPlace: Place!;
        var places: [String: Place] = [:];
        for path in paths {
            let delimited = path.components(separatedBy: " ");
            
            if (places[delimited.first!] == nil) {
                places[delimited.first!] = Place(name: delimited.first!);
            }
            
            if (places[delimited.last!] == nil) {
                places[delimited.last!] = Place(name: delimited.last!);
            }
            
            places[delimited.first!]?.nextPlace = places[delimited.last!];
            places[delimited.last!]?.previousPlace = places[delimited.first!];
            
            if (places[delimited.first!]?.previousPlace == nil) {
                firstPlace = places[delimited.first!];
            }
        }
        
        return firstPlace.path();
    }
    
    static func executeTest(_ input: [Any]) {
        var currentIndex = 1;
        var scenario = 0;
        var results: [String] = [];
        
        while (currentIndex < input.count) {
            let placesCount = input[currentIndex] as! Int;
            
            var paths: [String] = [];
            for i in currentIndex + 1...currentIndex + placesCount - 1 {
                paths.append(input[i] as! String);
            }
            currentIndex += placesCount;
            
            let orderedPath = mapPlaces(paths: paths);
            scenario += 1;
            results.append("Scenario #\(scenario):\n\(orderedPath.map {$0}.joined(separator: "\n"))");
        }
        
        print(results.joined(separator: "\n\n"))
    }
}
