
Pod::Spec.new do |s|
 

  s.name         = "LYTrendView"
  s.version      = "1.3.0"
  s.summary      = "an iOS chart and column view"
  s.description  = "a simple Chart  line (column 、 pie) view for iOS. (简单的iOS柱状、曲线图图、饼图)"

  s.homepage     = "https://github.com/install-b"
  
  s.license      = "MIT"

  s.author       = { "ShangenZhang" => "gkzhangshangen@163.com" }

  s.platform     = :ios, "8.0"
  s.requires_arc = true


  s.source       = { :git => "https://github.com/install-b/LYTrendView.git", :tag => s.version }
  s.source_files  =  "Classes/**/*.{h,m,c}"
  s.public_header_files = "Classes/**/*.{h}"

end
