Pod::Spec.new do |s|

  s.license      = "MIT"
  s.author       = { "qqc" => "20599378@qq.com" }
  s.platform     = :ios, "8.0"
  s.requires_arc  = true

  s.name         = "QqcRequest"
  s.version      = "1.0.38"
  s.summary      = "QqcRequest"
  s.homepage     = "https://github.com/xukiki/QqcRequest"
  s.source       = { :git => "https://github.com/xukiki/QqcRequest.git", :tag => "#{s.version}" }
  
  s.source_files = 'QqcRequest/*.{h,m}'

  #s.subspec 'Request' do |ss|
  #  ss.source_files = 'QqcRequest/QqcRequest.{h,m}'
  #  ss.public_header_files = 'QqcRequest/QqcRequest.h'
  #end

  #s.subspec 'Common' do |ss|
  #  ss.source_files = 'QqcRequest/QqcError.{h,m}'
  #  ss.public_header_files = 'QqcRequest/QqcError.h'
  #end

  #s.subspec 'Model' do |ss|
  #  ss.subspec 'DataModel' do |sss|
  #    sss.source_files = 'QqcRequest/QqcDataModel.{h,m}','QqcRequest/QqcJsonResultModel.{h,m}'
  #    sss.public_header_files = 'QqcRequest/QqcDataModel.h','QqcRequest/QqcJsonResultModel.h'
  #  end
  #  ss.subspec 'ParamModel' do |sss|
  #    sss.source_files = 'QqcRequest/QqcParamModel.{h,m}','QqcRequest/QqcParamPostFile.{h,m}'
  #    sss.public_header_files = 'QqcRequest/QqcParamModel.h','QqcRequest/QqcParamPostFile.h'
  #  end
  #end

  #s.subspec 'ActionProcessor' do |ss|
  #  ss.source_files = 'QqcRequest/QqcBaseActionProcessor.{h,m}','QqcRequest/QqcGetActionProcessor.{h,m}','QqcRequest/QqcPostActionProcessor.{h,m}'
  #  ss.public_header_files = 'QqcRequest/QqcBaseActionProcessor.h','QqcRequest/QqcGetActionProcessor.h','QqcRequest/QqcPostActionProcessor.h'
  #end

  s.dependency "YTKNetwork", "~>1.3.0"
  s.dependency "QqcBaseModel"
  s.dependency "QqcLog"
  s.dependency "QqcComFuncDef"
  s.dependency "Json-Qqc"

end
