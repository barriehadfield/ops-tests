Rails.application.routes.draw do
  mount HyperMesh::Engine => '/rr'
  root 'home#ops_tests'
end
