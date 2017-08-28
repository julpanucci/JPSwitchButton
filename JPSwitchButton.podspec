#
# Be sure to run `pod lib lint JPSwitchButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JPSwitchButton'
  s.version          = '0.1.0'
  s.summary          = 'Interactive button that can toggle into a fluid and animated looking on and off state'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Use this button to toggle different features of your app. Example: Linking your twitter account to show if it is linked or not. Allowing access to contacts/photos, etc.
                       DESC

  s.homepage         = 'https://github.com/julp04/JPSwitchButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'julp04' => 'julpanucci@gmail.com' }
  s.source           = { :git => 'https://github.com/julp04/JPSwitchButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JPSwitchButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JPSwitchButton' => ['JPSwitchButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
