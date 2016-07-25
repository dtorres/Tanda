Spec.new do |s|
  s.name         = "Tanda"
  s.version      = "0.0.1"
  s.summary      = "Swift version of BatchedHandlers"
  s.description  = <<-DESC
                    This library stores objects for you until you are ready to deal with them as a batch
                   DESC

  s.homepage     = "https://github.com/dtorres/Tanda"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author	     = { "Diego Torres" => "contact@dtorres.me" }

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/dtorres/Tanda.git", :tag => s.version.to_s }
  s.source_files = "Classes/*.swift"

end
