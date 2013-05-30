module DeviseHelper   
	def devise_error_messages!   
	  flash.each do |key,msg|  
		  content_tag :p, msg, :id => key
		end
	end 
end 
