package com.hackathon.comparadorloa;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

public class CompararServlet extends HttpServlet {

	private static final String COMPARAR_TWO_URL = "http://orcamento.dados.gov.br/sparql/?default-graph-uri=&query=SELECT+%%3FfuncaoCodigo+%%28sum%%28%%3Fval%%29+as+%%3Fpago%%29+WHERE+%%7B%%0D%%0A%%3Fi+loa%%3AtemFuncao+%%3Ffuncao+.+%%0D%%0A%%3Ffuncao+rdf%%3Alabel+%%3FfuncaoNome+.++%%0D%%0A%%3Ffuncao+loa%%3Acodigo+%%3FfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AtemSubfuncao+%%3Fsubfuncao+.++%%0D%%0A%%3Fsubfuncao+rdf%%3Alabel+%%3FsubfuncaoNome+.+%%0D%%0A%%3Fsubfuncao+loa%%3Acodigo+%%3FsubfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AvalorPago+%%3Fval+.%%0D%%0A%%3Fi+loa%%3AtemExercicio+%%3Fexercicio+.%%0D%%0A%%3Fexercicio+loa%%3Aidentificador+%%3Fano+.%%0D%%0AFILTER+%%28%%28%%28%%3FfuncaoCodigo+%%3D+%%22%s%%22%s%%29+%%7C%%7C+%%28%%3FfuncaoCodigo+%%3D+%%22%s%%22%s%%29%%29+%%26%%26+%%3Fano+%%3E%%3D+%s+%%26%%26+%%3Fano+%%3C%%3D+%s%%29+.%%0D%%0A%%7D&debug=on&timeout=&format=json&save=display&fname=";
	private static final String COMPARAR_ONE_URL = "http://orcamento.dados.gov.br/sparql/?default-graph-uri=&query=SELECT+%%3FfuncaoCodigo+%%28sum%%28%%3Fval%%29+as+%%3Fpago%%29+WHERE+%%7B%%0D%%0A%%3Fi+loa%%3AtemFuncao+%%3Ffuncao+.+%%0D%%0A%%3Ffuncao+rdf%%3Alabel+%%3FfuncaoNome+.++%%0D%%0A%%3Ffuncao+loa%%3Acodigo+%%3FfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AtemSubfuncao+%%3Fsubfuncao+.++%%0D%%0A%%3Fsubfuncao+rdf%%3Alabel+%%3FsubfuncaoNome+.+%%0D%%0A%%3Fsubfuncao+loa%%3Acodigo+%%3FsubfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AvalorPago+%%3Fval+.%%0D%%0A%%3Fi+loa%%3AtemExercicio+%%3Fexercicio+.%%0D%%0A%%3Fexercicio+loa%%3Aidentificador+%%3Fano+.%%0D%%0AFILTER+%%28%%3FfuncaoCodigo+%%3D+%%22%s%%22%s+%%26%%26+%%3Fano+%%3E%%3D+%s+%%26%%26+%%3Fano+%%3C%%3D+%s%%29+.%%0D%%0A%%7D&debug=on&timeout=&format=json&save=display&fname=";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		resp.setContentType("text/html;charset=UTF-8");
		int index;
		String funcao1 = req.getParameter("Funcao1");
		String funcao2 = req.getParameter("Funcao2");
		String subfuncao1 = req.getParameter("Subfuncao1");
		String subfuncao2 = req.getParameter("Subfuncao2");
		if(funcao1.equals(funcao2)){
			makeTwoRequests(funcao1, subfuncao1, funcao2, subfuncao2, req, resp);
			return;
		}
		URL url = new URL(String.format(COMPARAR_TWO_URL, funcao1, subfuncao1.equals("0") || subfuncao1.isEmpty() ? "" : "+%26%26+%3FsubfuncaoCodigo+%3D+%22"+subfuncao1+"%22", funcao2, subfuncao2.equals("0") || subfuncao2.isEmpty()  ? "" : "+%26%26+%3FsubfuncaoCodigo+%3D+%22"+subfuncao2+"%22", req.getParameter("inicio"), req.getParameter("fim")));
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestProperty("Accept-Charset", "UTF-8");
		conn.setConnectTimeout(60000);
		conn.setRequestMethod("GET");
		conn.connect();
		String data = Util.convertStreamToString(conn.getInputStream());
		PrintWriter out = resp.getWriter();
		try {
			JSONArray json = new JSONObject(data).getJSONObject("results").getJSONArray("bindings");
			String[] valores = new String[2];
			if(json.length() > 0){
				JSONObject jsonObject = json.getJSONObject(0);
				index = funcao1.equals(jsonObject.getJSONObject("funcaoCodigo").getString("value")) ? 0 : 1;
				valores[index] = jsonObject.getJSONObject("pago").getString("value");
			}
			if(json.length() > 1){
				JSONObject jsonObject = json.getJSONObject(1);
				index = funcao1.equals(jsonObject.getJSONObject("funcaoCodigo").getString("value")) ? 0 : 1;
				valores[index] = jsonObject.getJSONObject("pago").getString("value");
			}
			
			double valor1 = Double.parseDouble(valores[0] != null ? valores[0] : "0");
			out.print(converteMoeda(valor1));
			double valor2 = Double.parseDouble(valores[1] != null ? valores[1] : "0");
			out.print("|"+converteMoeda(valor2));
			double valor3 = Math.abs(valor1-valor2);
			out.print("|"+converteMoeda(valor3)+getProportion(valor1, valor2));
			out.print("|"+req.getParameter("Funcao1Nome")+":");
			out.print("|"+req.getParameter("Funcao2Nome")+":");
			
		} catch (JSONException e) {
			e.printStackTrace();
			out.print("R$ 0,00|R$ 0,00|R$ 0,00|Gasto total:|Gasto total:");
		}
	}

	private String getProportion(double valor1, double valor2) {
		if(valor1 == 0 || valor2 == 0)
			return "";
		DecimalFormat df = new DecimalFormat("#,###.##");  
		if(valor1 > valor2)
			return " / " + df.format(valor1/valor2) + "x";
		return " / " + df.format(valor2/valor1) + "x";
	}

	private String converteMoeda(double valor) {
		return "R"+NumberFormat.getCurrencyInstance(Locale.US).format(valor).replace(',', '*').replace('.', ',').replace('*', '.'); 
		//gambiarra feita porque locale BR sai BRL e queremos R$...
	}
	
	private void makeTwoRequests(String funcao1, String subfuncao1,
			String funcao2, String subfuncao2, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		URL url = new URL(String.format(COMPARAR_ONE_URL, funcao1, subfuncao1.equals("0") || subfuncao1.isEmpty() ? "" : "+%26%26+%3FsubfuncaoCodigo+%3D+%22"+subfuncao1+"%22", req.getParameter("inicio"), req.getParameter("fim")));
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestProperty("Accept-Charset", "UTF-8");
		conn.setConnectTimeout(60000);
		conn.setRequestMethod("GET");
		conn.connect();
		String data = Util.convertStreamToString(conn.getInputStream());
		PrintWriter out = resp.getWriter();
		int index;
		try {
			JSONArray json = new JSONObject(data).getJSONObject("results").getJSONArray("bindings");
			String[] valores = new String[2];
			if(json.length() > 0){
				JSONObject jsonObject = json.getJSONObject(0);
				index = 0;
				valores[index] = jsonObject.getJSONObject("pago").getString("value");
			}
			url = new URL(String.format(COMPARAR_ONE_URL, funcao2, subfuncao2.equals("0") || subfuncao2.isEmpty() ? "" : "+%26%26+%3FsubfuncaoCodigo+%3D+%22"+subfuncao2+"%22", req.getParameter("inicio"), req.getParameter("fim")));
			conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("Accept-Charset", "UTF-8");
			conn.setConnectTimeout(60000);
			conn.setRequestMethod("GET");
			conn.connect();
			data = Util.convertStreamToString(conn.getInputStream());
			json = new JSONObject(data).getJSONObject("results").getJSONArray("bindings");
			if(json.length() > 0){
				JSONObject jsonObject = json.getJSONObject(0);
				index = 1;
				valores[index] = jsonObject.getJSONObject("pago").getString("value");
			}
			
			double valor1 = Double.parseDouble(valores[0] != null ? valores[0] : "0");
			out.print(converteMoeda(valor1));
			double valor2 = Double.parseDouble(valores[1] != null ? valores[1] : "0");
			out.print("|"+converteMoeda(valor2));
			double valor3 = Math.abs(valor1-valor2);
			out.print("|"+converteMoeda(valor3)+getProportion(valor1, valor2));
			out.print("|"+req.getParameter("Funcao1Nome")+":");
			out.print("|"+req.getParameter("Funcao2Nome")+":");
			
		} catch (JSONException e) {
			e.printStackTrace();
			out.print("R$ 0,00|R$ 0,00|R$ 0,00|Gasto total:|Gasto total:");
		} 
	}
}
