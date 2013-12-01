package com.hackathon.comparadorloa;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.text.NumberFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

public class CompararServlet extends HttpServlet {

	private static final String COMPARAR_URL = "http://orcamento.dados.gov.br/sparql/?default-graph-uri=&query=SELECT+%%3FfuncaoCodigo+%%3FsubfuncaoCodigo+%%28sum%%28%%3Fval%%29+as+%%3Fpago%%29+WHERE+%%7B%%0D%%0A%%3Fi+loa%%3AtemFuncao+%%3Ffuncao+.+%%0D%%0A%%3Ffuncao+rdf%%3Alabel+%%3FfuncaoNome+.++%%0D%%0A%%3Ffuncao+loa%%3Acodigo+%%3FfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AtemSubfuncao+%%3Fsubfuncao+.++%%0D%%0A%%3Fsubfuncao+rdf%%3Alabel+%%3FsubfuncaoNome+.+%%0D%%0A%%3Fsubfuncao+loa%%3Acodigo+%%3FsubfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AvalorPago+%%3Fval+.%%0D%%0A%%3Fi+loa%%3AtemExercicio+%%3Fexercicio+.%%0D%%0A%%3Fexercicio+loa%%3Aidentificador+%%3Fano+.%%0D%%0AFILTER+%%28%%28%%28%%3FfuncaoCodigo+%%3D+%%22%s%%22+%%26%%26+%%3FsubfuncaoCodigo+%%3D+%%22%s%%22%%29+%%7C%%7C+%%28%%3FfuncaoCodigo+%%3D+%%22%s%%22+%%26%%26+%%3FsubfuncaoCodigo+%%3D+%%22%s%%22%%29%%29+%%26%%26+%%3Fano+%%3E%%3D+%s+%%26%%26+%%3Fano+%%3C%%3D+%s%%29+.%%0D%%0A%%7D&debug=on&timeout=&format=json&save=display&fname=";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		int index;
		String funcao1 = req.getParameter("Funcao1");
		URL url = new URL(String.format(COMPARAR_URL, funcao1, req.getParameter("Subfuncao1"), req.getParameter("Funcao2"), req.getParameter("Subfuncao2"), req.getParameter("inicio"), req.getParameter("fim")));
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
			
			out.print(converteMoeda((valores[0] != null ? valores[0] : "0"))+"|");
			out.print(converteMoeda((valores[1] != null ? valores[1] : "0")));
			
		} catch (JSONException e) {
			e.printStackTrace();
			out.print("R$ 0,00|R$ 0,00");
		}
	}

	private String converteMoeda(String valor) {
		return NumberFormat.getCurrencyInstance().format(Double.parseDouble(valor));
	}
}
