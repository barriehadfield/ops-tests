Rails.application.routes.draw do
  mount HyperMesh::Engine => '/rr'
  mount Hyperloop::Engine => "/hyperloop"
  root 'home#offer_lucky_dip'
end
