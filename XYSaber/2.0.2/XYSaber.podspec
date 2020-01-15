Pod::Spec.new do |s|

  s.name         = "XYSaber"
  s.version      = "2.0.2"
  s.summary      = "XYSaber"
  s.description  = <<-DESC
                        XYSaber,多功能盒子
                      DESC

  s.homepage        = "https://github.com/apelxy/XYSaber.git"
  s.author          = { "lxy" => "apelxy@live.com" }
  s.platform        = :ios, "9.0"
  s.source          = { :git => "https://github.com/apelxy/XYSaber.git", :tag => s.version }
  s.source_files    = "XYSaber/*.{h,m}"
  s.source_files    = "XYSaber/**/*.{h,m}"
  s.public_header_files    = "XYSaber/*.h"
  s.public_header_files    = "XYSaber/**/*.h"
  s.framework       = "UIKit"
  #s.dependency "AFNetworking", "~> 3.0"
  s.license= "Copyright (c) 2019年 LXY. All rights reserved."

end
