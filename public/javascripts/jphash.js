$(function(){
  $("#do").click(function(){
    $.getJSON(
      "api/hashnized.json?callback=?",
      {        "text": $("#textarea_tweet").val(),
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
