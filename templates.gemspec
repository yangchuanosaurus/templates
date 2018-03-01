# -*- encoding: utf-8 -*-

require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'templates-cli'
  s.version = Template::VERSION
  s.authors = ['Albert Yangchuanosaurus Zhao']
  s.description = 'Tempaltes method of supporting personal development'
  s.license = 'MIT'
  s.email = '355592261@qq.com'
  s.executables = ['templatecli']
  s.files = `git ls-files -z`.split("\0")
  s.homepage = 'https://github.com/yangchuanosaurus/templates'
  s.summary = 'TemplatesCli'

  s.required_ruby_version = '>= 2.0.0'
end
