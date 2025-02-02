//
//  ItemStore.swift
//  LootLogger
//
//  Created by Yousef Albalawi on 11/04/1443 AH.
//


import UIKit

class ItemStore  {
  
  init() {
      do {
          let data = try Data(contentsOf: itemArchiveURL)
          let unarchiver = PropertyListDecoder()
          let items = try unarchiver.decode([Item].self, from: data)
          allItems = items
  } catch {
          print("Error reading in saved items: \(error)")
      }
  }
  
  var allItems = [Item]()
  let itemArchiveURL: URL = {
    let documentsDirectories =
      FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("items.plist")
  }()
  
  @discardableResult func createItem() -> Item {
    
    let newItem = Item(random: true)
    allItems.append(newItem)
    return newItem
  }
  
  //  init() {
  //    for _ in 0..<5 {
  //      createItem()
  //    }
  //  }
  
  func removeItem(_ item: Item) {
    if let index = allItems.firstIndex(of: item) {
      allItems.remove(at: index)
    }
  }
  func moveItem(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return }
    // Get reference to object being moved so you can reinsert it
    let movedItem = allItems[fromIndex]
    // Remove item from array
    allItems.remove(at: fromIndex)
    // Insert item in array at new location
    allItems.insert(movedItem, at: toIndex)
  }
  
  
   func saveChanges() {
    print("Saving items to: \(itemArchiveURL)")
    do {
      let encoder = PropertyListEncoder()
      let data = try encoder.encode(allItems)
      try data.write(to: itemArchiveURL, options: [.atomic])
      print("Saved all of the items")
    } catch let encodingError {
      print("Error encoding allItems: \(encodingError)")
    }
    }
  
  @objc func loadChanges()
  {
      do
      {
          let data = try Data(contentsOf: itemArchiveURL)
          let unarchiver = PropertyListDecoder()
          let items = try unarchiver.decode([Item].self, from: data)
          allItems = items
      }
      catch
      {
          print("Error reading in saved items: \(error)")
      }
  }
  
  }


