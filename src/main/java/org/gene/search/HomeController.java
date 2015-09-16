package org.gene.search;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * This is the Home controller that is called at the very first.
 * 
 * @author Aniket Nawani
 */
@Controller
@RequestMapping("/")
public class HomeController {

	private final Logger logger = Logger.getLogger(this.getClass());

	/**
	 * To display the home page (landing page).
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String home(ModelMap model) {

		if (logger.isDebugEnabled()) {
			logger.debug("Entering home(model)");
		}
		try {
			model.addAttribute("", "");
		} catch (Exception e) {
			logger.error("An exception has occured " + e.getMessage());
			model.addAttribute("errorInfo",
					"An error has occured: " + e.getMessage());
			return "error";
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Leaving home(model) ");
		}
		return "home";
	}

	/*
	 * This is the method which looks if the gene entered is a cancer gene It
	 * also checks if the gene has pathways related to cancer It then redirects
	 * the information to the view
	 */
	@RequestMapping(value = "/pathway")
	public ModelAndView pathway(@RequestParam String geneName,
			HttpServletRequest request) throws JSONException, Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<String> pathwayList = new ArrayList<String>();
		ArrayList<String> finalList = new ArrayList<String>();
		int check = 0;
		// setting the session attribute
		request.getSession().setAttribute("geneName", geneName);
		String jsonURL = "http://togows.dbcls.jp/entry/pathway/hsa05200/genes.json";
		// reading json file
		JSONObject json = new JSONObject(readUrl(jsonURL));
		String[] jsonArr = JSONObject.getNames(json);
		for (String item : jsonArr) {
			String value = (String) json.get(item);
			// checking if the user entered gene is present in the json file
			if (value.toLowerCase().contains(geneName.toLowerCase())) {
				// calling the pathwayCancer method to get the list of pathways
				// for that gene
				pathwayList = pathwayCancer(item);
				check = 0;
			} else {
				check = 1;
			}
		}

		// check if the there are pathways related to that gene
		if (pathwayList.size() == 0) {
			map.put("info", "no");
		} else {
			map.put("info", "yes");
		}
		// insert the data to the list
		for (String item : pathwayList) {
			finalList.add(item);
			finalList.add(item.split(":")[0].trim());
			finalList.add("");
		}

		map.put("geneName", geneName);
		map.put("finalList", finalList);
		return new ModelAndView("pathwayPage", "map", map);
	}


	// This is the method to get the pathways associated with the user-entered
	// cancer gene
	public ArrayList<String> pathwayCancer(String geneId) throws JSONException,
			Exception {
		ArrayList<String> pathwayList = new ArrayList<String>();
		String httpURL = "http://togows.dbcls.jp/entry/genes/hsa:" + geneId
				+ ".json";
		JSONObject json = new JSONObject(readUrl(httpURL));
		JSONObject pathways = (JSONObject) json.get("pathways");
		String[] pathwayNames = JSONObject.getNames(pathways);
		for (String item : pathwayNames) {
			pathwayList.add(item + ":" + pathways.get(item));
		}
		return pathwayList;
	}

	
	// This is the method to read the url and return the data as string
	private String readUrl(String urlString) throws Exception {
		BufferedReader reader = null;
		try {
			URL url = new URL(urlString);
			reader = new BufferedReader(new InputStreamReader(url.openStream()));
			StringBuffer buffer = new StringBuffer();
			int read;
			char[] chars = new char[1024];
			while ((read = reader.read(chars)) != -1)
				buffer.append(chars, 0, read);
			String str = buffer.toString().substring(1);
			str = str.substring(0, str.length() - 1);
			return str;
		} catch (Exception e) {
			return "The page is not working";
		} finally {
			if (reader != null)
				reader.close();
		}
	}

}
