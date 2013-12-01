<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="java.util.List,com.hackathon.comparadorloa.Funcao" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no">
<title>Comparador LOA</title>
<link rel="stylesheet" type="text/css" href="grid/grid.css"/>

<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap-theme.min.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="dist/css/bootstrap.min.css"/>
<link rel="icon" type="image/x-icon" href="favicon.png" />

<script type="text/javascript">
function makeVisible(id) {
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
    
    }
  }
xmlhttp.open("GET","subfuncao?Funcao="+combobox.value,true);
xmlhttp.send();
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
    
    }
  }
xmlhttp.open("GET","comparar?Funcao1="+document.getElementById("first-category-primary").value+"&Subfuncao1="+document.getElementById("first-category-second").value+"&Funcao2="+document.getElementById("second-category-primary").value+"&Subfuncao2="+document.getElementById("second-category-second").value+"&inicio="+document.getElementById("first-category-third").value+"&fim="+document.getElementById("second-category-third").value,true);
xmlhttp.send();
}
</script>
<style type="text/css">
#resultado-category-01,
#resultado-category-02{
	visibility:hidden;
	display:none;	
}
</style>
</head>

<body class="bg-pattern">
<div class="container">
<header>
<div class="col-md-7 col-md-offset-2 title text-center item">
<h1><span class="logo-comparador" title="JusBrasil | Comparador LOA">Comparador LOA</span></h1>
<div class="text">Bem vindo ao <strong>Comparador LOA</strong>, a mais nova ferramenta de comparação<br />
dos valores gastos entre as areas e sub areas do governo federal.</div>
</div>
</header>
<section class="text-center">
<!-- CONTAINER - PRIMEIRO ITEM -->
<div class="col-md-7 col-md-offset-2 item">
<div>Selecione as areas que deseja comparar.</div>
<div class="col-md-7">
<div class="title-topic">Selecione a primeira area.</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-primary" size="1" id="first-category-primary" onchange="loadSubfuncoes('first-category-second', this)">
  <% List<Funcao> funcoes = (List<Funcao>) request.getAttribute("Funcoes");
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div class="col-md-3">
<span class="instructions">
<  Função  >
</span>
</div>
</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-secondory" size="1" id="first-category-second">
</select>
</div>
<div class="col-md-3">
<span class="instructions">
< Sub-Função  >
</span>
</div>
</div>
</div>
<!-- CONTAINER - SEGUNDO ITEM -->
<div class="col-md-5">
<div class="title-topic">Selecione a segunda area.</div>
<div class="row">
<div class="col-md-12">
<select class="form-control" name="category-primary" size="1" id="second-category-primary" onchange="loadSubfuncoes('second-category-second', this)">
  <% 
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
</div>
<div class="row">
<div class="col-md-12">
<select class="form-control" name="category-primary" size="1" id="second-category-second">
</select>
</div>
</div>
</div>
</div>
<!--PERIODO DE COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2 item">
<div>Selecione o período.</div>
<div class="col-md-3 col-md-offset-2">
<div class="title-topic">De:</div>
<select class="form-control" name="category-tertiary" size="1" id="first-category-third">
  <% List<String> anos = (List<String>) request.getAttribute("Anos");
  for(String ano: anos)
  	out.println("<option>"+ano+"</option>");
  %>
</select>
</div>
<div class="col-md-3 col-md-offset-2">
<div class="title-topic">Até:</div>
<select class="form-control" name="category-tertiary" size="1" id="second-category-third">
  <% 
  for(String ano: anos)
  	out.println("<option>"+ano+"</option>");
  %>
</select>
</div>
</div>
<!--RESULTADOS DA COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2">
<div id="resultado-category-01" class="col-md-5 col-md-offset">
<div class="title-topic">Valor:</div>
<input type="text" value="R$0" class="text-danger" disabled="disabled" id="valor1"></input>
</div>
<div id="resultado-category-02" class="col-md-5 col-md-offset-2">
<div class="title-topic">Valor:</div>
<input type="text" value="R$0" class="text-danger" disabled="disabled" id="valor2"></input>
</div>
</div>
<!--BOTÃO - COMPARAR-->
<div class="col-md-7 col-md-offset-2">
<button class="btn btn-success" onclick="makeVisible('resultado-category-01');makeVisible('resultado-category-02');comparar()" type="button" title="Clique para comparar os valores gastos no orçamento federal.">Comparar</button>
<button class="btn btn-danger col-md-offset-1" onclick="makeClean('resultado-category-01');makeClean('resultado-category-02')" type="button" title="Clique para limpar os resultados.">Limpar</button>
</div>
</section>
<footer>
</footer>
</div>
</body>
</html>
