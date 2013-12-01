package com.hackathon.comparadorloa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

@SuppressWarnings("serial")
public class ComparadorLOAServlet extends HttpServlet {

	private static final String FUNCAO_URL = "http://orcamento.dados.gov.br/sparql/?default-graph-uri=&query=SELECT+%3FfuncaoCodigo+%3FfuncaoNome+WHERE+%7B%0D%0A%3Fi+loa%3AtemFuncao+%3Ffuncao+.%0D%0A%3Ffuncao+rdf%3Alabel+%3FfuncaoNome+.%0D%0A%3Ffuncao+loa%3Acodigo+%3FfuncaoCodigo+.%0D%0A%7DGroup+By+%3FfuncaoCodigo+Order+By+%3FfuncaoNome&debug=on&timeout=&format=json&save=display&fname=";

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		URL url = new URL(FUNCAO_URL);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestProperty("Accept-Charset", "iso-8859-1");
		conn.setConnectTimeout(60000);
		conn.setRequestMethod("GET");
		conn.connect();
		String data = Util.convertStreamToString(conn.getInputStream());
		JSONArray json;
		List<Funcao> funcoes = null;
		try {
			json = new JSONObject(data).getJSONObject("results").getJSONArray("bindings");
			funcoes = new ArrayList<Funcao>();
			for(int i = 0; i < json.length(); i++){
				JSONObject jsonObject = json.getJSONObject(i);
				funcoes.add(new Funcao(jsonObject.getJSONObject("funcaoCodigo").getString("value"), jsonObject.getJSONObject("funcaoNome").getString("value")));
			}
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("Funcoes", funcoes);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}


}
