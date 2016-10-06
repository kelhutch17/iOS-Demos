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

class DetailViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var weaponImageView: UIImageView!

  var monster: Monster! {
    didSet (newMonster) {
      self.refreshUI()
    }
  }

  func refreshUI() {
    // Add accessibility labels to all of your UI elements as you see fit
    nameLabel?.text = monster.name
    nameLabel?.accessibilityLabel = "Monster name: \(monster.name)"
    
    descriptionLabel?.text = monster.description
    descriptionLabel?.accessibilityLabel = "Monster Description: \(monster.description)"
    
    iconImageView?.image = UIImage(named: monster.iconName)
    iconImageView?.accessibilityLabel = "\(monster.name) icon"
    
    weaponImageView?.image = monster.weaponImage()
    weaponImageView?.accessibilityLabel = "Weapon: \(monster.weapon)"
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    refreshUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension DetailViewController: MonsterSelectionDelegate {
  func monsterSelected(newMonster: Monster) {
    monster = newMonster
  }
}
