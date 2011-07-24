$(function(){
  $("#do").click(function(i){
		// CHECK iget
		///////////////////////////////
		var iget = "off";

		if($("input[name=iget]").attr('checked')){
			iget = "on" 
		}

		// API CONNECTION
		////////////////////////////////
    $.getJSON(
      "api/hashnized.json?callback=?",
      {        
				"text": $("#textarea_tweet").val(),
				"iget": iget
      },
      function(json){
        //console.log(json);
        //console.log(json['hashnized']);
        //console.log(encodeURI(json['hashnized']));
        //window.open("https://twitter.com/intent/tweet?text=" + encodeURIComponent(json['hashnized']));
        location.href = "https://twitter.com/intent/tweet?text=" + encodeURIComponent(json['hashnized']) + "&url=" + encodeURIComponent("http://ninjatokyo.com/jphash/");
      }
    );
  });
});
