Rails.application.routes.draw do

  devise_for :users
  scope "/admin" do
    resources :users
  end

  mount Ckeditor::Engine => '/ckeditor'

  resources :columns do
    member do
      post 'editor_update'
      post 'estendi_riga'
      post 'riduci_riga'
      post 'inserisci_riga_prima'
      post 'inserisci_riga_dopo'
      post 'elimina_riga'
      post 'inserisci_colonna_prima'
      post 'inserisci_colonna_dopo'
      post 'allarga_colonna'
      post 'stringi_colonna'
      post 'elimina_colonna'
      post 'rendi_dinamica_inserendo'
      post 'rendi_dinamica_eliminando'
      post 'rendi_statica'
      get 'dialog_sfondo'
      get 'dialog_immagine'
      get 'modifica_immagine'
    end
  end

  resources :rows

  resources :sections

  resources :pages do
    member do
      get 'route'
    end
  end

  resources :column_images do
    member do
      post 'elimina'
    end
  end

  get ':slug' => 'pages#route'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#route', as: 'home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
