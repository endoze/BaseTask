Pod::Spec.new do |s|
  s.name         = "BaseTask"
  s.version      = "1.2.0"
  s.summary      = "Easy NSURLSession Networking"

  s.description  = <<-DESC
                   BaseTask is a set of classes that allow you to easily create
                   an API client for a web service. It reduces the boilerplate
                   down to just the specifics you need to interact with an API.
                   DESC

  s.homepage     = "http://endoze.github.io/BaseTask"
  s.license      = {type: "MIT", file: "LICENSE"}

  s.author             = {"Chris" => "chris@wideeyelabs.com"}

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = {git: "https://github.com/endoze/BaseTask.git", tag: "#{s.version}"}
  s.source_files  = ["BaseTask/*.swift", "BaseTask/BaseTaskObjC.{h,m}"]
end
