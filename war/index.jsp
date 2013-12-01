﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    
    }
  }
xmlhttp.open("GET","subfuncao?Funcao="+combobox.value,true);
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
<h1><span class="logo-comparador" title="JusBrasil | Comparador LOA"alt="Logo JusBrasil | Comparador LOA">Comparador LOA</span></h1>
<div class="text">Bem vindo ao <strong>Comparador LOA</strong>(<em>Lei Orçamentária Anual</em>), a mais nova ferramenta de comparação<br />
dos valores gastos entre as áreas e sub áreas do governo federal.<br />
<a href="http://www.jusbrasil.com.br/topicos/322848/lei-orcamentaria-anual">Clique aqui para saber mais sobre o <strong>LOA</strong>.</a></div>
</div>
</header>
<section class="text-center">
<!-- CONTAINER - PRIMEIRO ITEM -->
<div class="col-md-7 col-md-offset-2 item">
<h4>Selecione as areas que deseja comparar.</h4>
<div class="col-md-7">
<div class="title-topic">Selecione a primeira área.</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-primary" size="1" id="category-primary" onchange="loadSubfuncoes('first-category-second', this)">
  <% List<Funcao> funcoes = (List<Funcao>) request.getAttribute("Funcoes");
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div class="col-md-4">
<span class="instructions" title="Função é o que a área exerce.">
<  Função  >
</span>
</div>
</div>
<div class="row">
<div class="col-md-8">
<select class="form-control" name="category-secondory" size="1" id="first-category-second">
</select>
</div>
<div class="col-md-4">
<span class="instructions" title="Sub-função é o que a sub área exerce.">
< Sub-Função  >
</span>
</div>
</div>
</div>
<!-- CONTAINER - SEGUNDO ITEM -->
<div class="col-md-5">
<div class="title-topic text-center">Selecione a segunda área.</div>
<div class="col-md-11 col-md-offset-1">
<select class="form-control" name="category-primary" size="1" id="category-primary" onchange="loadSubfuncoes('second-category-second', this)">
  <% 
  for(Funcao funcao : funcoes) {
    out.println("<option value=\""+funcao.id+"\">"+funcao.name+"</option>");
  }
  %>
</select>
</div>
<div class="col-md-11 col-md-offset-1">
<select class="form-control" name="category-primary" size="1" id="second-category-primary">
</select>
</div>
</div>
</div>
<!--PERIODO DE COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2 item">
<h4>Selecione o período.</h4>
<div class="col-md-3 col-md-offset-2">
<div class="title-topic">Janeiro de:</div>
<select class="form-control" name="category-tertiary" size="1" id="category-second">
  <option>2010</option>
  <option>2011</option>
</select>
</div>
<div class="col-md-3 col-md-offset-2">
<div class="title-topic">Até Dezembro:</div>
<select class="form-control" name="category-tertiary" size="1" id="category-second">
  <option>2010</option>
  <option>2011</option>
</select>
</div>
</div>
<!--RESULTADOS DA COMPARAÇÃO-->
<div class="col-md-7 col-md-offset-2">
<div class="row">
<div id="resultado-category-01" class="col-md-5 col-md-offset">
<div class="title-topic text-center"><strong>Gasto Total:</strong></div>
<input type="text" value="R$0" class="text-danger" disabled="disabled"></input>
</div>
<div id="resultado-category-02" class="col-md-5 col-md-offset-2">
<div class="title-topic text-center"><strong>Gasto Total:</strong></div>
<input type="text" value="R$0" class="text-danger" disabled="disabled"></input>
</div>
</div>
</div>
<!--BOTÃO - COMPARAR-->
<a name="resultado"></a>
<div class="col-md-7 col-md-offset-2">
<button class="btn btn-success" onclick="makeVisible('resultado-category-01');makeVisible('resultado-category-02')" type="button" title="Clique para comparar os valores gastos no orçamento federal.">Comparar</button>
<button class="btn btn-danger col-md-offset-1" onclick="makeClean('resultado-category-01');makeClean('resultado-category-02')" type="button" title="Clique para limpar os resultados.">Limpar</button>
</div>
</section>
<footer>
</footer>
</div>
</body>
</html>
