document.observe('dom:loaded', function(){
  $('loader').toggle();
  $('go_form').observe('submit',function(event) {
      $('loader').toggle();
      var id = $F(this['id']);
      if (id !== "") {
        new Ajax.Request( '/threads/'+id, {
          method : 'GET',
          evalJS : true,
          onSuccess : function(response) {
            var thread = eval('('+response.responseText+')');
            if(thread.length >0 )
              draw_stuff(thread, id);
            else
              draw_empty();
          }

        });
      } else {
        alert('NaN!!!');
      }
      event.preventDefault();
    });
});

function draw_stuff(thread, id) {
  console.dir(thread);
  var container = $('content');
  container.update();
  thread.each(function(elem, index){
      try {
    var blomp = new Element('div', { "class" : 'blip'});
    blomp.insert(new Element('p').update(elem.body));
    var inner = new Element('p');
    inner.insert(new Element('span').update(elem.id));
    inner.insert(new Element('strong').update(elem.user_path));
    inner.insert(new Element('em').update(elem.created_at));
    var blip_link = new Element('a', {"href" : "http://blip.pl/s/"+elem.id}).update('Blip');
    inner.insert(blip_link);
    blomp.insert(inner);

    container.insert(blomp);
      } catch (err) { console.dir(err); }
  });
    var perm_link = new Element('a', {"href" : "/threads/"+id}).update('Permalink');
    $('loader').toggle();
    container.insert(perm_link);
}
function draw_empty(){
  var container = $('content');
  container.update(new Element('p').update('nope, nothing there'));
    $('loader').toggle();
}
