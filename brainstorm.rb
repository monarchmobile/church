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

depending on role, you get to see certain things
created_at+7.days > Date.today.beginning_of_week.beginning_of_day+2.hours && <= Date.today-7.days



