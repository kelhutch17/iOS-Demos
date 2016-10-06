//
//  ViewController.swift
//  i18n+l10n
//
//  Created by Hutchison, Kelly on 10/4/16.
//  Copyright © 2016 Hutchison, Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfMilesLabel: UILabel!
    @IBOutlet weak var dollarValueLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var niceFlightImageView: UIImageView!
    @IBOutlet weak var preferredAirportLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        populateDefaultLabels()
    }

    func populateDefaultLabels() {
        nameLabel.text = NSLocalizedString("FLYER_NAME_KEY", comment: "Name of the frequent flyer")
        niceFlightImageView.image = UIImage(named: NSLocalizedString("NICE_FLIGHT_IMAGE_KEY", comment: "Name of the flight image"))
        
        numberOfMilesLabel.text = numberFormatter.stringFromNumber(25000)
        dollarValueLabel.text = currencyFormatter.stringFromNumber(500)
        
        // Date
        let numberOfDays = 730 // 2 years from today
        let calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: numberOfDays, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        // Make the expiration date 2 years from today
        let dateAsString = dateFormatter.stringFromDate(calculatedDate!)
        
        expirationDateLabel.text = dateAsString
    }

    // Create formatters - They will localize automatically
    var numberFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter
    }
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }
    
    var dateFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .MediumStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter
    }

}

