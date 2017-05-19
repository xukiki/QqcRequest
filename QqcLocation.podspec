Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcLocation"
  s.version      = "1.0.106"
  s.summary      = "QqcLocation"
  s.homepage     = "https://github.com/xukiki/QqcLocation"
  s.source       = { :git => "https://github.com/xukiki/QqcLocation.git", :tag => "#{s.version}" }
  
  s.subspec 'Request' do |ss|
    ss.source_files = 'QqcRequest/Request/*.{h,m}'
  end

  s.subspec 'Common' do |ss|
    ss.source_files = 'QqcRequest/Common/*.{h,m}'
  end

  s.subspec 'ActionProcessor' do |ss|
    ss.source_files = 'QqcRequest/ActionProcessor/*.{h,m}'
  end

  s.subspec 'Model' do |ss|
    ss.subspec 'DataModel' do |sss|
      sss.source_files = 'QqcRequest/Model/DataModel/*.{h,m}'
    end
    ss.subspec 'ParamModel' do |sss|
      sss.source_files = 'QqcRequest/Model/ParamModel/*.{h,m}'
    end
  end

  s.dependency "YTKNetwork"

end
