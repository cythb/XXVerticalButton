#
# Be sure to run `pod lib lint XXVerticalButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XXVerticalButton'
  s.version          = '0.1.0'
  s.summary          = 'An Vertically aligned iOS button write with Swift.'

  s.description      = <<-DESC
The reason for creating this project is that VerticallyButton seems to be no longer maintained. I submitted the PR, but it was not merged in time. Thanks to VerticallyButton achieve what I needed. So I developed and maintained this project on the basis of VerticallyButton.
                       DESC

  s.homepage         = 'https://github.com/cythb/XXVerticalButton'
  s.screenshots     = 'https://github.com/cythb/XXVerticalButton/raw/master/Screenshots/Screenshots.gif', 'https://github.com/cythb/XXVerticalButton/raw/master/Screenshots/Screenshots.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iHugo' => 'cythbgy@gmail.com' }
  s.source           = { :git => 'https://github.com/cythb/XXVerticalButton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ihugo_cc'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XXVerticalButton/Classes/**/*'
  s.frameworks = 'UIKit'
end
