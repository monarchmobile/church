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
				@resetCurrentState("Publish", 3)
		else if this.start_val > this.today
				@resetCurrentState("Schedule", 2)

	endWasClicked: ->
		@compareDates()
		if this.end_val < this.today
			$("input#"+this.klass+"_"+this.clicked+"s_at").parent().append("<div class='message'></div>")
			$(".message").html("You must choose an "+this.clicked+" date that is after today")
			$("input#"+this.klass+"_"+this.clicked+"s_at").val("")
		else if this.end_val >= this.today
			if this.start_val < this.today
				@resetCurrentState("Publish", 3)
			else if this.start_val >= this.today
				@resetCurrentState("Schedule", 2)

	prepDate: (start_date, end_date) ->
		this.start_val = new Date(start_date).valueOf()
		this.end_val = new Date(end_date).valueOf()
		this.today = new Date()
		$(".message").remove()
		if this.clicked == "start"
			@startWasClicked()
		else if this.clicked == "end"
			@endWasClicked()