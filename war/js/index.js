function makeVisible(id) {
	var element = document.getElementById(id);
	element.style.visibility = "visible";
	element.style.display = "block";
	window.scrollTo(0,document.body.scrollHeight);
}

function makeVisibleWithoutScroll(id) {
	var element = document.getElementById(id);
	element.style.visibility = "visible";
	element.style.display = "block";
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
makeVisibleWithoutScroll("dark");
makeVisibleWithoutScroll("carregando");
}

function comparar()
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
    var resp = xmlhttp.responseText.split('|');
    document.getElementById("valor1").value=resp[0];
    document.getElementById("valor2").value=resp[1];
    document.getElementById("valor3").value=resp[2];
    document.getElementById("gasto-total1").innerHTML=resp[3];
    document.getElementById("gasto-total2").innerHTML=resp[4];
    makeClean("dark");
    makeClean("carregando");
    makeVisible('resultado-category-01');
    makeVisible('resultado-category-02');
    makeVisible('resultado-category-03');
    }
  }
var domNode1 = document.getElementById("first-category-primary");
var value1 = domNode1.selectedIndex;
var selected_text1 = domNode1.options[value1].text;
var domNode2 = document.getElementById("second-category-primary");
var value2 = domNode2.selectedIndex;
var selected_text2 = domNode2.options[value2].text;
xmlhttp.open("GET","comparar?Funcao1="+domNode1.value+"&Subfuncao1="+document.getElementById("first-category-second").value+"&Funcao2="+domNode2.value+"&Subfuncao2="+document.getElementById("second-category-second").value+"&inicio="+document.getElementById("first-category-third").value+"&fim="+document.getElementById("second-category-third").value+"&Funcao1Nome="+selected_text1+"&Funcao2Nome="+selected_text2,true);
xmlhttp.send();
makeVisibleWithoutScroll("dark");
makeVisibleWithoutScroll("carregando");
}

function verificarCampos(){
	var inicio = document.getElementById("first-category-third").value;
	var fim = document.getElementById("second-category-third").value;
	if(inicio == 0 || fim == 0 || (inicio > fim)){
		alert("Datas inválidas.");
		return false;
	}
	if(document.getElementById("first-category-primary").value == 0 || document.getElementById("second-category-primary").value == 0){
		alert("Selecione funções");
		return false;
	}
	if(document.getElementById("first-category-primary").value == document.getElementById("second-category-primary").value && document.getElementById("first-category-second").value == document.getElementById("second-category-second").value){
		alert("Selecione funções diferentes");
		return false;
	}
	return true;
}

function clearForm(){
	makeClean('resultado-category-01');
	makeClean('resultado-category-02');
	makeClean('resultado-category-03');
	document.getElementById("first-category-primary").value = 0;
	document.getElementById("second-category-primary").value = 0;
	document.getElementById("first-category-second").value = 0;
	document.getElementById("second-category-second").value = 0;
	document.getElementById("first-category-third").value = 0;
	document.getElementById("second-category-third").value = 0;
}