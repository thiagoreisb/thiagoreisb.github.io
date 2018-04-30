var ewig = "";
var holder ="";
var original = "";

function permuter(word) {
    var ind=0;
    var gate=0;
    var next = 0;
    var permuda = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
    word = word.toLowerCase();
    var polygon = [];
    
    coding(polygon, word);

    if (polygon[polygon.length-1]<25) {
        polygon[polygon.length-1]++;}
    else {
        polygon[polygon.length-1]=0;
        for (ind = polygon.length-2; ind>-1; ind--){
            if(polygon[ind]<25) {polygon[ind]++; gate++; break;}
            else {polygon[ind]=0;}
        }
        if (gate==0) {coding(polygon, original.toLowerCase())/*polygon.unshift(0)*/;}
    }
    holder = permuda[polygon[0]].toUpperCase();
    for     (ind = 1; ind < polygon.length; ind++) {
        holder= holder + permuda[polygon[ind]];
    }
    return holder;
}

function permute(eyedee) {
    var word1 = document.getElementById(eyedee).innerHTML;
    original = word1;
    ewig = setInterval(function() {document.getElementById(eyedee).innerHTML = permuter(word1); word1=holder;}, 1);
}
    
function unpermute(eyedee) {
    clearInterval(ewig);
    document.getElementById(eyedee).innerHTML = original;
}

function coding(polygon, word){
	for (ind=0; ind<word.length;ind++) {
        polygon[ind] = word.charCodeAt(ind) - 97;
    }
}