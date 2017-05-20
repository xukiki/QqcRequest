Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcRequest"
  s.version      = "1.0.6"
  s.summary      = "QqcRequest"
  s.homepage     = "https://github.com/xukiki/QqcRequest"
  s.source       = { :git => "https://github.com/xukiki/QqcRequest.git", :tag => "#{s.version}" }
  
  s.subspec 'Request' do |ss|
    ss.source_files = 'Request/*.{h,m}'
  end

  s.subspec 'Common' do |ss|
    ss.source_files = 'Common/*.{h,m}'
  end

  s.subspec 'ActionProcessor' do |ss|
    ss.source_files = 'ActionProcessor/*.{h,m}'
  end

  s.subspec 'Model' do |ss|
    ss.subspec 'DataModel' do |sss|
      sss.source_files = 'Model/DataModel/*.{h,m}'
    end
    ss.subspec 'ParamModel' do |sss|
      sss.source_files = 'Model/ParamModel/*.{h,m}'
    end
  end

  s.dependency "YTKNetwork"
  s.dependency "QqcBaseModel"
  s.dependency "QqcLog"
  s.dependency "QqcComFuncDef"
  s.dependency "Json-Qqc"

end
