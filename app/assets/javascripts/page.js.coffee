jQuery ->
# index
  $("#published_pages").sortable
    axis: "y"
    handle: ".handle"
    update: ->
      $.post $(this).data("update-url"), $(this).sortable("serialize")

	# select status
  $("body").delegate ".page_ajax_edit select", "change", ->
    $(this).closest("form").submit()
    $("#published_pages").sortable
    	axis: "y"
	    handle: ".handle"
	    update: ->
	      $.post $(this).data("update-url"), $(this).sortable("serialize")
	      console.log("2nd sort")

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

# _form
	$("#page_starts_at").datepicker(dateFormat: "dd-mm-yy")
	$("#page_ends_at").datepicker(dateFormat: "dd-mm-yy")

	$("body").delegate "select#page_current_state", "change", ->
		console.log "changed"
		if $(this).val() == "1"
			$("input[type=submit]").val("Save Draft")
			$(".schedule_container").hide()
		if $(this).val() == "2"
			$("input[type=submit]").val("Schedule For")
			$(".schedule_container").show()
		else if $(this).val() == "3"
			$("input[type=submit]").val("Publish Now")
			$(".schedule_container").hide()
	    