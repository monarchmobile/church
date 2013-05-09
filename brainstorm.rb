# models/customer/private.rb
# models/customer/public.rb

# app/controllers/customer/private/registrations_controller.rb
class Customer
  class Private
    class RegistrationsController < Devise::RegistrationsController
    end
  end
end

# views/customer/private/registrations/new.html.haml
# views/customer/public/registrations/new.html.haml


 devise_for :private_customers, :class_name => 'Customer::Private', :controllers => {:registrations => "customer/
private/registrations", :sessions => 'main' } do
    get   "private_customer/sign_up" => "customer/private/registrations#new", :as => :private_customer_signup
    get   "private_customer/sign_in" => "main#index", :as => :private_customer_signin
 end




test prayers

User Prayer Affiliation

new prayer 
	new user 
		new affiliation ***DONE
		existing affiliation ***DONE
	old user
		existing affiliation


<%= form_tag :url => url_for(:controller => "users", :action => "search"), remote: true  %>
      <p>
        <%= text_field_tag :search, params[:search] %>
        <%= submit_tag %>
      </p>
<% end %>
