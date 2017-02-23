# app/views/components.rb
require 'opal'
require 'hyper-react'
# require 'hyper-operation'
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
require 'hyper-router'
require 'react_router'
require 'hyper-mesh'
require 'models'
require_tree './components'
