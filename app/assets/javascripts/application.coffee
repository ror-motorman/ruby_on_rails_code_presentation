#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require moment
#= require bootstrap-datetimepicker
#= require rails.validations
#= require rails.validations.simple_form
#= require_tree .

$ ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('[data-datetimepicker]').datetimepicker(format: "DD.MM.YYYY HH:mm")
