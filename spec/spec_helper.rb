$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "awesome_imports"
require "action_controller"

require File.join(File.dirname(__FILE__), 'fake_app')
