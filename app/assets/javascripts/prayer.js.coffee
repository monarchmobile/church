jQuery ->
  $("#add_your_church span").click (->
    $(this).parent().next().show()
  ), ->
    $(this).parent().next().hide()
    

