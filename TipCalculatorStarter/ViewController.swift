//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
// Xcode > Preferences > Accounts > + > AppleID > Sign in >

import UIKit

class ViewController: UIViewController {
    
    var isDefaultStatusBar = true
    
    //We need to make sure the color of our status bar is updated
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDefaultStatusBar ? .default : .lightContent
    }
    
    //Connecting variables to things in storyboard
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var inputCardView: UIView!
    //This changed because the type of the text field is no longer a UITextField, but rather has the attributes of the BillAmountTextField class
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!

   
    //This happens every time the app loads
    override func viewDidLoad() {
        super.viewDidLoad()
        //We set the calculateButtonAction of the billAmountTextField object to a nameless function
        
        setUpViews()
        setTheme(isDark: false)
        
        billAmountTextField.calculateButtonAction = {
           self.calculate()
        }
    }
    
    //Calculate function
    func calculate() {
        //dismiss keyboard if it's displayed
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder()
        }
        
        guard let billAmountText = self.billAmountTextField.text,
            //This converts billAmounText from a string to a double, the else statement deals with invalid strings
            let billAmount = Double(billAmountText) else {
                clear()
                return
        }
        
        //This rounds the bill amount to two decimal places
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        //Tip Amount
        let tipPercent: Double
        switch tipPercentSegmentedControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15
        case 1:
            tipPercent = 0.18
        case 2:
            tipPercent = 0.20
        default:
            preconditionFailure("Unexpected index.")
        }
        
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        //Total Amount
        let totalAmount = roundedBillAmount + roundedTipAmount
        
        //Update UI
        self.billAmountTextField.text = String(format: "$%.2f", (roundedBillAmount))
       // self.billAmountTextField.text = "$\(roundedBillAmount)"
        self.tipAmountLabel.text = "$\(roundedTipAmount)"
        self.totalAmountLabel.text = "$\(totalAmount)"
    }
    
    //Clear or Reset Function
    func clear() {
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    
    func setUpViews() {
        //Adding a shadow to the bottom of the header view
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        //This gives the input card rounded corners
        inputCardView.layer.cornerRadius = 8
        //This makes our content not appear outside the boundary of the rounded corner
        inputCardView.layer.masksToBounds = true
        
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        
        //This sets a border for the output card
        outputCardView.layer.borderWidth =  1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    func setTheme(isDark: Bool) {
        let theme = isDark ? ColorTheme.dark : ColorTheme.light
        
        view.backgroundColor = theme.viewControllerBackgroundColor
        
        headerView.backgroundColor = theme.primaryColor
        titleLabel.textColor = theme.primaryTextColor
        
        inputCardView.backgroundColor = theme.secondaryColor
        
        billAmountTextField.tintColor = theme.accentColor
        tipPercentSegmentedControl.tintColor = theme.accentColor
        
        outputCardView.backgroundColor = theme.primaryColor
        outputCardView.layer.borderColor = theme.accentColor.cgColor
        
        tipAmountTitleLabel.textColor = theme.primaryTextColor
        totalAmountTitleLabel.textColor = theme.primaryTextColor
        
        tipAmountLabel.textColor = theme.outputTextColor
        totalAmountLabel.textColor = theme.outputTextColor
        
        resetButton.backgroundColor = theme.secondaryColor
        
        isDefaultStatusBar = theme.isDefaultStatusBar
        setNeedsStatusBarAppearanceUpdate()
    }
    
    //This is done when the switch is toggled on and off
    @IBAction func themeToggled(_ sender: UISwitch){
        setTheme(isDark: sender.isOn)
    }
    
    //This activates when the tip percent segmented control is changed
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    //This activates when the reset button is pressed
    @IBAction func resetButtonTapped(_ sender: Any) {
        clear()
    }
    
    
    
}

