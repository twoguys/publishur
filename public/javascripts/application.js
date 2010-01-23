$(document).ready(function() {
  // $.each($('.hoverable > .hidden'), function() {
  //     $(this).hide();
  //   }
  $('.hidden').hide();
  $('.hoverable').hover(
    function () { $(this).find('.hidden').show(); },
    function () { $(this).find(".hidden").hide(); }
  );
  $('.loader').click(function() {
    $(this).parent().addClass('loading');
    $(this).parent().removeClass('hidden');
  });
});