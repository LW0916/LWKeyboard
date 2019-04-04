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
  s.summary          = '安全键盘'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LW0916/LWKeyboard'
  # s.screenshots = [
  # 'https://github.com/LW0916/LWKeyboard/blob/master/Screenshots/LWKeyboard1.png',
  # 'https://github.com/LW0916/LWKeyboard/blob/master/Screenshots/LWKeyboard2.png',
  # 'https://github.com/LW0916/LWKeyboard/blob/master/Screenshots/LWKeyboard3.png'
  # ]
  
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LW0916' => 'zglinwei_0916@163.com' }
  s.source           = { :git => 'https://github.com/LW0916/LWKeyboard.git', :tag => s.version.to_s }

  # s.social_media_url = 'https://github.com/LW0916'
  s.ios.deployment_target = '8.0'

  s.source_files = 'LWKeyboard/Classes/**/*'
  # s.resources = 'LWKeyboard/Assets/LWKeyboard.bundle'
  
  s.resource_bundles = {
    'LWKeyboard' => ['LWKeyboard/Assets/*']
   }
  s.requires_arc = true
  s.public_header_files = 'LWKeyboard/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
