Pod::Spec.new do |s|
  s.name                     = 'SwiftLintSidekick'
  s.version                  = '0.0.1'
  s.summary                  = 'My shared Swiftlint configuration'
  s.authors                  = { 'Ola Rönnerup' => 'ola@ronnerup.se' }
  s.homepage                 = ''
  s.license                  = 'FREE'
  s.description              = 'A pod wrapping SwiftLint together with my configuration file.'
  s.source                   = { :git => "https://github.com/fnolis/repo.git", :tag => "R-0.0.1" }

  s.cocoapods_version        = '>= 1.5.2'

  # Needed files
  s.preserve_paths           = 'install.rb', 'swiftlint.cfg'

  # Xcode build phase scripts
  s.script_phases            = [
    # Copy the config file if the destination does not already exist.
    { :name => 'Copy configuration file', 
      :script => 
'if ! [ -f ${SRCROOT}/.swiftlint.yml ]; then
  cp -n ${PODS_ROOT}/SwiftLintSidekick/swiftlint.cfg ${SRCROOT}/.swiftlint.yml
fi'},
    # Run script phase installation script.
    { :name => 'Add SwiftLint script to main target', :script => 'export LANG="en_US.UTF-8"; ruby ${PODS_ROOT}/SwiftLintSidekick/install.rb' }
  ]
  
  # Dependency pods
  s.dependency               'SwiftLint', '~> 0.27.0'
end
