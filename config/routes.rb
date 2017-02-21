Rails.application.routes.draw do
  mount HyperMesh::Engine => '/rr'
  mount Hyperloop::Engine => "/hyperloop_engine"
  root 'home#lucky_dip'
end
