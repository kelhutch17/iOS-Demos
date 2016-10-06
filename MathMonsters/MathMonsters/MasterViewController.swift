/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

protocol MonsterSelectionDelegate: class {
  func monsterSelected(newMonster: Monster)
}

class MasterViewController: UITableViewController {
  var monsters = [Monster]()
  weak var delegate: MonsterSelectionDelegate?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.monsters.append(Monster(name: "Cat-Bot", description: "MEE-OW",
      iconName: "meetcatbot.png", weapon: Weapon.Sword))
    self.monsters.append(Monster(name: "Dog-Bot", description: "BOW-WOW",
      iconName: "meetdogbot.png", weapon: Weapon.Blowgun))
    self.monsters.append(Monster(name: "Explode-Bot", description: "BOOM!",
      iconName: "meetexplodebot.png", weapon: Weapon.Smoke))
    self.monsters.append(Monster(name: "Fire-Bot", description: "Will Make You Stamed",
      iconName: "meetfirebot.png", weapon: Weapon.NinjaStar))
    self.monsters.append(Monster(name: "Ice-Bot", description: "Has A Chilling Effect",
      iconName: "meeticebot.png", weapon: Weapon.Fire))
    self.monsters.append(Monster(name: "Mini-Tomato-Bot", description: "Extremely Handsome",
      iconName: "meetminitomatobot.png", weapon: Weapon.NinjaStar))
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Select Monster"

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return self.monsters.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

    let monster = self.monsters[indexPath.row]
    cell.textLabel?.text = monster.name
    // Add accessibility labels and hints to make VoiceOver more useful in your app
    cell.textLabel?.accessibilityLabel = "\(monster.name)"

    cell.accessibilityHint = "Click to show details about \(monster.name)."
    
    return cell
  }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let selectedMonster = self.monsters[indexPath.row]
    self.delegate?.monsterSelected(selectedMonster)

    if let detailViewController = self.delegate as? DetailViewController {
      splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
    }
  }

}
