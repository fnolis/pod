#!/usr/bin/env ruby

require 'pathname'
require 'xcodeproj'

xcode_build_script_name = 'Run SwiftLint'
xcode_build_script = "# Run SwiftLint if available
if which ${PODS_ROOT}/SwiftLint/swiftlint >/dev/null; then
  ${PODS_ROOT}/SwiftLint/swiftlint
else
  echo \"SwiftLint pod is missing. Try running \'pod install\' again.\"
fi"

path_to_project = Dir.glob(Pathname.new(ENV["SOURCE_ROOT"]) + '../*.xcodeproj')[0]

project = Xcodeproj::Project.open(path_to_project)
main_target = project.targets.first

script_installed = false

main_target.shell_script_build_phases.each { |run_script|
  script_installed = true if run_script.name == xcode_build_script_name
}

if (!script_installed)
  puts "Installing " + xcode_build_script_name + " run script in Xcode project #{path_to_project}"
  phase = main_target.new_shell_script_build_phase(xcode_build_script_name)
  phase.shell_script = xcode_build_script
  project.save()
else
  puts "Run script already installed."
end
