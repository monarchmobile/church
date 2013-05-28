jQuery ->
# edit form date_picker
	$("#page_starts_at").datepicker(dateFormat: "dd-mm-yy")
	$("#page_ends_at").datepicker(dateFormat: "dd-mm-yy")

	$("body").delegate "select#page_current_state", "change", ->
		if $(this).val() == "1"
			$("input[type=submit]").val("Save Draft")
			$(".schedule_container").hide()
		if $(this).val() == "2"
			$("input[type=submit]").val("Schedule For")
			$(".schedule_container").show()
		else if $(this).val() == "3"
			$("input[type=submit]").val("Publish Now")
			$(".schedule_container").hide()
			
# index
  $("#published_pages").sortable
    axis: "y"
    handle: ".handle"
    update: ->
      $.post $(this).data("update-url"), $(this).sortable("serialize")

	# index page: current_state select status (ajax)
  $("body").delegate ".page_ajax_edit select", "change", ->
    $(this).closest("form").submit()
    $("#published_pages").sortable
    	axis: "y"
	    handle: ".handle"
	    update: ->
	      $.post $(this).data("update-url"), $(this).sortable("serialize")

  # index page: page links (ajax)
  $("body").delegate ".page_ajax_edit .page_link_location", "click", ->
	  checkbox = $(this).prev()
	  attr_checked = checkbox.attr("checked")
	  if attr_checked && attr_checked == "checked"
	    checkbox.removeAttr "checked"
	    checkbox.closest("form").submit()
	  else
	    checkbox.attr "checked", "checked"
	    checkbox.closest("form").submit()

	value = $("#page_current_state").val()
	if value == "1"
		$(".schedule_container").hide()
		$("input[type=submit]").val("Save Draft")


	
	    