Rails.application.routes.draw do
  get 'static_page/index'

  root 'static_page#index'
end
