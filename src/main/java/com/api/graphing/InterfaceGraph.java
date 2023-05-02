package com.api.graphing;

import java.util.ArrayList;
import java.util.List;

public class InterfaceGraph {
	String label;
	String fillColor;
	String strokeColor;
	String pointColor;
	String pointStrokeColor;
	String pointHighlightFill;
	String pointHighlightStroke;
	List<Integer> data = new ArrayList<Integer>();
	
	public InterfaceGraph(){
		
	}
	public InterfaceGraph(String interf){
		if(interf.equalsIgnoreCase("lan")){
			this.fillColor = "rgba(255, 0, 0, 0)";
			this.strokeColor = "rgb(255, 0, 0)";
			this.pointColor = "rgb(255, 0, 0)";
			this.pointStrokeColor = "#c1c7d1";
			this.pointHighlightFill = "#fff";
			this.pointHighlightStroke = "rgb(220,220,220)";
		}
		else if (interf.equalsIgnoreCase("wan")) {
			this.fillColor = "rgba(243,156,18, 0)";
			this.strokeColor = "rgb(243,156,18)";
			this.pointColor = "rgb(243,156,18)";
			this.pointStrokeColor = "#c1c7d1";
			this.pointHighlightFill = "#fff";
			this.pointHighlightStroke = "rgb(220,220,220)";
		}
		
		else if (interf.equalsIgnoreCase("wan1")){
			this.fillColor = "rgba(0,192,239, 0)";
			this.strokeColor = "rgb(0,192,239)";
			this.pointColor = "rgb(0,192,239)";
			this.pointStrokeColor = "#c1c7d1";
			this.pointHighlightFill = "#fff";
			this.pointHighlightStroke = "rgb(220,220,220)";
		}
		else if(interf.equalsIgnoreCase("wan2")){
			this.fillColor = "rgba(210, 214, 222, 0)";
			this.strokeColor = "rgb(210, 214, 222)";
			this.pointColor = "rgb(210, 214, 222)";
			this.pointStrokeColor = "#c1c7d1";
			this.pointHighlightFill = "#fff";
			this.pointHighlightStroke = "rgb(220,220,220)";
		}
		else if (interf.equalsIgnoreCase("wan3")){
			this.fillColor = "rgba(60,141,188, 0)";
			this.strokeColor = "rgb(60,141,188)";
			this.pointColor = "rgb(60,141,188)";
			this.pointStrokeColor = "#c1c7d1";
			this.pointHighlightFill = "#fff";
			this.pointHighlightStroke = "rgb(220,220,220)";
		}
		else if (interf.equalsIgnoreCase("Master")){
			this.fillColor = "rgba(194,125,14, 0)";
			this.strokeColor = "rgb(194,125,14)";
			this.pointColor = "rgb(194,125,14)";
			this.pointStrokeColor = "#c1c7d1";
			this.pointHighlightFill = "#fff";
			this.pointHighlightStroke = "rgb(220,220,220)";
		}
		
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getFillColor() {
		return fillColor;
	}

	public void setFillColor(String fillColor) {
		this.fillColor = fillColor;
	}

	public String getStrokeColor() {
		return strokeColor;
	}

	public void setStrokeColor(String strokeColor) {
		this.strokeColor = strokeColor;
	}

	public String getPointColor() {
		return pointColor;
	}

	public void setPointColor(String pointColor) {
		this.pointColor = pointColor;
	}

	public String getPointStrokeColor() {
		return pointStrokeColor;
	}

	public void setPointStrokeColor(String pointStrokeColor) {
		this.pointStrokeColor = pointStrokeColor;
	}

	public String getPointHighlightFill() {
		return pointHighlightFill;
	}

	public void setPointHighlightFill(String pointHighlightFill) {
		this.pointHighlightFill = pointHighlightFill;
	}

	public String getPointHighlightStroke() {
		return pointHighlightStroke;
	}

	public void setPointHighlightStroke(String pointHighlightStroke) {
		this.pointHighlightStroke = pointHighlightStroke;
	}

	public List<Integer> getData() {
		return data;
	}

	public void setData(List<Integer> data) {
		this.data = data;
	}
	
	
}
