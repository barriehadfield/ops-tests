Rails.application.routes.draw do
  mount HyperMesh::Engine => '/rr'
  mount Hyperloop::Engine => "/hyperloop_engine"
  root 'home#ops_tests'
end
