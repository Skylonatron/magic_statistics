function hoverdiv(e,divid){

    var left  = e.clientX  + "px";
    var top  = e.clientY  + "px";

    var div = document.getElementById(divid);

    div.style.left = left;
    div.style.top = top;

    $("#"+divid).toggle();
    return false;
}

function spinManaSymbol(frame){
  if( $(frame).hasClass( "magic-symbol-spin") ){
    $(frame).removeClass("magic-symbol-spin");
  } else {
    $(frame).addClass("magic-symbol-spin");
  }
}
