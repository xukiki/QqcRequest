Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcRequest"
  s.version      = "1.0.14"
  s.summary      = "QqcRequest"
  s.homepage     = "https://github.com/xukiki/QqcRequest"
  s.source       = { :git => "https://github.com/xukiki/QqcRequest.git", :tag => "#{s.version}" }
  
  s.subspec 'Request' do |ss|
    ss.source_files = 'QqcRequest/QqcRequest.{h,m}'
  end

  s.subspec 'Common' do |ss|
    ss.source_files = 'QqcRequest/QqcError.{h,m}'
  end

  s.subspec 'Model' do |ss|
    ss.subspec 'DataModel' do |sss|
      sss.source_files = 'QqcRequest/QqcDataModel.{h,m}','QqcRequest/QqcJsonResultModel.{h,m}'
    end
    ss.subspec 'ParamModel' do |sss|
      sss.source_files = 'QqcRequest/QqcParamModel.{h,m}','QqcRequest/QqcParamPostFile.{h,m}'
    end
  end

  s.subspec 'ActionProcessor' do |ss|
    ss.source_files = 'QqcRequest/QqcBaseActionProcessor.{h,m}','QqcRequest/QqcGetActionProcessor.{h,m}','QqcRequest/QqcPostActionProcessor.{h,m}'
  end

  s.dependency "YTKNetwork"
  s.dependency "QqcBaseModel"
  s.dependency "QqcLog"
  s.dependency "QqcComFuncDef"
  s.dependency "Json-Qqc"

end
