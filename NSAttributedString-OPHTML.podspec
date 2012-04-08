Pod::Spec.new do |s|
  s.name     = 'NSAttributedString+OPHTML'
  s.version  = '0.1'
  s.license  = 'MIT'
  
  s.summary       = 'NSAttributedString+OPHTML'
  s.homepage      = 'https://github.com/mbrandonw/NSAttributedString-OPHTML'
  s.author        = { 'Brandon Williams' => 'brandon@opetopic.com' }
  s.source        = { :git => 'git@github.com:mbrandonw/NSAttributedString-OPHTML.git' }
  s.requires_arc  = true
  
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  
  s.frameworks = 'CoreText'

  s.dependency do |p|
    p.name = 'Objective-C-HMTL-Parser'
    p.source = { :git => 'https://github.com/zootreeves/Objective-C-HMTL-Parser.git' }
    p.source_files = '*.{h,m}'
    p.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  end
  
end