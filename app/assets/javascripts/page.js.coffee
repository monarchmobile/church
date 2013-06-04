jQuery ->
	# pages/index
	if $('body.pages_index').length > 0
		#select current_state
	  $("body").delegate ".page_ajax_edit select", "change", ->
	    $(this).closest("form").unbind('submit').submit()

	  # sort pages
	  $("#published_pages").sortable
	    axis: "y"
	    handle: ".handle"
	    update: ->
	      $.post $(this).data("update-url"), $(this).sortable("serialize")

	  # page links
	  $("body").delegate ".page_ajax_edit .page_link_location", "click", ->
		  checkbox = $(this).prev()
		  attr_checked = checkbox.attr("checked")
		  console.log(attr_checked)
		  if attr_checked && attr_checked == "checked"
		    checkbox.removeAttr "checked"
		    checkbox.closest("form").submit()
		  else
		    checkbox.attr "checked", "checked"
		    checkbox.closest("form").submit()
	
	# pages/edit || pages/new
	if $('body.pages_edit').length > 0 || $('body.pages_new').length > 0
		# hide schedule container if current state is draft on page load
		HideShowScheduleContainer.init("page")

		# select current_state
		$("body").delegate "select#page_current_state", "change", ->
			value = $(this).val()
			ChangeSubmitText.init(value)
			
		# date format
		$("#page_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("#page_ends_at").datepicker(dateFormat: "dd-mm-yy")

		# dynamically change dropdown, submit button text and date validation
		$("body").delegate "#page_starts_at", "change", ->
			start_date = $(this).val()
			end_date = $("#page_ends_at").val()
			CalculateDate.init(start_date, end_date, "start", "page")

		$("body").delegate "#page_ends_at", "change", ->
			start_date = $("#page_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end", "page")

	$("body").delegate ".close_form", "click", ->
			console.log("clicked")
			$(this).parent().hide()