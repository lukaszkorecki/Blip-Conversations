document.observe('dom:loaded', function(){
  $('loader').toggle();
  $('go_form').observe('submit',function(event) {
      $('loader').toggle();
      var id = $F(this['id']);
      if (id !== "") {
        new Ajax.Request( '/threads/'+id, {
          method : 'GET',
          onSuccess : function(response) {
              draw_stuff(response.responseText);
              $("loader").toggle();
          }

        });
      } else {
        alert('NaN!!!');
      }
      event.preventDefault();
    });
});

function draw_stuff(html) {

  var container = $('content');
  container.update(html);

}
