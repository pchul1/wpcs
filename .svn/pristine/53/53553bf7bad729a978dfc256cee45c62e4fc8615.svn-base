<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : sectionPoint.jsp
  * @Description : Section Point 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.20     k        최초 생성
  *
  * author k
  * since 2010.05.20
  *  
  * Copyright (C) 2010 by k  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>	
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAAUqzKskvQXw_UTKpILtz0BRqs7OO1Tb_cumvo_a2JFiOp5iBHRSME5u3O-Ts911e0yjTpD4PjiNW5g" type="text/javascript"></script>
    <script src="http://serverapi.arcgisonline.com/jsapi/gmaps/?v=1.6" type="text/javascript" ></script>
    <!--포팅시 아래의 도메인별 구글키의 변경이 필요합니다. -->
    <!--http://www.watertms.or.kr:8080 : ABQIAAAAAUqzKskvQXw_UTKpILtz0BSiOMSd4UtbBOzDpvG2FihVLiCnJRTRZTnPp7LJJwNnfiOH7iRZT97aLg-->
    <!--http://www.watertms.or.kr : ABQIAAAAAUqzKskvQXw_UTKpILtz0BRh65fw2Kxj1BIR7J7H70cBjtzx7hSqIHfLy7XBbpwf_EdihwInIGtqCw-->
    <!--http://www.waterkorea.or.kr:8080 : ABQIAAAAAUqzKskvQXw_UTKpILtz0BRqs7OO1Tb_cumvo_a2JFiOp5iBHRSME5u3O-Ts911e0yjTpD4PjiNW5g-->
    <!--http://www.waterkorea.or.kr : ABQIAAAAAUqzKskvQXw_UTKpILtz0BQXHMXAZIIXSp0UaSHdDYhAeGul3BQy7aUdJ-XNu3Mp0zfHROBvN2NJpQ-->
    
    <!-- <script src="http://gmaps-utility-library.googlecode.com/svn/trunk/progressbarcontrol/1.0/src/progressbarcontrol.js" type="text/javascript" ></script> -->
		
    <script type="text/javascript">
	    var hostIP = "115.93.37.67";//포팅시 변경해주십시오.//GIS서버:10.101.164.223
	    var gmap = null;
	    var dynMapOv = null;
	    var queryTask;
	    var geocoder = null;
	    var dynamicMap = null;
	    var layers = null ;
	    var showLayerArray = [1,2,3,4,8,11];
	    
	    var mapExtension, identifyTask, layers, overlays;
	    
	    function initialize() {
	      //Load Google Maps
	      gmap = new GMap2(document.getElementById("gmap"));
		  gmap.setMapType(G_HYBRID_MAP);//G_NORMAL_MAP, G_SATELLITE_MAP, G_HYBRID_MAP, G_PHYSICAL_MAP
		  gmap.addMapType(G_PHYSICAL_MAP);
		  gmap.addControl(new GLargeMapControl());
	      var topRight = new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(5,5));
	      gmap.addControl(new GMenuMapTypeControl(),topRight);
	      gmap.addControl(new GOverviewMapControl());
	      gmap.setCenter(new GLatLng(36.635412,128.287354),7);
	      gmap.enableScrollWheelZoom();
	
	      //create custom dynamic layer
	      //esri.arcgis.gmaps.DynamicMapServiceLayer(url,esri.arcgis.gmaps.ImageParameters?,opacity?,callback?);
	      dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer("http://"+hostIP+"/rest/services/test/MapServer", null, 0.75, dynmapcallback);
	      geocoder = new GClientGeocoder();
	      //executeQueryinit();
	      
	      layers=dynamicMap.getVisibleLayers() ;
		  
		  mapExtension = new esri.arcgis.gmaps.MapExtension(gmap);
		  identifyTask = new esri.arcgis.gmaps.IdentifyTask("http://"+hostIP+"/rest/services/test/MapServer");
		  GEvent.addListener(gmap, "click", identify);
