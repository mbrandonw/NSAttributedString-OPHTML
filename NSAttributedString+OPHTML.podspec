Pod::Spec.new do |spec|
  spec.name         = 'NSAttributedString+OPHTML'
  spec.version      = '0.1.0'
  spec.license      = { type: 'BSD' }
  spec.homepage     = 'https://github.com/mbrandonw/NSAttributedString-OPHTML'
  spec.authors      = { 'Brandon Williams' => 'mbw234@gmail.com' }
  spec.summary      = ''
  spec.source       = { :git => 'https://github.com/mbrandonw/NSAttributedString-OPHTML.git' }
  spec.source_files = '*.{h,m}'
  spec.requires_arc = true
  spec.frameworks = 'CoreText'

  spec.dependency do |p|
    p.name = 'Objective-C-HMTL-Parser'
    p.source = { :git => 'https://github.com/zootreeves/Objective-C-HMTL-Parser.git' }
    p.source_files = '*.{h,m}'
    p.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  end
end
