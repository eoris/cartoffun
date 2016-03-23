$(document).ready ->
  checkbox = $('#shipping-checkbox')
  form = $('.shipping-input')
  input = $('.shipping-input :input')

  checkbox.change ->
    if checkbox.is(':checked')
      form.slideUp()
      input.attr('required',false)
    else
      form.slideDown()
      input.attr('required',true)
