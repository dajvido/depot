$('#cart')
  .hide 'blind', { direction: 'vertical' }, 1000 if $('#cart').length == 1
$('#cart tr').not('.total_line').remove()
