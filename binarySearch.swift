//
//  binarySearch.swift
//  This program creates a list of 250 values to test a class that preforms sort and binary search methods
//  This program was edited to search recursively
//
//  Created by Matthew Lourenco on 27/04/18.
//  Copyright © 2018 MTHS. All rights reserved.
//

import Foundation
srand(UInt32(time(nil)))

class BinarySearch {
	
	var unsortedList: [Int] = []
	var sortedList: [Int] = []
	var _min: Int = 0
	var _max: Int = 500
	var _length: Int = 250
	
	var oldPositions: [Int] = []
	var repeats: Double = 1.0
	var _index: Int = -2
	var maxRecursiveChecks: Int = 3
	
	init(length: Int, min: Int, max: Int) {
		//Contructor for setting the size, upper, and lower bounds
		_length = length	
		_min = min
		_max = max
		
		newList()
	}
	
	func newList() {
		//Creates a random list and returns it in string format. The
		//    random list is assigned to the unsortedlist field.
		
		for _ in 0..<_length {
			unsortedList.append(Int(random()%(_max + 1 - _min) + _min))
		}
		sort()
	}
	
	func sort() {
		//Sorts the unsorted list and assigns the result to the sorted list
		var tempList: [Int] = unsortedList
		var index: Int = 0
		for _ in 0..<tempList.count {
			
			index = 0
			for number in 0..<tempList.count {
				if tempList[index] > tempList[number] {
					index = number
				}
			}
			
			sortedList.append(tempList[index])
			tempList.remove(at: index)
		}
	}
	
	func searchBinary(item: Int) {
		// Use a recursive search
		recursiveSearch(item: item, index: Double(sortedList.count / 2))
	}
	
	func checkRecursion(index: Double) -> Bool {
		// Stops the binary search if it is going on for too long
		
		//Allow the program to end the loop if it has to recheck
		//    the same value multiple times.
		if oldPositions.count >= maxRecursiveChecks {
			if oldPositions[oldPositions.count - 1] == oldPositions[oldPositions.count - maxRecursiveChecks] {
				return true
			}
		}
		if Int(round(index)) >= sortedList.count {
			//Break loop if search resorts to checking outside of list
			return true
		}
		return false
	}
	
	func recursiveSearch(item: Int, index: Double) {
		// Uses a recursive binary search to find the inputted item
		if checkRecursion(index: index) {
			_index = -1
		}
		//Check if index is correct
		else if sortedList[Int(round(index))] == item {
			_index = Int(round(index))
		} else if sortedList[Int(round(index))] > item {
			oldPositions.append(Int(round(index)))
			repeats += 1
			let newIndex: Double = index - pow(0.5, repeats) * Double(sortedList.count)
			recursiveSearch(item: item, index: newIndex)
		} else {
			oldPositions.append(Int(round(index)))
			repeats += 1
			let newIndex: Double = index + pow(0.5, repeats) * Double(sortedList.count)
			recursiveSearch(item: item, index: newIndex)
		}
	}

	func getIndex() -> Int { return _index } //Getter
}

//Generate a SearchableList and allow the user to add a number and
//    search for a number.
let list = BinarySearch(length: 20, min: 0, max: 50)
print(list.unsortedList)
print(list.sortedList)

print("Which number would you like to search for?")
let input: String? = readLine(strippingNewline: true)
if Int(input!) != nil {
	let numberToSearch: Int = Int(input!)!
	list.searchBinary(item: numberToSearch)
	let index: Int = list.getIndex()

	if index != -1  {
		print("\(numberToSearch) is located at index = \(index)")
	} else {
		print("\(numberToSearch) is not located in the list")
	}
}