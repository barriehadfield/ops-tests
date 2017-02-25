# app/views/components.rb
require 'opal'
require 'hyper-react'
require 'hyper-operation'
require 'hyper-store'
if React::IsomorphicHelpers.on_opal_client?
  require 'opal-jquery'
  require 'browser'
  require 'browser/interval'
  require 'browser/delay'
  require 'opal_hot_reloader'
  OpalHotReloader.listen
  # add any additional requires that can ONLY run on client here
end
# require 'hyper-router'
# require 'react_router'
# require 'hyper-mesh'
require 'models'

# class HyperOperation
#   class << self
#     def on_dispatch(&block)
#       receivers << block
#     end
#
#     def receivers
#       @receivers ||= []
#     end
#
#     def dispatch(params = {})
#       receivers.each do |receiver|
#         receiver.call params
#       end
#     end
#   end
#
#   def dispatch(params = {})
#     self.class.receivers.each do |receiver|
#       receiver.call params
#     end
#   end
# end
#
# module Hyperloop
#   class Application
#     class Boot < HyperOperation
#       include React::IsomorphicHelpers
#
#       before_first_mount do
#         dispatch
#       end
#     end
#   end
# end

require_tree './components'
