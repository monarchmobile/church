window.CalculateDate = 
	init: (start_date, end_date, clicked, klass) ->
		this.klass = klass
		start_date = @cleanDate(start_date)
		end_date = @cleanDate(end_date)
		this.clicked = clicked
		@prepDate(start_date, end_date)

	cleanDate: (date) -> 
		date_array = date.split("-")
		new_date = date_array[1]+"/"+date_array[0]+"/"+date_array[2]

	resetCurrentState: (status, num) ->
		$("input[type=submit]").val(status)
		$("#"+this.klass+"_current_state option").attr("selected", false)
		$("#"+this.klass+"_current_state option[value="+num+"]").attr("selected", "selected")

	compareDates: ->
		if this.start_val > this.end_val
			console.log "crossed"
			$("input#"+this.klass+"_"+this.clicked+"s_at").parent().append("<div class='message'></div>")
			$(".message").html("'Starts at' date is greater than the 'Ends at' date")
			$("input#"+this.klass+"_"+this.clicked+"s_at").val("")

	startWasClicked: ->
		@compareDates()
		if this.start_val <= this.today
				@resetCurrentState("Publish Now", 3)
		else if this.start_val > this.today
				@resetCurrentState("Schedule For", 2)

	endWasClicked: ->
		@compareDates()
		if this.end_val < this.today
			$("input#"+this.klass+"_"+this.clicked+"s_at").parent().append("<div class='message'></div>")
			$(".message").html("You must choose an "+this.clicked+" date that is after today")
			$("input#"+this.klass+"_"+this.clicked+"s_at").val("")
		else if this.end_val >= this.today
			if this.start_val < this.today
				@resetCurrentState("Publish Now", 3)
			else if this.start_val >= this.today
				@resetCurrentState("Schedule For", 2)

	prepDate: (start_date, end_date) ->
		this.start_val = new Date(start_date).valueOf()
		this.end_val = new Date(end_date).valueOf()
		this.today = new Date()
		$(".message").remove()
		if this.clicked == "start"
			@startWasClicked()
		else if this.clicked == "end"
			@endWasClicked()

window.ChangeSubmitText = 
	init: (value) ->
		if value == "1"
			$("input[type=submit]").val("Save Draft")
			$(".schedule_container").hide()
		if value == "2"
			$("input[type=submit]").val("Schedule For")
			$(".schedule_container").show()
		else if value == "3"
			$("input[type=submit]").val("Publish Now")
			$(".schedule_container").hide()

window.HideShowScheduleContainer =
	init: (klass)->
		$(".schedule_container").hide() if $("select#"+klass+"_current_state option").first().attr("selected") == "selected"

window.ChangeDateOnTheFly = 
	init: ($this, start_or_end, klass) ->
		$this.closest("form").unbind('submit').submit()
		value = $this.val()
		id_attr = $this.parent().next().attr("id")
		id_array = id_attr.split("_")
		id = id_array[1]
		$("#message_"+id+"_"+start_or_end+"s_at_text").html(value)
		$("."+klass+"_message_"+start_or_end+"s_at").datepicker(dateFormat: "dd-mm-yy")




