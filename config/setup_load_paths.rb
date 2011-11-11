##
## Required if we are running this over passenger using a different gemset than what passenger was compiled on and an
## apache reverse proxy setting. I am currently not doing this right now b/c it is more of a pain than it is worth
## (I still have to start the server up every time I want to use it which is one of the main points to using passenger)
##


# if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
#   begin
#     rvm_path     = File.dirname(File.dirname(ENV['MY_RUBY_HOME']))
#     rvm_lib_path = File.join(rvm_path, 'lib')
#     $LOAD_PATH.unshift rvm_lib_path
#     require 'rvm'
#     RVM.use_from_path! File.dirname(File.dirname(__FILE__))
#   rescue LoadError
#     # RVM is unavailable at this point.
#     raise "RVM ruby lib is currently unavailable."
#   end
# end
#
# ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
# require 'bundler/setup'