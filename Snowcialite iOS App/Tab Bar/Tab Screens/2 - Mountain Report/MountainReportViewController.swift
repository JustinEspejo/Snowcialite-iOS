//
//  Created by Justin Espejo on 11/12/15.
//  Copyright © 2016 Snowcialite. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MountainReportViewController: UIViewController, UITextFieldDelegate
{
    //storyboard reference variables
    @IBOutlet weak var getCurrentTempButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var snowLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var viewLabel: UIView!
    //class variables
    var weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        cityTextField.delegate = self
        getWeatherData()
        viewLabel.layer.cornerRadius = 4
        viewLabel.clipsToBounds = true
    }

    func getWeatherData() {
        Alamofire.request(.GET, weatherBaseURL, parameters: ["q": self.cityTextField.text!, "APPID": "6be1b1956ac65ae6ed8ac3fa17402547", "units": "imperial"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("nice internet ☺️")
                    let json = JSON(response.result.value!)
                    let a = round(json["main"]["temp"].floatValue).description
                    print(a + " json success")
                    self.cityLabel.text = json["name"].stringValue
                    self.cityTemperatureLabel.text = round(json["main"]["temp"].floatValue).description + "° F"
                    self.descriptionLabel.text = json["weather"]["description"].stringValue //description is currently not displaying because of API provider
                    self.windLabel.text = round(json["wind"]["speed"].floatValue).description + "mph"
                    self.snowLabel.text = json["rain"]["rain.3h"].stringValue + " inches" //snow is currently not displaying because of API provider
                    self.pressureLabel.text = round(json["main"]["pressure"].floatValue).description + "hPa"
                    self.humidityLabel.text = json["main"]["humidity"].stringValue + "%"
                case .Failure(let error):
                    print(error)
                    switch error.code
                        {
                        case NSURLErrorNotConnectedToInternet:
                        print("No internet, get fios 😷")
                        default:
                        print("its not your internet bro")
                    }
                }
        }
    }

    //this function is for hiding the keyboard text when we click outside the textfield
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func getCurrentTempButtonTapped(sender: AnyObject)
    {
        getWeatherData()
        self.cityTextField.resignFirstResponder() //Unclicks the keyboard
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        dispatch_async(dispatch_get_main_queue(),
        {
            self.getWeatherData()
        })
        return true
    }
}

