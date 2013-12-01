package com.hackathon.comparadorloa;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

public class SubFuncaoServlet extends HttpServlet {

	private static final String SUBFUNCAO_URL = "http://orcamento.dados.gov.br/sparql/?default-graph-uri=&query=SELECT+%%3FsubfuncaoCodigo+%%3FsubfuncaoNome+WHERE+%%7B%%0D%%0A%%3Fi+loa%%3AtemSubfuncao+%%3Fsubfuncao+.%%0D%%0A%%3Fsubfuncao+rdf%%3Alabel+%%3FsubfuncaoNome+.%%0D%%0A%%3Fsubfuncao+loa%%3Acodigo+%%3FsubfuncaoCodigo+.%%0D%%0A%%3Fi+loa%%3AtemFuncao+%%3Ffuncao+.%%0D%%0A%%3Ffuncao+loa%%3Acodigo+%%22%s%%22+.%%0D%%0A%%7DGroup+By+%%3FsubfuncaoCodigo+Order+By+%%3FsubfuncaoNome&debug=on&timeout=&format=json&save=display&fname=";
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String funcao = req.getParameter("Funcao").replace(' ', '+');
		URL url = new URL(String.format(SUBFUNCAO_URL, funcao));
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestProperty("Accept-Charset", "UTF-8");
		conn.setConnectTimeout(60000);
		conn.setRequestMethod("GET");
		conn.connect();
		String data = Util.convertStreamToString(conn.getInputStream());
		JSONArray json;
		List<Subfuncao> subfuncoes = null;
		try {
			json = new JSONObject(data).getJSONObject("results").getJSONArray("bindings");
			subfuncoes = new ArrayList<Subfuncao>();
			for(int i = 0; i < json.length(); i++){
				JSONObject jsonObject = json.getJSONObject(i);
				subfuncoes.add(new Subfuncao(jsonObject.getJSONObject("subfuncaoCodigo").getString("value"),jsonObject.getJSONObject("subfuncaoNome").getString("value")));
			}
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		PrintWriter out = resp.getWriter();
		for(Subfuncao subfuncao : subfuncoes)
			out.println("<option value=\""+subfuncao.id+"\">"+subfuncao.name+"</option>");
	}
}
