function makeVisible(id) {
	var element = document.getElementById(id);
	element.style.visibility = "visible";
	element.style.display = "block";
	window.scrollTo(0,document.body.scrollHeight);
}

function makeClean(id) {
	var element = document.getElementById(id);
	element.style.visibility = "hidden";
	element.style.display = "none";
}

function loadSubfuncoes(id, combobox)
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    document.getElementById(id).innerHTML=xmlhttp.responseText;
    makeClean("dark");
    makeClean("carregando");
    }
  }
xmlhttp.open("GET","subfuncao?Funcao="+combobox.value,true);
xmlhttp.send();
makeVisible("dark");
makeVisible("carregando");
}

function comparar()
{
if(!verificarCampos())
	return;
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    var resp = xmlhttp.responseText.split('|');
    document.getElementById("valor1").value=resp[0];
    document.getElementById("valor2").value=resp[1];
    makeClean("dark");
    makeClean("carregando");
    
    }
  }
xmlhttp.open("GET","comparar?Funcao1="+document.getElementById("first-category-primary").value+"&Subfuncao1="+document.getElementById("first-category-second").value+"&Funcao2="+document.getElementById("second-category-primary").value+"&Subfuncao2="+document.getElementById("second-category-second").value+"&inicio="+document.getElementById("first-category-third").value+"&fim="+document.getElementById("second-category-third").value,true);
xmlhttp.send();
makeVisible("dark");
makeVisible("carregando");
}

function verificarCampos(){
	return true;
}