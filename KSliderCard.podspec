Pod::Spec.new do |s|

s.name         = "KSliderCard"
s.version      = "1.0"
s.summary      = "Basic, animatable iOS slider card"
s.description  = <<-DESC
Basic, animatable iOS slider card
DESC
s.homepage     = "https://github.com/KenanAtmaca/KSliderCard"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "KenanAtmaca" => "mail.kenanatmaca@gmail.com" }
s.social_media_url   = "https://twitter.com/uikenan"

s.platform     = :ios, "11.0"
s.requires_arc = true
s.ios.deployment_target = "11.0"

s.source       = { :git => "https://github.com/KenanAtmaca/KSliderCard", :tag => "#{s.version}" }
s.source_files  = "KSliderCard", "KSliderCard/**/*.{h,m,swift}"
s.swift_version = '4.2'
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2'}
end
