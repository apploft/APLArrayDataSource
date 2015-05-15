Pod::Spec.new do |s|

  s.name         = "APLArrayDataSource"
  s.version      = "0.0.4"
  s.summary      = "UITableViewDataSource for NSArray"

  s.description  = <<-DESC
                   A UITableViewDataSource for data represented as NSArray being displayed in a UITableView.
                   
                   Concept and code is from this great objc.io article:
                   http://www.objc.io/issue-1/lighter-view-controllers.html
                   
                   Additionally supports:
                   * multiple cell identifiers
                   * cell editing (deletion only)
                   * sections, with nested NSArrays as data source (use subclass APLArrayWithSectionsDataSource)
                   DESC

  s.homepage     = "http://www.objc.io/issue-1/lighter-view-controllers.html"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author       = 'Chris Eidhof', 'Michael Kamphausen', 'Tobias Conradi'
  
  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/apploft/APLArrayDataSource.git", :tag => s.version.to_s }

  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.requires_arc = true

end
