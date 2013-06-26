UserApproval = 
	init: (element) -> 
		this.element = element
		select = element.prev()
		this.set_value(select)
		console.log(select.val())

	set_value: (select) ->
		if select.val() == "true"
			select.val("false") 
			this.set_background("Not Approved", "red", "green")
		else
			select.val("true")
			this.set_background("Approved", "green", "red")
		this.submit_form()
			
	submit_form: ->
		this.element.closest("form").unbind('submit').submit()

	set_background: (status, add_color, remove_color) ->
		this.element.html(status).addClass(add_color+"_background").removeClass(remove_color+"_background")

jQuery ->

	# user approval status
	$("body").delegate ".user_ajax_edit .user_approval_status", "click", ->
		UserApproval.init($(this))
		
	$("body").delegate "#new_user .add_your_church span", "click", ->
	  $this = $(this)
	  if $this.parent().next().is(":visible")
	    console.log "hidden"
	    $this.parent().next().addClass "hidden"
	  else if $this.parent().next().is(":hidden")
	    console.log "showing"
	    $this.parent().next().removeClass "hidden"
	    $("select#user_affiliation").val ""

	$("body").delegate "select#user_affiliation", "change", ->
		if $(this).val() is ""
			$("#new_church_name").removeClass "hidden"
		else
			$("#new_church_name").addClass "hidden"

	$("body").delegate ".church_answer", "click", ->
		value = $(this).data("answer")
		console.log value
		if $(".section").is(":visible")
			$(".section").addClass "hidden"
		if value is "yes"
			$("#affiliation_container").removeClass "hidden"
			$("#clergy_container").removeClass "hidden"
			$("#final_container").removeClass "hidden"
		else if value is "no"
			$("#reference_container").removeClass "hidden"
			$("#final_container").removeClass "hidden"



		