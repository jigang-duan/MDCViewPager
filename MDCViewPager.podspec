#
# Be sure to run `pod lib lint MDCViewPager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MDCViewPager'
  s.version          = '0.2.0'
  s.summary          = 'A simple view pager for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple view pager for Swift. Compatible with iOS 8.0 or later.
                       DESC

  s.homepage         = 'https://github.com/jigang-duan/MDCViewPager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jigang-duan' => 'djg4055108@126.com' }
  s.source           = { :git => 'https://github.com/jigang-duan/MDCViewPager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.default_subspec = "Core"

  s.ios.deployment_target = '8.0'
  
  s.subspec "Core" do |ss|
      ss.source_files = 'MDCViewPager/Classes/**/*'
      ss.dependency 'MaterialComponents/PageControl', '~> 44.3'
      ss.dependency 'MaterialComponents/Ink', '~> 44.3'
      ss.dependency 'Kingfisher', '~> 4.6'
      ss.frameworks = 'UIKit'
      ss.resource_bundles = {
         'MDCViewPager' => ['MDCViewPager/Assets/*.png']
      }
  end
  
  s.subspec "RxSwift" do |ss|
      ss.source_files = 'MDCViewPager/RxSwift/**/*'
      ss.dependency 'MDCViewPager/Core'
      ss.dependency 'RxCocoa', '~> 4.0'
  end
  
end
