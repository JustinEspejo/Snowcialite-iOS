

import UIKit
import Parse

class NewsFeedViewController: UIViewController
    
{
    //storyboard reference variables
    @IBOutlet weak var logOutDidTap: UIBarButtonItem!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postStatusTextField: UITextField!
    //@IBOutlet weak var userProfileImageButton: UIbutton!
    
    //test newsfeed
    private var testNewsFeed = newsFeedTest.createNewsFeed()
    
    
    //struct is like making a data object with variables already
    struct Storyboard
    {
        //this is the identifier that i fuckin put in the fuckin storyboard shit
        static let showLoginSegue = "Show Login"
        static let showNextScreen = "showNextScreen"
        static let cellIdentifier = "Newsfeed Cell"
        
    }
    
    
    
    @IBAction func logOutDidTap(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier(Storyboard.showLoginSegue, sender: nil)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }


    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //if no user pop this shit up (login)
        if PFUser.currentUser() == nil
        {
            
         performSegueWithIdentifier(Storyboard.showLoginSegue, sender: nil)
        
        }
        
        profilePicButton.layer.cornerRadius = profilePicButton.frame.size.width/2
        profilePicButton.clipsToBounds = true
        
        postButton.layer.cornerRadius = postButton.frame.size.width/2
        postButton.clipsToBounds = true
        
        
    }
    
    //prepare for the next segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {

        if segue.identifier == Storyboard.showLoginSegue {
            let loginSignupVC = segue.destinationViewController as! LoginSignupViewController
            loginSignupVC.hidesBottomBarWhenPushed = true
            loginSignupVC.navigationItem.hidesBackButton = true
       
        }
    
    }

}

extension NewsFeedViewController: UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return testNewsFeed.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.cellIdentifier, forIndexPath: indexPath) as! newsFeedCollectionViewCell
        
        cell.newsFeed = testNewsFeed[indexPath.item]
        
        
        return cell
    }
    
    
}