/*		
		  function legend() {}
		  legend.prototype = new GControl;
		  legend.prototype.initialize = function(gmap) {
		    var me = this;
		    me.panel = document.getElementById("legend");
		    me.panel.style.border = "1px solid gray";
		    me.panel.style.background = "white";
		    gmap.getContainer().appendChild(me.panel);
		    return me.panel;
		  };
	
		  legend.prototype.getDefaultPosition = function() {
		    return new GControlPosition(
		        G_ANCHOR_TOP_RIGHT, new GSize(100, 5));
		  };
	
		  legend.prototype.getPanel = function() {
		    return me.panel;
		  }
		  gmap.addControl(new legend());
	
		  function legendDetail() {}
		  legendDetail.prototype = new GControl;
		  legendDetail.prototype.initialize = function(gmap) {
		    var me = this;
		    me.panel = document.getElementById("legendDetail");
		    me.panel.style.border = "1px solid gray";
		    me.panel.style.background = "white";
		    gmap.getContainer().appendChild(me.panel);
		    return me.panel;
		  };
	
		  legendDetail.prototype.getDefaultPosition = function() {
		    return new GControlPosition(
		        G_ANCHOR_TOP_RIGHT, new GSize(100, 30));
		  };
	
		  legendDetail.prototype.getPanel = function() {
		    return me.panel;
		  }
		  gmap.addControl(new legendDetail());
*/	
		  //getAreaMoveDisable(32.9902355,124.453125,38.891032,130.979003);
		  getAreaMoveDisable(34.07086232376631,125.70556640625,38.58252615935333,129.55078125);
		  getAreaLevelDisable(7,15);
		  //LegendControl.prototype = new GControl();
		  //LegendControl = new GControl();
		  //gmap.addControl(new LegendControl());
	      //var progressbarOptions = {width:150, loadstring:"로딩중..."}
	      //var progressBar = new ProgressbarControl(gmap,progressbarOptions); 
	      //progressBar = new ProgressbarControl(gmap, {width:150}); 
	      //progressBar.start(100);
	      //setTimeout('dynmapcallback', 10);
	      //setTimeout('addMarkers()', 10);
	    }
	    
		/*
		function addMarkers(){
			num = num+1;
			progressBar.updateLoader(1);
			var marker = batch.pop();
			gmap.addOverlay(marker);
			if(num>maxNum){
				setTimeout('addMarkers()', 10);
			}else{
				progressBar.remove();
			};
		}
		*/
		
	    function dynmapcallback(groundov) {
	      //Add groundoverlay to map using gmap.addOverlay()
	      gmap.addOverlay(groundov);
	      dynMapOv = groundov;
	    }
	
	    function executeQuery(minorVal) {
	        gmap.clearOverlays();
	        //gmap.removeOverlay(geom);
	        dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer("http://"+ hostIP +"/rest/services/test/MapServer", null, 0.75, dynmapcallback);
			if(minorVal == '-1'){}
			else{
		        queryTask = new esri.arcgis.gmaps.QueryTask("http://"+ hostIP +"/rest/services/test/MapServer/2");
		        if(minorVal){
			        // create the query
			        var query = new esri.arcgis.gmaps.Query();
			        query.where = "MIN_OR = '" + minorVal + "'";
			        query.outFields = ["taksu.NAME", "MIN_OR"];
			
			        // execute the query
			        queryTask.execute(query, false, function(featureSet, error) { // callback
			          // display error message (if any)
			          if (error) {
			            alert("Error " + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
			            return;
			          }
			
			          // add the feature set to the map
			          var features = featureSet.features, geometry, attributes;
			          for (var i = 0; i < features.length; i++) { // process each county in the feature set
			            geometry = features[i].geometry;
			            attributes = features[i].attributes;
			            for (var j = 0; j < geometry.length; j++) { // Feature.geometry is an array of GPolygon/GPolyline/GMarker
			              var geom = geometry[j];
			              GEvent.addListener(geom, "mouseover", GEvent.callbackArgs(geom, onMouseOverFunc, attributes));
			              GEvent.addListener(geom, "mouseout", onMouseOutFunc);
			              
			              gmap.addOverlay(geom);
			            }
			          }
			          // Note that we are not using the MapExtension class here to add the FeatureSet
			          // to the map as it supports only "click-to-open-infowindow" workflow
			        });
		        }else{};
			}
	      }
	
	    function executeQueryinit() {
		        queryTask = new esri.arcgis.gmaps.QueryTask("http://"+ hostIP +"/rest/services/test/MapServer/2");
			        // create the query
			        var query = new esri.arcgis.gmaps.Query();
			        query.where = "1=1";
			        query.outFields = ["taksu.NAME", "MIN_OR", "MIN_VL", "MIN_TIME"];
			
			        // execute the query
			        queryTask.execute(query, false, function(featureSet, error) { // callback
			          // display error message (if any)
			          if (error) {
			            alert("Error " + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
			            return;
			          }
	
			        //-- Create our "tiny" marker icon
			        var blueIcon = new GIcon();
			        blueIcon.image = "http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png";    
			        //blueIcon.shadow = "";           
			        //-- Set up our GMarkerOptions object
			        markerOptions = { icon:blueIcon };
	
			        
			          // add the feature set to the map
			          var features = featureSet.features, geometry, attributes;
			          for (var i = 0; i < features.length; i++) { // process each county in the feature set
			            geometry = features[i].geometry;
			            attributes = features[i].attributes;
			            for (var j = 0; j < geometry.length; j++) { // Feature.geometry is an array of GPolygon/GPolyline/GMarker
			              var geom = geometry[j];
			              GEvent.addListener(geom, "mouseover", GEvent.callbackArgs(geom, onMouseOverFunc, attributes));
			              GEvent.addListener(geom, "mouseout", onMouseOutFunc);   
			              gmap.addOverlay(geom);
			              //geom.setImage("img/test.png"); 
			              //geom.setImage("http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png");
			              
			              /*
			              var valX = parseFloat(geom.getLatLng().x);
			              var valY = parseFloat(geom.getLatLng().y);
			              var marker = new GMarker(new GLatLng(valY, valX), markerOptions);
			              gmap.addOverlay(marker);
			              */
			              
			            }
			          }
			          //alert(geom.location);
			          //alert(geom.getLatLng().x+","+geom.getLatLng().y);
			          // Note that we are not using the MapExtension class here to add the FeatureSet
			          // to the map as it supports only "click-to-open-infowindow" workflow
			        });
	      }
	    
	      // show info window for the county when the user moves the mouse over it
	      function onMouseOverFunc(attributes) {
	        // highlight the county
	        //var polygon = this;
	        var point = this;
	        var stateVal;
	        //polygon.setFillStyle({ color: "#FF0000" });
	       // polygon.setStrokeStyle({ color: "#FF0000" });
	        // show the infowindow
	        //var html = "<b>Name:</b> " + attributes["NAME"] + "<br/><b>POP2007:</b> " + attributes["MIN_OR"];
	        if (attributes["MIN_OR"] == '0'){stateVal = "정상";}
	        else if (attributes["MIN_OR"] == '1'){stateVal = "관심";}
	        else if (attributes["MIN_OR"] == '2'){stateVal = "주의";}
	        else if (attributes["MIN_OR"] == '3'){stateVal = "경계";}
	        else if (attributes["MIN_OR"] == '4'){stateVal = "심각";}
	        else {stateVal = "미수집";}
	        var html = "<div><b>명칭:</b> " + attributes["taksu.NAME"] + "<br/><b>상태값:</b> " + stateVal+"<br/><b>수집시간:</b> "+attributes["MIN_TIME"]+"<br/><b>측정값:</b> "+attributes["MIN_VL"]+"</div>";
	        //gmap.openInfoWindowHtml(polygon.getBounds().getCenter(), html);
	        gmap.openInfoWindowHtml(point.getPoint(), html);//nw
	      }
	
	      // close info window when the user moves the mouse out of a county
	      function onMouseOutFunc() {
	        // unhighlight the county
	        //var polygon = this;
	        var point = this;
	        //polygon.setFillStyle({ color: "#0000FF" });
	        //polygon.setStrokeStyle({ color: "#0000FF" });
	
	        // hide the infowindow
	        gmap.closeInfoWindow();
	      }
	
	      function identify(overlay, latLng) {
	          if (overlay) return;
	          //clearResults();
	
	          // set the identify parameters
	          var identifyParameters = new esri.arcgis.gmaps.IdentifyParameters();
	          identifyParameters.geometry = latLng; // location where the user clicked on the map
	          identifyParameters.tolerance = 3;
	          identifyParameters.layerIds = [ 1, 2, 3, 9, 10 ];
	          identifyParameters.layerOption = "all";
	          identifyParameters.bounds = gmap.getBounds();
	          var mapSize = gmap.getSize();
	          identifyParameters.width = mapSize.width;
	          identifyParameters.height = mapSize.height;
	
	          // execute the identify operation
	          identifyTask.execute(identifyParameters, function(response, error) { // function to be called when the result is available
	            // display error message (if any) and return
	            if (hasErrorOccurred(error)) return;
	
	            // note that the location where the user clicked on the map (latLng) is visible in this function through closure
	            addResultToMap(response, latLng);
	          });
	        }
	      function addResultToMap(response, point) {
	          // aggregate the result per map service layer
	          var idResults = response.identifyResults;
	          //alert(idResults.length);
	          if (idResults.length > 0 ){
		          var selectLayerID = idResults[0].layerId;
		          //layers = { "2": [], "3": [], "11": [], "12": [] };
		          //layers = { "\""+selectLayerID+"\"": []};
		          if (selectLayerID == '1'){
		        	  layers = { "1": []};
		          }else if (selectLayerID == '2'){
		        	  layers = { "2": []};
		          }else if (selectLayerID == '3'){
		        	  layers = { "3": []};
		          }else if (selectLayerID == '9'){
		        	  layers = { "9": []};
		          }else if (selectLayerID == '10'){
		        	  layers = { "10": []};
		          }else{};
	
		          //for (var i = 0; i < idResults.length; i++) {
		            var result = idResults[0];
		            layers[result.layerId].push(result);
		          //}
	
		          // create and show the info-window with tabs, one for each map service layer
		          var tabs = [];
		          for (var layerId in layers) {
		            var results = layers[layerId];
		            var count = results.length;
		            var label = "", content = "";
		            switch(layerId) {
		            case "1":
		                label = "수질측정망";
		                content = "결과항목 : <b>" + count + "</b>";
		                if (count == 0) break;
		                //content += "<table class='GISTable' border='1'><th>수질측정망명</th><th>최종수집시간</th><th>측정값</th>";
		                content += "<table class='GISTable' border='1' width=\"210px\"><colgroup><col width=\"80px\" /><col width=\"80px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">수질측정망명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
		                for (var j = 0; j < count; j++) {
		                  var attributes = results[j].feature.attributes;
		                  var selMinVl, selMinTime;
		                  content += "<tr>";
		                  content += "<td><a href='#' onclick='showFeature(" + layerId + "," + j + ")'>" + attributes["BASIN"]  + "_" + attributes["STATION"]  +"</a></td>";
		                  if(attributes["MIN_TIME"] == "" || attributes["MIN_TIME"] == null ||attributes["MIN_TIME"] == "Null"){selMinTime="미수집";}else{selMinTime = attributes["MIN_TIME"].substring(0,4)+"."+attributes["MIN_TIME"].substring(4,6)+"."+attributes["MIN_TIME"].substring(6,8)+"."+attributes["MIN_TIME"].substring(8,10)+":"+attributes["MIN_TIME"].substring(10,12);};
		                  content += "<td>" + selMinTime  + "</td>";
		                  if(attributes["MIN_VL"] == "" || attributes["MIN_VL"] == null ||attributes["MIN_VL"] == "Null"){selMinVl="미수집";}else{selMinVl = attributes["MIN_VL"];};
		                  content += "<td>" + selMinVl + "</td>";
		                  content += "</tr>";
		                }
		                content += "</table>";
		                break;
		              case "2":
		                label = "탁수";
		                content = "결과항목 : <b>" + count + "</b>";
		                if (count == 0) break;
		                content += "<table class='GISTable' border='1'  width=\"230px\"><colgroup><col width=\"80px\" /><col width=\"100px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">탁수명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
		                for (var j = 0; j < count; j++) {
		                  var attributes = results[j].feature.attributes;
		                  var selMinVl, selMinTime;
		                  content += "<tr>";
		                  content += "<td><a href='#' onclick='showFeature(" + layerId + "," + j + ")'>" + attributes["NAME"]  + "</a></td>";
		                  if(attributes["MIN_TIME"] == "" || attributes["MIN_TIME"] == null ||attributes["MIN_TIME"] == "Null"){selMinTime="미수집";}else{selMinTime = attributes["MIN_TIME"].substring(0,4)+"."+attributes["MIN_TIME"].substring(4,6)+"."+attributes["MIN_TIME"].substring(6,8)+"."+attributes["MIN_TIME"].substring(8,10)+":"+attributes["MIN_TIME"].substring(10,12);};
		                  content += "<td>" + selMinTime  + "</td>";
		                  if(attributes["MIN_VL"] == "" || attributes["MIN_VL"] == null ||attributes["MIN_VL"] == "Null"){selMinVl="미수집";}else{selMinVl = attributes["MIN_VL"];};
		                  content += "<td>" + selMinVl + "</td>";
		                  content += "</tr>";
		                }
		                content += "</table>";
		                break;
		              case "3":
		                label = "이동형측정기기";
		                content = "결과항목 : <b>" + count + "</b>";
		                if (count == 0) break;
		                content += "<table class='GISTable'  border='1'  width=\"250px\"><colgroup><col width=\"120px\" /><col width=\"80px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">이동형측정기기명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
		                for (var j = 0; j < count; j++) {
		                  var attributes = results[j].feature.attributes;
		                  var selMinVl, selMinTime;
		                  content += "<tr>";
		                  content += "<td><a href='#' onclick='showFeature(" + layerId + "," + j + ")'>" + attributes["NAME"]  + "</td>";
		                  if(attributes["MIN_TIME"] == "" || attributes["MIN_TIME"] == null ||attributes["MIN_TIME"] == "Null"){selMinTime="미수집";}else{selMinTime = attributes["MIN_TIME"].substring(0,4)+"."+attributes["MIN_TIME"].substring(4,6)+"."+attributes["MIN_TIME"].substring(6,8)+"."+attributes["MIN_TIME"].substring(8,10)+":"+attributes["MIN_TIME"].substring(10,12);};
		                  content += "<td>" + selMinTime  + "</td>";
		                  if(attributes["MIN_VL"] == "" || attributes["MIN_VL"] == null ||attributes["MIN_VL"] == "Null"){selMinVl="미수집";}else{selMinVl = attributes["MIN_VL"];};
		                  content += "<td>" + selMinVl + "</td>";
		                  content += "</tr>";
		                }
		                content += "</table>";
		                break;
		              case "9":
		                label = "산업단지업체";
		                content = "결과항목 : <b>" + count + "</b>";
		                if (count == 0) break;
		                content += "<table class='GISTable'  border='1'  width=\"140px\"><colgroup><col width=\"80px\" /><col width=\"60px\" /></colgroup><th scope=\"col\">업체명</th><th scope=\"col\">설립년도</th>";
		                for (var j = 0; j < count; j++) {
		                  var attributes = results[j].feature.attributes;
		                  content += "<tr>";
		                  content += "<td><a href='#' onclick='showFeature(" + layerId + "," + j + ")'>" + attributes["TI_CO_NM"]  + "</td>";
		                  content += "<td>" + attributes["UP_YMD"]  + "</td>";
		                  content += "</tr>";
		                }
		                content += "</table>";
		                break;
		              case "10":
		                  label = "화학단지업체";
		                  content = "결과항목 : <b>" + count + "</b>";
		                  if (count == 0) break;
		                  content += "<table class='GISTable'  border='1'><colgroup><col width=\"80px\" /><col width=\"60px\" /></colgroup><th scope=\"col\">업체명</th><th scope=\"col\">설립년도</th>";
		                  for (var j = 0; j < count; j++) {
		                    var attributes = results[j].feature.attributes;
		                    content += "<tr>";
		                    content += "<td><a href='#' onclick='showFeature(" + layerId + "," + j + ")'>" + attributes["CO_NM"]  + "</td>";
		                    content += "<td>" + attributes["UP_YMD"]  + "</td>";
		                    content += "</tr>";
		                  }
		                  content += "</table>";
		                  break;
		            }
		            tabs.push(new GInfoWindowTab(label, content));
		          }
		          gmap.openInfoWindowTabsHtml(point, tabs);
	          }else{};
	      }
	      
	      function showFeature(layerId, index) {
	          mapExtension.removeFromMap(overlays);
	          var idResult = layers[layerId][index];
	          overlays = mapExtension.addToMap(idResult, {polygonOptions: { clickable: false}});
	        }
	
	        function addMapServiceLayer(layer, error) {
	          // display error message (if any) and return
	          if (hasErrorOccurred(error)) return;
	
	          // add layer to the map
	          mapExtension.addToMap(layer);
	        }
	        
	      function hasErrorOccurred(error) {
	          if (error) {
	            alert("Error " + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
	            return true;
	          }
	          return false;
	        }
	      
		function mov2(lat, lng){
			gmap.setZoom(14);//setZoom must be 1st.
			gmap.panTo(new GLatLng(lat, lng));
		}
	
		function mov2level(str){
			if(str){
				var fstr = str.split(",");
				var lat = fstr[0];
				var lng = fstr[1];
				var lvl = fstr[2];
				gmap.setZoom(Number(lvl));//setZoom must be 1st.
				gmap.panTo(new GLatLng(lat, lng));
			}
		}
	
		function mov2levelHtml(str, html){
			if(str){
				var fstr = str.split(",");
				var lat = fstr[0];
				var lng = fstr[1];
				var lvl = fstr[2];
				gmap.setZoom(Number(lvl));//setZoom must be 1st.
				gmap.panTo(new GLatLng(lat, lng));
			    
				var marker = new GMarker(new GLatLng(lat, lng), {draggable: true});
	          	gmap.addOverlay(marker);
	          	GEvent.addListener(marker, "dragend", function() {
	            	marker.openInfoWindowHtml(html);
	        	});
	        	GEvent.addListener(marker, "click", function() {
	        		marker.openInfoWindowHtml(html);
	       		});
	      		GEvent.trigger(marker, "click");
			}
		}
	
		function mov2levelHtmlIcon(str, html, iconUrl){
			if(str){
				var fstr = str.split(",");
				var lat = fstr[0];
				var lng = fstr[1];
				var lvl = fstr[2];
				gmap.setZoom(Number(lvl));//setZoom must be 1st.
				gmap.panTo(new GLatLng(lat, lng));
	
				var iconMole = new GIcon(); 
			    iconMole.image = iconUrl;
			    iconMole.iconAnchor = new GPoint(16,11);
			    iconMole.infoWindowAnchor = new GPoint(5, 1);
			    
				//var marker = new GMarker(new GLatLng(lat, lng), {draggable: true});
			    var marker = new GMarker(new GLatLng(lat, lng), {draggable: false, icon: iconMole});
	          	gmap.addOverlay(marker);
	          	GEvent.addListener(marker, "dragend", function() {
	            	marker.openInfoWindowHtml(html);
	        	});
	        	GEvent.addListener(marker, "click", function() {
	        		marker.openInfoWindowHtml(html);
	       		});
	      		GEvent.trigger(marker, "click");
			}
		}
		
		function mov2address(address){
			if (geocoder) {
		        geocoder.getLatLng(
		          address,
		          function(point) {
		            if (!point) {
		              	alert(address + " not found");
		            } else {
		            	gmap.setCenter(point, 15);
		            }
		          }
		        );
		   }
		}
	
		function mov2addressHtml(address, html){
			if (geocoder) {
		        geocoder.getLatLng(
		          address,
		          function(point) {
		            if (!point) {
		              	alert(address + " not found");
		            } else {
		            	gmap.setCenter(point, 15);
		              	var marker = new GMarker(point, {draggable: false});
		              	gmap.addOverlay(marker);
		              	GEvent.addListener(marker, "dragend", function() {
		                	marker.openInfoWindowHtml(html);
		            	});
		            	GEvent.addListener(marker, "click", function() {
		            		marker.openInfoWindowHtml(html);
		           		});
			      		GEvent.trigger(marker, "click");
		            }
		          }
		        );
		   }
		}
	
		function mov2addressHtmlIcon(address, html, iconUrl){
			if (geocoder) {
		        geocoder.getLatLng(
		          address,
		          function(point) {
		            if (!point) {
		              	alert(address + " not found");
		            } else {
		            	gmap.setCenter(point, 15);
		            	var iconMole = new GIcon(); 
		    		    iconMole.image = iconUrl;
		    		    iconMole.iconAnchor = new GPoint(16,11);
		    		    iconMole.infoWindowAnchor = new GPoint(5, 1);
		              	var marker = new GMarker(point, {draggable: false, icon:iconMole});
		              	gmap.addOverlay(marker);
		              	GEvent.addListener(marker, "dragend", function() {
		                	marker.openInfoWindowHtml(html);
		            	});
		            	GEvent.addListener(marker, "click", function() {
		            		marker.openInfoWindowHtml(html);
		           		});
			      		GEvent.trigger(marker, "click");
		            }
		          }
		        );
		   }
		}
	
		function getLatLngFromMap(onOff){
			var xIcon = new GIcon();
			xIcon.image = "images/map/blue-circle.png";
			xIcon.shadow = "images/map/blue-circle-shadow.png";
			xIcon.iconSize = new GSize(34, 34);
			xIcon.shadowSize = new GSize(34, 34);
			xIcon.iconAnchor = new GPoint(15, 15);
			xIcon.infoWindowAnchor = new GPoint(15, 5);
			
			this.counter = 0;
			this.map = gmap;
			var myEventListener = GEvent.bind(this.map, "click", this, function(marker,point) {
				if (marker) {
					this.map.removeOverlay(marker);
				}else{
					if (this.counter == 0) {
						if (point) {
							var marker = new GMarker(point, xIcon);
							this.map.setCenter(point, 14);
							this.map.addOverlay(marker);
							this.counter++;
							document.getElementById("lngx").value = point.x;
							document.getElementById("laty").value = point.y;
							return point.x, point.y;
						} else {
							this.removeOverlay(marker)
						}
					} else {
						GEvent.removeListener(myEventListener);
					}
				}
				//GEvent.removeListener(myEventListener);
			}); 
			
		}
	
		function getAreaMoveDisable(swY, swX, neY, neX){//need repair
			GEvent.addListener(gmap, "move", function() {
				checkBounds();
			});
			var allowedBounds = new GLatLngBounds(new GLatLng(swY,swX), new GLatLng(neY,neX));
			function checkBounds() {
		        // Perform the check and return if OK
		        if (allowedBounds.contains(gmap.getCenter())) {
		          return;
		        }
		        // It`s not OK, so find the nearest allowed point and move there
		        var C = gmap.getCenter();
		        var X = C.lng();
		        var Y = C.lat();
		 
		        var AmaxX = allowedBounds.getNorthEast().lng();
		        var AmaxY = allowedBounds.getNorthEast().lat();
		        var AminX = allowedBounds.getSouthWest().lng();
		        var AminY = allowedBounds.getSouthWest().lat();
		 
		        if (X < AminX) {X = AminX;}
		        if (X > AmaxX) {X = AmaxX;}
		        if (Y < AminY) {Y = AminY;}
		        if (Y > AmaxY) {Y = AmaxY;}
		        //alert ("Restricting "+Y+" "+X);
		        gmap.setCenter(new GLatLng(Y,X));
		      }
		    }
	
		function getAreaLevelDisable(minLevel, maxLevel){//need repair
			var mt = gmap.getMapTypes();
			for (var i=0; i<mt.length; i++) {
		        mt[i].getMinimumResolution = function() {return minLevel;}
		        mt[i].getMaximumResolution = function() {return maxLevel;}
	      	}
			gmap.addControl(new GLargeMapControl());
		}
	
		function getLayerDisable(layerNum){
				dynamicMap.setVisibleLayers(showLayerArray);
				dynamicMap.refresh();
		}
	
		function legendDetailCont(){
			var valDis=document.getElementById("legendDetail");
			//alert(valDis);//none
			if(valDis.style.display == "inline"){
				valDis.style.display = "none";
			}else if(valDis.style.display == "none"){
				valDis.style.display = "inline";
			};
		}
	
		function layerControl(){
				if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked){
					showLayerArray = [1,2,3,4,8,11];
				}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked ){
					showLayerArray = [2,3,4,8,11];
				}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked ){
					showLayerArray = [1,3,4,8,11];
				}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked == false ){
					showLayerArray = [1,2,4,8,11];
				}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked ){
					showLayerArray = [3,4,8,11];
				}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked == false ){
					showLayerArray = [2,4,8,11];
				}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false ){
					showLayerArray = [1,4,8,11];
				}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false ){
					showLayerArray = [1,4,8,11];
				}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false ){
					showLayerArray = [4,8,11];
				}else{};
				dynamicMap.setVisibleLayers(showLayerArray);
				dynamicMap.refresh();
		}
	</script>
	
	<!-- 여기부터 우리꺼 -->		
	<script>
		var isProcess = false;
		
		$(function () {
			$('#search').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				isProcess = true;					
				search_point_list();
			});		

			$('#save').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				if(!validation()) { return; }
				isProcess = true;					
				save_data();
			});			

			$('#new').click(function () {
				//initialize();
				$('#pointFrm').clearForm();
				$("#pointId").attr("value","");
				adjustSectionDropDown2();
			});

			$('#del').click(function () {
				if(isProcess) {
					alert("처리중입니다.");
					return; 
				}			
				isProcess = true;					
				delete_data();							
			});	

			$('#orderNum').keydown(function () {
				onlyNumberInput();
			});

			$('#way').keydown(function () {
				onlyNumberInput();
			});		

			$('#latitude').keydown(function () {
				onlyNumberInput();
			});		
			
			$('#longtitude').keydown(function () {
				onlyNumberInput();
			});	

			$('#riverSelect').change(function(){
				adjustSectionDropDown();				
			});

			$('#riverId').change(function(){
				adjustSectionDropDown2();				
			});
								
			adjustSectionDropDown();
			
			adjustSectionDropDown2();			
		});

		// 여기부터 우리꺼
		function getLatLng(xId, yId, onOff){
			viewChange("gis");
			alert("지도를 클릭하시면 좌표가 설정됩니다.");
			var xIcon = new GIcon();
			xIcon.image = "<c:url value='/images/map/blue-circle.png'/>";
			xIcon.shadow = "<c:url value='/images/map/blue-circle-shadow.png'/>";					
			xIcon.iconSize = new GSize(34, 34);
			xIcon.shadowSize = new GSize(34, 34);
			xIcon.iconAnchor = new GPoint(15, 15);
			xIcon.infoWindowAnchor = new GPoint(15, 5);
			
			this.counter = 0;
			this.map = gmap;
			var myEventListener = GEvent.bind(this.map, "click", this, function(marker,point) {				
				if (marker) {
					this.map.removeOverlay(marker);
				}else{
					if (this.counter == 0) {
						if (point) {
							var marker = new GMarker(point, xIcon);
							this.map.setCenter(point, 14);
							this.map.addOverlay(marker);
							this.counter++;							
							document.getElementById(xId).value = point.x;
							document.getElementById(yId).value = point.y;
							return point.x, point.y;
						} else {
							this.removeOverlay(marker)
						}
					} else {
						GEvent.removeListener(myEventListener);
					}
				}
			}); 
		}		

		function loadMap(lat, lng, moveYn) {
			var xIcon = new GIcon();
			xIcon.image = "<c:url value='/images/map/blue-circle.png'/>";
			xIcon.shadow = "<c:url value='/images/map/blue-circle-shadow.png'/>";					
			xIcon.iconSize = new GSize(34, 34);
			xIcon.shadowSize = new GSize(34, 34);
			xIcon.iconAnchor = new GPoint(15, 15);
			xIcon.infoWindowAnchor = new GPoint(15, 5);

			this.map = gmap;

			var marker = new GMarker(new GLatLng(lat, lng), xIcon);
			this.map.setCenter(new GLatLng(lat, lng), 14);
			this.map.addOverlay(marker);			

			if(moveYn == "Y") {
				mov2(lat, lng);
			}			
		}					
		
		function save_data(){

			var pointId = $("#pointId").val();
			var riverId = $("#riverId").val();
			var sectionId = $("#sectionId").val();						
			var pointName = $("#pointName").val();						
			var orderNum = $("#orderNum").val();			
			var way = $("#way").val();			
			var latitude = $("#latitude").val();		
			var longtitude = $("#longtitude").val(); 						
			var etc = $("#etc").val(); 											
			
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/updateSectionPoint.do'/>",
				data:{pointId:pointId, riverId:riverId, sectionId:sectionId, pointName:pointName, orderNum:orderNum, way:way,
					latitude:latitude, longtitude:longtitude, etc:etc},
				dataType:"json",
				success:function(result){
	                alert("저장하였습니다.");
	                isProcess = false;

					$('#pointFrm').clearForm();	        
					search_point_list();        
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}	

		function delete_data(){

			var pointId = $('input[name=s_pointId]:checked').val();

			if(pointId == null || pointId == undefined || pointId == "") {
				alert("삭제할 데이터를 선택하여 주십시요.");
				return;
			}							 		
			
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/deleteSectionPoint.do'/>",
				data:{pointId:pointId},
				dataType:"json",
				success:function(result){
	                alert("삭제하였습니다.");
	                isProcess = false;
	                search_point_list();
	                $('#pointFrm').clearForm();
					adjustSectionDropDown2();	                
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}				

		function search_point_list(){

			var sectionId = $("#sectionSelect").val();	

			$.ajax({
				type:"post",
				url:"<c:url value='/operate/getSectionPointList.do'/>",
				data:{sectionId:sectionId},
				dataType:"json",
				success:function(result){
	                var tot = result['sectionPointList'].length;

	                var item;
	                var pointId;
	                var orderNum;
	                var sectionName = $(":select[name=sectionSelect] > option:selected").text();
	                var pointName;                

	                item = "";

	                $("#pointBody").html("");

	                if( tot <= "0" ){
						alert("조회 결과가 없습니다.");
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['sectionPointList'][j];
							
		                    pointId = obj.pointId;
		                    orderNum = obj.orderNum;
		                    pointName = obj.pointName;  
		                
		    				item = "<tr>"
		    					 + "<td>"
		    					 + "<input type=\"radio\" class=\"inputRadio\" name=\"s_pointId\" value=\""+pointId+"\" onclick=\"selectPoint()\" />"
		    					 + "<input type=\"hidden\" name=\"s_sectionName\" value=\""+sectionName+"\" />"
		    					 + "</td>"	    					 
		    					 + "<td>"+orderNum+"</td>"
		    					 + "<td>"+sectionName+"</td>"
		    					 + "<td>"+pointName+"</td>"
		    					 + "</tr>"; 
	
		       				$("#pointBody").append(item);
		                    item = "";
		                }
	                }
	                isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});
		}	
		
		function adjustSectionDropDown()
		{	
			var sugyeCd = $('#riverSelect').val();
			var dropDownSet = $('#sectionSelect');
			var selData = new Array;	
			
			dropDownSet.attr("disabled", false);
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/getSectionList.do'/>",
				data:{riverId:sugyeCd},
				dataType:"json",
				success:function(result){
	                var tot = result['sectionList'].length;
	                
	                for(var j=0; j < tot; j++){
	                    var obj = result['sectionList'][j];

	                    var val = obj.sectionId;
	                    var caption = obj.startSectionName+"-"+obj.endSectionName;
	                    
	                    selData.push({CAPTION:caption,VALUE:val});	                
	                }
	                dropDownSet.loadSelect(selData);
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}		

		function adjustSectionDropDown2(riverId, sectionId)
		{	
			var sugyeCd = $('#riverId').val();
			var dropDownSet = $('#sectionId');
			var selData = new Array;	
			
			dropDownSet.attr("disabled", false);
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/getSectionList.do'/>",
				data:{riverId:sugyeCd},
				dataType:"json",
				success:function(result){
	                var tot = result['sectionList'].length;
	                
	                for(var j=0; j < tot; j++){
	                    var obj = result['sectionList'][j];

	                    var val = obj.sectionId;
	                    var caption = obj.startSectionName+"-"+obj.endSectionName;
	                    
	                    selData.push({CAPTION:caption,VALUE:val});	                
	                }
	                dropDownSet.loadSelect(selData);

	                if(riverId != null && riverId != "") {
	                	$('#riverId').attr("value", riverId);
	                }
	                
	                if(sectionId != null && sectionId != "") {
	                	$('#sectionId').attr("value", sectionId);
	                }
				},
	            error:function(result){alert("error");isProcess = false;}
			});			
		}						

		function selectPoint() {
			var i=0;
			var pointId = $('input[name=s_pointId]:checked').val();
			search_point_data(pointId);			
		}						

		function search_point_data(pointId){
			var riverId = "";
			var sectionId = "";
			
			$.ajax({
				type:"post",
				url:"<c:url value='/operate/getSectionPoint.do'/>",
				data:{pointId:pointId},
				dataType:"json",
				success:function(result){
	                var tot = result['sectionPoint'].length;

	                if( tot <= "0" ){
						alert("조회 결과가 없습니다.");
	                } else {	                
		                for(var j=0; j < tot; j++){
		                    var obj = result['sectionPoint'][j];

		                    $("#pointId").attr('value',obj.pointId);
		        			$("#riverId").attr('value',obj.riverId);
		        			$("#sectionId").attr('value',obj.sectionId);		        			
		        			$("#pointName").attr('value',obj.pointName);
		        			$("#orderNum").attr('value',obj.orderNum);
		        			$("#way").attr('value',obj.way);
		        			$("#latitude").attr('value',obj.latitude);
		        			$("#longtitude").attr('value',obj.longtitude);
		        			$("#etc").attr('value',obj.etc);

		        			riverId = obj.riverId;
		        			sectionId = obj.sectionId;
		                }

		                if($("#longtitude").val() != "" && $("#latitude").val() != "") {
		                	loadMap($("#latitude").val(), $("#longtitude").val(), "Y");
		                }
	                }
	                adjustSectionDropDown2(riverId, sectionId);
	                
	                isProcess = false;
				},
	            error:function(result){alert("error");isProcess = false;}
			});
		}				

		function validation() {
			if($("#riverId").val() == "") { alert("수계를 선택하여 주십시요."); return false; }
			if($("#sectionId").val() == "") { alert("등속구간을 선택하여 주십시요."); return false; }
			if($("#pointName").val() == "") { alert("주요지점을 입력하여 주십시요."); return false; }
			if($("#orderNum").val() == "") { alert("순서를 입력하여 주십시요."); return false; }									
			if($("#way").val() == "") { alert("등속구간 시작점부터의 거리를 입력하여 주십시요."); return false; }									
			if($("#latitude").val() == "") { alert("위도를 입력하여 주십시요."); return false; }									
			if($("#longtitude").val() == "") { alert("경도를 입력하여 주십시요."); return false; }																								

			return true;							
		}

		function viewChange(str) {
			if(str == "list") {
				$('#listDiv').show();
				$('#gisDiv').hide();	
			} else if(str == "gis") {
				$('#gisDiv').show();
				$('#listDiv').hide();					
			}
		}			
	</script>
</head>
<body onload="initialize();" onunload="GUnload();">
<div id="wrap">
	<div id="header">
		<c:import url="/common/menu/header.do" />
	</div><!-- //header -->
	<div id="container">
		<!-- 사이드 리스트 -->
		<div id="snb" class="snb">
			<c:import url="/common/menu/left.do" />
		</div>
		<!-- //사이드 리스트 -->
		<!-- navi 리스트 -->
		<div>
			<c:import url="/common/menu/navi.do" />
		</div>
		<!-- //navi 리스트 -->
		
		<!-- content -->
		<div id="content" class="sub_situationmng">
			<div class="content_wrap page_opermng">
				<div class="inner_hotpointmng">
					<div class="forms_gis">
						<!-- 주요 지점 관리 등록 -->
						<form id="pointFrm" name="pointFrm" action="" class="formBox1" onsubmit="return false;">
						<input type="hidden" id="pointId" />					
							<fieldset>
								<legend class="hidden_phrase">주요 지점 등록 폼</legend>
								<h4>주요 지점 등록</h4>
								<table class="dataTable">
									<colgroup>
										<col width="120px" />
										<col />
									</colgroup>
									<tr>
										<th scope="row"><label for="">수계</label></th>
										<td>
											<select id="riverId" name="riverId">
												<option value="01">한강</option>
												<option value="02">낙동강</option>
												<option value="03">금강</option>
												<option value="04">영산강</option>
											</select>										
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">등속구간</label></th>
										<td>
											<select id="sectionId" name="sectionId">
											</select>										
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">주요 지점</label></th>
										<td>
											<input type="text" class="inputText" id="pointName" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">순서</label></th>
										<td>
											<input type="text" class="inputText" id="orderNum" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">등속 구간<br />시작점부터의 거리</label></th>
										<td>
											<input type="text" class="inputText" id="way" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">위도/경도</label></th>
										<td class="tdInput1">
											<input type="text" class="inputText" id="latitude" />
											<input type="text" class="inputText" id="longtitude" />
											<img src="<c:url value='/images/common/btn_coordinate.gif'/>" value="좌표" onClick="getLatLng('longtitude', 'latitude', 'on');"/>
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">기타</label></th>
										<td>
											<textArea rows="" cols="" id="etc"></textarea>
										</td>
									</tr>
								</table>
								<ul class="btn">
									<li><input id="new" type="image" src="<c:url value='/images/common/btn_new.gif'/>" alt="신규" /></li>
									<li><input id="save" type="image" src="<c:url value='/images/common/btn_save.gif'/>" alt="저장" /></li>
								</ul>
							</fieldset>
						</form>
						<!-- //주요 지점 관리 등록 -->
						<!-- 주요 지점 관리 검색, GIS -->						
						<div id="gisDiv" class="form_gisBox">
							<form action="" class="formBox2" onsubmit="return false;">
								<fieldset>
									<legend class="hidden_phrase">수계 GIS 검색 폼</legend>
									<p>
										<select onChange="javascript:mov2level(this.options[this.selectedIndex].value);">
											<option value="36.635412,128.287354,7" selected>수계</option>
											<option value="37.5258497, 127.3081805, 9">한강</option>
											<option value="35.8759486, 128.5950195, 8">낙동강</option>
											<option value="36.1888999, 127.0926905, 9">금강</option>
											<option value="35.0817827, 126.8315419, 10">영산강</option>
										</select>										
										<input id="list" type="image" src="<c:url value='/images/common/btn_list2.gif'/>" alt="목록" onclick="viewChange('list')" />
										<input id="map" type="image" src="<c:url value='/images/common/btn_map.gif'/>" alt="지도" onclick="viewChange('gis')" />																			
									</p>
								</fieldset>
							</form>
							<div id="gmap" class="gis"></div>
						</div>
						<!-- //주요 지점 관리 검색, GIS -->								
						<!-- 주요 지점 관리 검색, GIS -->
						<div id="listDiv" class="form_gisBox" style="display:none">
							<form action="" class="formBox2" onsubmit="return false;">
								<fieldset>
									<legend class="hidden_phrase">수계 GIS 검색 폼</legend>
									<p>
										<select id="riverSelect" name="riverSelect">
											<option value="01">한강</option>
											<option value="02">낙동강</option>
											<option value="03">금강</option>
											<option value="04">영산강</option>
										</select>
										<select id="sectionSelect" name="sectionSelect">
										</select>
										<input id="search" type="image" src="<c:url value='/images/common/btn_search3.gif'/>" alt="검색" />
										<input id="del" type="image" src="<c:url value='/images/common/btn_del.gif'/>" alt="삭제" />
										<input id="list" type="image" src="<c:url value='/images/common/btn_list2.gif'/>" alt="목록" onclick="viewChange('list')" />
										<input id="map" type="image" src="<c:url value='/images/common/btn_map.gif'/>" alt="지도" onclick="viewChange('gis')" />										
									</p>
								</fieldset>
							</form>
							<div id="list">
							<form action="" onsubmit="return false;">						
								<fieldset>
									<legend class="hidden_phrase"></legend>
										<div class="overBox">
											<table class="dataTable">
												<colgroup>
													<col width="110px" />
													<col width="110px" />
													<col width="200px" />
													<col />
												</colgroup>
												<thead>
													<tr>
														<th scope="col">선택</th>
														<th scope="col">순서</th>
														<th scope="col">등속구간</th>
														<th scope="col">주요지점</th>														
													</tr>
												</thead>
												<tbody id="pointBody"></tbody>												
											</table>
										</div>
								</fieldset>
							</form>							
							</div>							
						</div>
						<!-- //주요 지점 관리 검색, GIS -->
					</div>
				</div>
			</div>
		</div><!-- //content -->

	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>
