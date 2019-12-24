Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '13.0'
s.name = "CombineLocalizer"
s.summary = "CombineLocalizer allows you to localize your app with Combine."
s.requires_arc = true
s.version = "1.0.1"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Vladislav Khambir" => "vlad.khambir@gmail.com" }
s.homepage = "https://github.com/khambir/CombineLocalizer"
s.source = { :git => "https://github.com/khambir/CombineLocalizer", :tag => "#{s.version}" }
s.source_files = 'Source/*.swift'
s.swift_version = "5.0"

end
