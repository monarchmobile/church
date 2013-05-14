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


Lists to manage prayer requests
lists will be available to each coordinator representing a church
current_user.is? :coordinator
  list of interecessors
    waiting to be approved
      approved = false, role = intercessor
    approved
      list of prayers
        this week and the rest divided up

current_user.is? :interecessor 
  list of prayers
    new this week
    the rest split amoungst all interecessor 

if user [1,2]
  you see everything
if user [3]\

go straing to user/show page, doing intercessor
  all prayers with the same affiliation intercessor


