#
# Be sure to run `pod lib lint LWKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LWKeyboard'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LWKeyboard.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LW0916/LWKeyboard'
  s.screenshots = [
  'https://raw.github.com/mwaterfall/MWPhotoBrowser/master/Screenshots/MWPhotoBrowser1.png',
  'https://raw.github.com/mwaterfall/MWPhotoBrowser/master/Screenshots/MWPhotoBrowser2.png',
  'https://raw.github.com/mwaterfall/MWPhotoBrowser/master/Screenshots/MWPhotoBrowser3.png'
  ]
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zglinwei_0916@163.com' => 'zglinwei_0916@163.com' }
  s.source           = { :git => 'https://github.com/LW0916/LWKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LWKeyboard/Classes/**/*'
  # s.resources = 'LWKeyboard/Assets/LWKeyboard.bundle'
  
  s.resource_bundles = {
    'LWKeyboard' => ['LWKeyboard/Assets/*']
   }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
