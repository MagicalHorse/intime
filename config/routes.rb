# encoding: utf-8
class VersionConstraint
  def initialize(*version)
    @version = version[0].to_i unless version.nil?
    @version = 2*100+1*10+1 if @version.nil? || @version ==0
  end

  def matches?(request)
    current_ver = request.query_parameters[:client_version]
    return false if current_ver.nil?
    current_ver_value = 0
    current_ver.split('.'). each_with_index do |v,i|
      break if i > 2
      current_ver_value += v.to_i*(10 ** (2-i))
    end
    return @version <= current_ver_value
  end
end

IntimeService::Application.routes.draw do

  get "comment/get_list"

  match "wxmsg/update"=>"wxReply#update"

  match "version/latest"=>"version#latest"
  match "version/insert"=>"version#insert"

  match "storecoupon/consume"=>"storeCoupon#consume"
  match "storecoupon/logs"=>"storeCoupon#logs"
  match "storecoupon/void"=>"storeCoupon#void"

  scope :module => "v22" do
    constraints VersionConstraint.new do
     match "promotion/list" =>"promotion#list"
     match "storepromotion/list"=>"storePromotion#list"
     match "storepromotion/detail"=>"storePromotion#detail"
     match "specialtopic/list"=>"specialTopic#list"
     match "banner/list"=>"banner#list"
    end
  end
  scope :module=>'front' do
    get '/auth/:provider/callback', to: 'sessions#create'
    delete '/logout', to: 'sessions#destory'
    get '/login', to: 'sessions#login'
  end

  match "hotword/list"=>"hotword#list"
  match "banner/list"=>"banner#list"

  match "store/list"=>"store#list"
  match "store/all"=>"store#list"
  match "store/detail"=>"store#detail"
  match "store/:id"=>"store#index"

  match "brand/list"=>"brand#list"
  match "brand/all"=>"brand#list"
  match "brand/groupall"=>"brand#list_by_group"

  match "tag/list"=>"tag#list"
  match "tag/all"=>"tag#list"

  match "specialtopic/list" => "specialTopic#list"

  match "product/search" => "product#search"
  match "product/list" => "product#list"

  match "promotion/list" => "promotion#list"

  match "wx_object/search" => "wxobject#validate", :via=>:get, :defaults=>{:format=>'html'}
  match "wx_object/search" => "wxobject#search", :via=>:post, :defaults=>{:format=>'xml'}

  match "card/find"=>"card#find"

  resources :special_topic, only: [:index] do
    collection do
      get :get_list
    end
  end

  resources :promotion, only: [] do
    collection do
      get :get_list
    end
  end

  scope module: :front do
    resources :promotions, only: [:index, :show] do
      collection do
        get :get_list
      end
    end

    resources :products, only: [:index, :show]
  end

  #scope module: 'front' do
    #resources :promotion, only: [:index, :show] do
      #collection do
        #get :list
        #get :get_list
      #end
    #end
  #end

  resources :special_topic, only: [:index] do
    collection do
      get :get_list
    end
  end

  resources :promotion, only: [] do
    collection do
      get :get_list
    end
  end

  scope module: :front do
    resources :promotions, only: [:index, :show] do
      collection do
        get :get_list
      end
    end

    resources :products, only: [:index, :show]
  end

  match "product/:id" => "product#show"
  match "promotion/:id" => "promotion#show"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  namespace :front do
    # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
       resources :exorders do
         collection do
           get 'show'
         end
       end

    get '/hotwords',                to: 'common#hotwords'
    get '/tags',                    to: 'common#tags'
    get '/brands',                  to: 'common#brands'
    get '/stores',                  to: 'common#stores'

    get '/my_favorite',             to: 'users_center#my_favorite'
    get '/my_share',                to: 'users_center#my_share'
    get '/my_promotion',            to: 'users_center#my_promotion'
    get '/follows',                 to: 'users_center#follows'
    get '/fans',                    to: 'users_center#fans'
    get '/my_profile',              to: 'users_center#profile'
    get '/his_favorite/:userid',    to: 'users_center#his_favorite',  as: :his_favorite
    get '/his_promotion/:userid',   to: 'users_center#his_promotion', as: :his_promotion
    get '/his_share/:userid',       to: 'users_center#his_share',     as: :his_share
    get '/his_info/:userid',        to: 'users_center#his_info',      as: :his_info
    get '/his_profile/:userid',     to: 'users_center#his_profile',   as: :his_profile
    post '/follow/:id',             to: 'users_center#follow',        as: :follow
    post '/unfollow/:id',           to: 'users_center#unfollow',      as: :unfollow
    get  '/about',                  to: 'about#index',                as: :about
    get  '/feedback',               to: 'about#feedback',             as: :feedback
    post '/feedback',               to: 'about#create_feedback',      as: :create_feedback

     #test order create
    get '/order/create' ,            to: 'orders#create'
    get 'address/create',           to: 'addresses#create'
    get 'address/update',           to: 'addresses#update'

    get  '/my_comments',            to: 'comments#my_comments',       as: :my_comments


    resources :products, :only=>[:index, :show] do
      collection do
        get :his_favorite_api, :path => :his_favorite_api
        get :my_favorite_api
        get :my_share_list_api
        get :sort_list
        get :list_api
        get :list
        get :search_api
      end

      member do
        post :favor
        post :unfavor
        post :download_coupon
        post :comment
      end
    end
    resources :promotions, :only=>[:index, :show] do
      collection do
        get :get_list
      end

      member do
        post :favor
        post :unfavor
        post :download_coupon
        post :comment
      end
    end

    resources :stores, only: [:show] do
      member do
        get :promotions
      end
    end

    resources :specials, :only => [:index] do
      collection do
        get :get_list
      end
    end

    resources :comments  do
      collection do
        get  :get_list
      end
    end

    resources :orders, except: [:edit, :update] do
      collection do
        post :computeamount
        post :confirm
      end

      member do
        get :pay
      end
    end
    resources :addresses, only: [:index, :create, :update, :destroy]
    resources :rmas do
      collection do
        get :order_index
      end
    end

    resources :coupons, only: [:index]

    # 代金券
    resources :vouchers, only: [:index, :show] do
      collection do
        get  :exchange_info
        get  :binding_card

        post :bindcard
      end

      member do
        post :void
      end
    end

    resources :storepromotions, only: [:index, :show] do
      member do
        post :exchange
        post :amount
      end
    end
    # 个人中心
    get '/profile', to: 'profile#index'
    get '/profile/return_policy', to: 'profile#return_policy'
    get '/profile/edit', to: 'profile#edit'
    put '/profile/update', to: 'profile#update'

    get '/supportshipments', to: 'environment#supportshipments'

    # 前端测试用，正式上去前要删除
    # FIXME
    get '/orders_create', to: 'orders#create'
    get '/addresses_update/:id', to: 'addresses#update'
    get '/addresses_create', to: 'addresses#create'
    get '/orders_computeamount', to: 'orders#computeamount'

  end

  namespace :ims do
    resource :auth
    resources :stores, only: [:show]
    resources :combos, only: [:show, :destroy] do
      collection do
        post 'upload'
        get 'ajax'
      end
    end
    resources :accounts, only: [:new, :create] do
      collection do
        get   :mine
        get   :barcode
        get   :phone_page
        get   :verify_identify_phone
        get   :verify_identify_sms_code
        get   :verify_phone
        get   :verify_sms_code
        post  :resend_sms
        get   :set_identity_no_page
        get   :set_identity_no
        get   :before_reset_password_page
        get   :reset_password_page
        get   :reset_password
        get   :change_password_page
        get   :change_password
        get   :set_id_page
        post  :set_id
        get   :test
      end
    end
    resources :cards, only: [:index] do
      collection do
        get     :recharge
        get     :give_page
        get     :accept
        get     :accepted_page
        get     :give
        get     :refuse
        get     :agreement
      end
    end
    get 'cards/gift_page/:charge_no', to: 'cards#gift_page'
    resources :card_orders, only: [:new, :create, :show] do
      collection do
        get :list
        get :my_list
        get :received_list
        get :check_status
      end
    end
    match "card_orders_pay" => "card_orders#new"
    match "orders_new" => "orders#new"
    match "orders_show" => "orders#show"
    resources :favorites, only: [] do
      collection do
        get  :stores_list
        get  :combos_list
        get  :list
        post :favor
        post :unfavor
      end
    end
    resources :recharge_histroy, only: [:index]
    resources :orders, only: [:index, :new, :create, :show] do
      member do
        put :change_state
        post :payments
        get :notice_success
      end

      collection do
        get :check_status
      end
      resources :returns_reasons, only: [:new, :create] do
        member do
          put :cancel
        end
        collection do
          get "result"
        end
      end
    end


    namespace :store do
      root :to => "home#index"
      post "login" => "home#login"
      get 'check_code' => 'home#check_code'
      resources :sales_codes, only: :create
      resources :sells, only: :index do
        member do
          put :update_is_online
        end
      end
      resources :suggesstions, only: [:new, :create]
      resources :themes, only: [:index, :update]
      resources :products do
        member do
          get 'add_to_combo'
        end
        collection do
          post :upload
          get :tutorials
          get :search
          get :add_size
        end
      end
      resources :combos do
        member do
          put 'add_img'
          put 'update_desc'
          get 'preview'
          get 'update_desc'
        end
        collection do
          get :tutorials
          get 'remove_img'
          get 'remove_product'
        end
      end
      resources :stores, only: [:index, :show, :edit, :update] do
        collection do
          get 'records', 'manage', 'theme', 'check', 'change_theme'
          post 'change_logo'
          post 'change_info'
        end
        member do
          get 'my'
        end
      end
      resources :incomes, only: [:index, :new, :create] do
        collection do
          get :my, :list, :frozen, :tips
        end
      end

      resources :orders, only: [:index, :show]
    end

    # weixin self defined menu
    resource :weixin,only:[] do
      member do
        get 'menu',to: :verify
        post 'menu', to: :message
        get :access_token
        post :access_token
      end
    end
  end

  get 'payment/callback', to: 'front/orders#pay_callback'
  match "product/:id" => "product#show"
  match "promotion/:id" => "promotion#show"

  match "ims/combos/:id/:t" => "ims/combos#show", as: "ims_combo"
  match "ims/stores/:id/:t" => "ims/stores#show", as: "ims_store"
  match "ims/store/stores/:id/my/:t" => "ims/store/stores#my", as: "my_ims_store_store"
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root to: 'front/promotions#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
