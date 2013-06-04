jQuery ->
	# event/index
	if $('body.events_index').length > 0
		#select current_state
		$("body").delegate ".event_ajax_edit select", "change", ->
			$(this).closest("form").unbind('submit').submit()

		# sort events
		if $("#published_events")[0]
			$("#published_events").sortable
		    axis: "y"
		    handle: ".handle" 
		    update: ->
		      $.post $(this).data("update-url"), $(this).sortable("serialize")

	  # starts at date
		$(".event_message_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".event_message_starts_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".event_message_starts_at", "change", ->
			ChangeDateOnTheFly.init($(this), "start", "event")

		# ends at date
		$(".event_message_ends_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".event_message_ends_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".event_message_ends_at", "change", ->
			ChangeDateOnTheFly.init($(this), "end", "event")

	# events/edit || events/new
	if $('body.events_edit').length > 0 || $('body.events_new').length > 0

		# hide schedule container if current state is draft on page load
		HideShowScheduleContainer.init("event")
		
		# select current_state
		$("body").delegate "select#event_current_state", "change", ->
			value = $(this).val()
			ChangeSubmitText.init(value)

		# date format
		$("#event_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("#event_ends_at").datepicker(dateFormat: "dd-mm-yy")

		# dynamically change dropdown, submit button text and date validation
		$("body").delegate "#event_starts_at", "change", ->
			start_date = $(this).val()
			end_date = $("#event_ends_at").val()
			CalculateDate.init(start_date, end_date, "start", "event")

		$("body").delegate "#event_ends_at", "change", ->
			start_date = $("#event_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end", "event")
