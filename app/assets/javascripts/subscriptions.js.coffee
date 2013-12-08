# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#premium-form').off().hide() unless plan2

  plan2 =
    $('#plan_id_2').change ->
      if $(this).is(':checked')
        $('#premium-form').show()
      else if $(this).is(':not(:checked)')
        $('premium-form').hide()
      
subscription =
  setupForm: ->
    $('#new_subscription').submit ->
      $('input[type=submit]').prop('disabled', true)
      subscription.processCard()
      false

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()

    Stripe.createToken(card, subscription.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#subscription_stripe_card_token').val(response.id)
      $('#new_subscription')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').prop('disabled', false)

