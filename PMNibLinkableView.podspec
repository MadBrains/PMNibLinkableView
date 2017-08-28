#
# Be sure to run `pod lib lint PMNibLinkableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PMNibLinkableView'
  s.version          = '0.3.0'
  s.summary          = 'PMNibLinkableView gives view described in separate xib ability to be loaded in other xib or storyboard without creating it manually in code'
  s.description      = <<-DESC
PMNibLinkableView gives view described in separate xib ability to be loaded in other xib or storyboard without creating it manually in code.
                       DESC

  s.homepage         = 'https://github.com/MadBrains/PMNibLinkableView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antol' => 'antol.peshkov@gmail.com' }
  s.source           = { :git => 'https://github.com/MadBrains/PMNibLinkableView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AntolPeshkov'

  s.ios.deployment_target = '7.0'

  s.source_files = 'PMNibLinkableView/Classes/**/*'
end
