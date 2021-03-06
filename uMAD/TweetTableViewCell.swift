import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var header: UILabel!
    @IBOutlet var tweetText: UILabel!
    @IBOutlet var tweetImage: UIImageView!
    @IBOutlet var imageHeight: NSLayoutConstraint!

    static let dateComponentsFormatter: NSDateComponentsFormatter = {
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = .Abbreviated
        return formatter
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        userProfileImageView.layer.cornerRadius = 4
        tweetImage.layer.cornerRadius = 4
    }

    func configure(tweet: Tweet){
        let timeSince = timeSinceString(tweet.createdAt)
        let attributedHeader = NSMutableAttributedString(string: "\(tweet.user.name) @\(tweet.user.screenName)\t\(timeSince)")
        let userNameRange = NSMakeRange(0, count(tweet.user.name))

        //Plus one to account for the @
        let screenNameRange = NSMakeRange(userNameRange.location + userNameRange.length + 1, count(tweet.user.screenName) + 1)

        //Plus one to account for the tab
        let timeSinceRange = NSMakeRange(screenNameRange.length + screenNameRange.location, count(timeSince) + 1)
        let screenNameAndTimeSinceRange = NSMakeRange(screenNameRange.location, screenNameRange.length + timeSinceRange.length)
        attributedHeader.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: screenNameAndTimeSinceRange)
        attributedHeader.addAttribute(NSForegroundColorAttributeName, value: UIColor.lightGrayColor(), range: screenNameAndTimeSinceRange)

        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .Left
        let leftTab = NSTextTab(textAlignment: .Left, location: 0.0, options: nil)
        let rightTab = NSTextTab(textAlignment: .Right, location: 240.0, options: nil)
        paragraphStyle.tabStops = [leftTab,rightTab]

        attributedHeader.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedHeader.length))

        header.attributedText = attributedHeader

        let modifiedTweetText = NSMutableAttributedString(string: tweet.text)
        for (url, range) in tweet.images {
            let replacementString = String(count: range.length, repeatedValue: Character("\0"))
            modifiedTweetText.replaceCharactersInRange(range, withAttributedString: NSAttributedString(string: replacementString))
        }
        tweetText.attributedText = modifiedTweetText
    }

    private func timeSinceString(date: NSDate) -> String{
        let recentUnitFlags: NSCalendarUnit = .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond
        var dateComponents = NSCalendar.autoupdatingCurrentCalendar().components(.CalendarUnitDay, fromDate: date, toDate: NSDate(), options: nil)
        if dateComponents.day == 0 {
            dateComponents = NSCalendar.autoupdatingCurrentCalendar().components(recentUnitFlags, fromDate: date, toDate: NSDate(), options: nil)

        }

        return "\(TweetTableViewCell.dateComponentsFormatter.stringFromDateComponents(dateComponents)!)"
        
    }

    override func prepareForReuse() {
        tweetImage.image = nil
        tweetImage.hidden = true
        userProfileImageView.image = nil
        imageHeight.constant = 0
    }
    
}