document.observe('dom:loaded', function(){
    console.log('helo');
  $('go_form').observe('submit',function(event) {
    console.log('woop');
      event.preventDefault();
      var id = $F(this['id']);
      console.log(id);
      alert('woop');
      var self = this;
      if (id !== "") {
        new Ajax.Updater('content', '/threads/'+id);
      } else {
        alert('NaN!!!');
      }
    });
});
