class ProductsController < ApplicationController

require 'will_paginate/array'

  skip_before_filter :verify_authenticity_token, only: [:product_compare,:manu_category_compare,:manu_index_product_compare]

    

  def new
 
    @user=User.new
 
    render :layout=>false

  end

  def create

    @user=User.new(user_params)
  
    if @user.save
  
       redirect_to :action=>"login_page"
  
    else
  
       redirect_to :action=>"new"
  
    end

  end

  def login_page

    @user=User.new

  end

  def validate_login

     params.permit!

     @user=User.where params[:user]

     if not @user.blank?

        session[:user_id]=@user.first.id

        redirect_to :action=>"import"

     else

        redirect_to root_path 

     end

  end

  def import

     @product=Product.new

     render :layout=>false

  end

  def import_process

      file=params[:product][:file1]

      filename=params[:product][:file1].original_filename

      @product=Product.bro(file)
    
      unless @product.blank?
    
       redirect_to :action=> "import"
 
       flash[:notice] = "Your file has been successfully imported in a database..."
   
      else

       flash[:notice] = "Invalid file headers or file format"
     
       redirect_to :action=> "import"
    
      end

  end

  def main_category

      @taxon=Taxon.all    
      
      @manufacture=Manufacture.all

  end

  def sub_category

      @taxon_id=params[:format] || params[:id]
      
      unless Product.where(:taxonomy_id=>BSON::ObjectId.from_string(@taxon_id)).present?

        if Taxon.where(:id=>@taxon_id).present? || Taxon.where(:id=>Taxonomy.where(:id=>BSON::ObjectId.from_string(@taxon_id)).pluck(:parent_id)[0]).present?

          if Taxon.where(:id=>Taxonomy.where(:id=>BSON::ObjectId.from_string(@taxon_id)).pluck(:parent_id)[0]).present?

            @taxon_id=Taxon.where(:id=>Taxonomy.where(:id=>BSON::ObjectId.from_string(@taxon_id)).pluck(:parent_id)[0]).pluck(:id)[0]

          end

            $main_cat_name=Taxon.where(:id=>@taxon_id)

            $taxon_main=Taxonomy.where(:taxon_id=>BSON::ObjectId.from_string(@taxon_id))

            @taxon=$taxon_main.where(:parent_id=>BSON::ObjectId.from_string(@taxon_id))

        else
          
            @taxon=$taxon_main.where(:parent_id=>BSON::ObjectId.from_string(@taxon_id))
       
        end

      else

        @product1=Product.where(:taxonomy_id=>BSON::ObjectId.from_string(@taxon_id))

        @product=@product1.paginate(:page => params[:page], :per_page => 10)


      end
      
  end

  def product_desc

      @prms=params[:format]

      @product=Product.where(:id=>BSON::ObjectId.from_string(params[:format]))

      @related=Product.where(:taxonomy_id=>BSON::ObjectId.from_string(@product.pluck(:taxonomy_id)[0])).not.where(:id=>@product.pluck(:_id))

  end

  def product_compare

      
      @pros=Product.where(:id.in=>params[:is].flatten.uniq)

      @comp=[]
 
      @pros.pluck(:property).map{|i| @comp << i.keys}

      @names=["manu_name","mp_number","product_name","image",[@comp.flatten.uniq]].flatten
    
  end

  def manu_category
 
      $bread=[]

      unless Product.where(:taxonomy_id=>BSON::ObjectId.from_string(params[:format])).present?
      
        if Product.where(:manu_id=>BSON::ObjectId.from_string(params[:format])).present?
    
           @manu_id=params[:format]
    
           $manu_name=Manufacture.where(:id=>@manu_id).pluck(:manu_name)[0]
    
           @taxon=Taxon.where(:id.in=>Product.where(:manu_id=>BSON::ObjectId.from_string(@manu_id)).pluck(:taxon_id).flatten.uniq).flatten
   
           $taxonomy=Taxonomy.where(:id.in=>Product.where(:manu_id=>BSON::ObjectId.from_string(@manu_id)).pluck(:path).flatten.compact.uniq)
           
        else

           @taxon=$taxonomy.where(:parent_id=>BSON::ObjectId.from_string(params[:format]))
    
        end

      else

           $bread << $taxonomy.where(:id=>BSON::ObjectId.from_string(params[:format]))
 
           @product1=Product.where(:taxonomy_id=>BSON::ObjectId.from_string(params[:format]))

           @product=@product1.paginate(:page => params[:page], :per_page => 10)

      end

  end

  def manu_category_sub

  end

  def manu_category_compare

      
      @pros=Product.where(:id.in=>params[:is].flatten.uniq)

      @comp=[]
 
      @pros.pluck(:property).map{|i| @comp << i.keys}

      @names=["manu_name","mp_number","product_name","image",[@comp.flatten.uniq]].flatten

  end

  def manu_category_desc
  
    @prms=params[:format]

    @product=Product.where(:id=>BSON::ObjectId.from_string(params[:format]))

    @related=Product.where(:taxonomy_id=>BSON::ObjectId.from_string(@product.pluck(:taxonomy_id)[0])).not.where(:id=>@product.pluck(:_id))

  end

  
  def manu_index_category

    @taxon=Taxon.all

  end

  def manu_index_sub_category

    unless Product.where(:taxonomy_id=>BSON::ObjectId.from_string(params[:format])).present? 
    
      if Taxon.where(:id=>BSON::ObjectId.from_string(params[:format])).present?
    
          @tax=params[:format]
    
          $taxon_name=Taxon.where(:id=>params[:format])
    
          @manufacture=Manufacture.where(:id.in=>Product.where(:taxon_id=>BSON::ObjectId.from_string(params[:format])).pluck(:manu_id).uniq)
    
      elsif Product.where(:manu_id=>BSON::ObjectId.from_string(params[:format])).present?
    
          $manufacture=Manufacture.where(:id=>params[:format])
    
          $manu=$manufacture.pluck(:manu_name)[0]
    
          $taxonomy_index=Taxonomy.where(:id.in=>Product.where(:manu_id=>BSON::ObjectId.from_string(params[:format])).pluck(:path).flatten.uniq.sort)
    
          @sub_taxonomy=$taxonomy_index.where(:parent_id=>BSON::ObjectId.from_string($taxon_name.pluck(:id)[0]))
    
      else
    
          @sub_taxonomy=$taxonomy_index.where(:parent_id=>BSON::ObjectId.from_string(params[:format]))
    
      end
    
    else
      
        @product1=Product.where(:taxon_id=>BSON::ObjectId.from_string($taxon_name.pluck(:id)[0])).where(:manu_id=>BSON::ObjectId.from_string($manufacture.pluck(:id)[0])).where(:taxonomy_id=>BSON::ObjectId.from_string(params[:format]))
    
        @product=@product1.paginate(:page => params[:page], :per_page => 10)

        $product=Product.where(:taxon_id=>BSON::ObjectId.from_string($taxon_name.pluck(:id)[0])).where(:manu_id=>BSON::ObjectId.from_string($manufacture.pluck(:id)[0])).where(:taxonomy_id=>BSON::ObjectId.from_string(params[:format]))
         
    end

  end

  def manu_index_product_desc

      @prms=params[:format]
   
      @product=Product.where(:id=>BSON::ObjectId.from_string(params[:format]))
     
      @related=$product.not.where(:id=>@product.pluck(:_id))

  end

  def manu_index_product_compare

      @pros=Product.where(:id.in=>params[:is].flatten.uniq)

      @comp=[]
 
      @pros.pluck(:property).map{|i| @comp << i.keys}

      @names=["manu_name","mp_number","product_name","image",[@comp.flatten.uniq]].flatten
    
  end

def search

    @search=params[:search]

    @product1= Product.where(product_name: /.*#{@search}*./i)

    @product2=Manufacture.where(:manu_name.in=>Product.where(manu_id:/.*#{@search}*./i)).pluck(:product_name)

    @product3=@product1+@product2

    @product=@product3.paginate(:page => params[:page], :per_page => 10)

end

private
  def user_params
    params.require(:user).permit!
  end
  

end



















  





