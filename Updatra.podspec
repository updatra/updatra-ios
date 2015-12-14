#
# Be sure to run `pod lib lint Updatra.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Updatra"
  s.version          = "0.1.5"
  s.summary          = "iOS library for easy integration and use of Updatra, the notification platform. Easily send smart notifications."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  Send smart notifications with Updatra. It's easy to send smart notificatinos and easy engage users. iOS library for easy integration and use of Updatra, the notification platform. Easily send smart notifications.
                       DESC

  s.homepage         = "https://github.com/updatra/updatra-ios"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Michael Seid" => "mike@updatra.com" }
  s.source           = { :git => "https://github.com/updatra/updatra-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/updatra'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Updatra' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 3.0'
  s.dependency 'SwiftyJSON', '~> 2.3.2'
end
