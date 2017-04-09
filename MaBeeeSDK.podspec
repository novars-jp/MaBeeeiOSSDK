Pod::Spec.new do |s|
  s.name = 'MaBeeeSDK'
  s.version = '1.5.0'
  s.summary = 'MaBeee SDK for iOS.'
  s.description = 'Official MaBeee SDK for iOS.'
  s.homepage = 'http://developer.novars.jp/'
  s.license = {
    :type => 'Copyright',
    :text => 'Copyright 2017 Novars Inc.'
  }
  s.author = 'Novars Inc.'
  s.platform = :ios

  s.source = { 
    :git => 'https://github.com/novars-jp/MaBeeeiOSSDK.git', 
    :commit => '0514d29f155fb71331b1e95158a3e7706d6bc9e8'
    # FIXME: Should use :tag instead of :commit.
    # See the result of following command: `pod spec lint MaBeeeSDK.podspec`
    #  (It says 'WARN  | source: Git sources should specify a tag.')
    # :tag => 'v1.5.0' 
  }
  s.platform = :ios
  s.ios.deployment_target = '8.0'

  framework_path = 'MaBeeeSDK.framework'

  s.source_files = "#{framework_path}/Headers/*.h"
  s.module_map = "#{framework_path}/Modules/module.modulemap"

  s.preserve_paths = framework_path
  s.header_dir = 'MaBeeeSDK'

  s.vendored_frameworks = 'MaBeeeSDK.framework'

  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/MaBeeeSDK"' }
end

