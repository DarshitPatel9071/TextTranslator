
Pod::Spec.new do |spec|

  spec.name         = "TextTranslator"
   spec.version      = "1.0.0"
  spec.summary      = "TEXT_TRANSLATOR_FREE"
  spec.description  = <<-DESC
    TEXT_TRANSLATOR POD FOR FREE OF USE
                   DESC
  spec.homepage     = "https://github.com/DarshitPatel9071/TextTranslator"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Darshit Patel" => "" }
  spec.source       = { :git => "https://github.com/DarshitPatel9071/TextTranslator.git", :tag => "#{spec.version}"}
  spec.source_files  = 'TEXT_TRANSLATOR/**/*.{swift}'
  spec.ios.deployment_target = '12.0'
  spec.swift_versions = "5.0"
  spec.dependency 'GoogleMLKit/Translate', '2.6.0'
  spec.dependency 'MBProgressHUD'
  spec.static_framework = true
end
