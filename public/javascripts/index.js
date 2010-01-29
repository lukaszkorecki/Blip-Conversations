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

  var container = $('content');
	container.update();
  thread.each(function(blip, index){
      try {
    var blomp = new Element('div', { "class" : 'blip level'+index});
    blomp.insert(new Element('p').update(parse_blip_body(blip.body)));
    var inner = new Element('p', {'class':'user'});
		inner.insert(new Element('img', {'src': 'http://blip.pl'+blip.user.avatar.url_30}));
    var blip_link = new Element('a', {"href" : "http://"+blip.user.login+".blip.pl"}).update('^'+blip.user.login);
    inner.insert(blip_link);
    inner.insert(new Element('em').update(blip.created_at));
		inner.insert(new Element('a', {"href": "http://blip.pl/s/"+blip.id}).update(blip.id));

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

function parse_blip_body(body) {
    function formatLinks(txt) {
      var findLinks = /http(s)*:\/\/[0-9a-z\,\_\/\.\-\&\=\?\%]+/gi;
      return  txt.replace(findLinks, '<a class="quoted_link" target="_blank" href="$&" title="$&">$&</a>');
    }
    function formatUsers(txt) {
      var findUsers = /\^([\w]{1,})/gi;
      return txt.replace(findUsers, '<a target="_blank" class="externalLink" title="$&" href="http://$&.blip.pl"><span class="linksFirstLetter">^</span>$1</a>');
    }
    function formatUsersTwitter(txt) {
      var findUsers = /\@([\w]{1,})/gi;
      return txt.replace(findUsers, '<a target="_blank" class="externalLink" title="$&" href="http://$&.blip.pl"><span class="linksFirstLetter">@</span>$1</a>');
    }
    function formatTags(txt) {
      var findTags = /#[a-zA-Z0-9ęóąśłżźćń_\-☺☻☹★✩✫♫♪♥♦♣♠✿❀❁❄☾☂☀☁☃☄☮☯☎❦♀♂☚☛☠☢☣☤✌✍✎✂✆✈✉✔✘☥☸☦☧☨✝☩☪☭♚♛♜♝♞♟®™♈♉♊♋♌♍♎♏♐♑♒♓…∞¥€£≤≥«»≠≈∫∑∏µ∆øπΩ•÷‰⇐⇒⇔√˚]*/gi;
      return txt.replace(findTags, '<a target="_blank" class="externalLink tagLink" title="$&" href="http://blip.pl/tags/$&">$&</a>');
    }
    body = body.replace('&', '&amp;');
    body = body.replace(/\>/gi, '&gt;');
    body = body.replace(/\</gi, '&lt;');

    //var text2 = formatBlipZnaczki(body);
    var text1 = formatLinks(body);
    text2 = formatTags(text1).replace(/\/#/g, '/');
    text1 = formatUsers(text2).replace(/\/\^/g, '/');
    text2 = formatUsersTwitter(text1).replace(/\/\@/g, '/');
    return text2;
	

}