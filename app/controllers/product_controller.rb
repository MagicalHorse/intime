class ProductController < ApplicationController
  def index
    pid = params[:id]
    prod = Product.search :per_page=>1,:page=>1 do 
            query do
              match :id,pid
            end
          end
    @product = prod.results[0]
    return render :text => t(:commonerror), :status => 404 if @product.nil?
  end
  def search
    page_index_in = params[:page]
    page_size_in = params[:pagesize]
    term = params[:term]
    page_size = (page_size_in.nil?)?20:page_size_in.to_i
    page_size = 20 if page_size>20
    page_index = (page_index_in.nil?)?1:page_index_in.to_i
    term = '' if term.nil?
    products =  Product.search :per_page=>page_size,:page=>page_index do    
         query do
              match ['*.name','*.description','*.engname','*.recommendreason'], term
              match :status,1
            end
          end
    prods_hash = []       
    products.results.each {|p|
      default_resource =p[:resource][0] # p[:resource].sort{|x,y| y[:sortOrder].to_i<=>x[:sortOrder].to_i}.first
      prods_hash << {
        :id=>p[:id],
        :name=>p[:name],
        :resources=>[
          :domain=>PIC_DOMAIN,
          :name=>default_resource[:name]
          ]
        }
    }
    return render :json=>{:isSuccessful=>true,
      :message =>'success',
      :statusCode =>'200',
      :data=>{
        :pageindex=>page_index,
        :pagesize=>page_size,
        :totalcount=>products.total,
        :totalpaged=>(products.total/page_size).ceil,
        :ispaged=> products.total>page_size,
        :products=>prods_hash
      }
     }.to_json()
  end
end
