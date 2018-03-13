
Pod::Spec.new do |s|
 

  s.name         = "LYTrendView"
  s.version      = "1.0.0"
  s.summary      = "an iOS chart and column view"
  s.description  = "a simple Chart line and column view for iOS. (简单的iOS柱状和曲线图)"

  s.homepage     = "https://github.com/install-b"
  
  s.license      = "MIT"

  s.author       = { "ShangenZhang" => "645256685@qq.com" }

  s.platform     = :ios
  s.requires_arc = true


  s.source       = { :git => "https://github.com/install-b/LYTrendView.git", :tag => s.version }
  s.source_files  =  "Classes/**/*.{h,m,c}"
  s.public_header_files = "Classes/**/*.{h}"

end
