<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
  <head>
    <title>Google Maps + ArcGIS</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" type="text/css" href="/css/content.css" />
<!--##############################################################################-->
<!--## 시작:구글과 ESRI에서 관련 js파일을 가져오기위해 반드시 필요한 스크립트입니다.    ##-->
<!--## 포팅시에 실제 도메인네임과 GIS서버를 사용하기 위한 키, IP변경이 필요합니다.      ##-->
<!--## 해당키와 IP는 하단의 스크립트내에 주석으로 처리되어있으며 포팅시점에 변경바랍니다.##-->
<!--##############################################################################-->
    <!-- script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAAUqzKskvQXw_UTKpILtz0BRqs7OO1Tb_cumvo_a2JFiOp5iBHRSME5u3O-Ts911e0yjTpD4PjiNW5g" type="text/javascript"></script>
    <script src="http://serverapi.arcgisonline.com/jsapi/gmaps/?v=1.6" type="text/javascript" ></script-->
     <script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCaQqgY2oLx3pONsiZkY-XTGNlnm7ZW6dI&sensor=false">
    </script>
    <!--포팅시 아래의 도메인별 구글키의 변경이 필요합니다. -->
    <!--http://www.watertms.or.kr:8080 : ABQIAAAAAUqzKskvQXw_UTKpILtz0BSiOMSd4UtbBOzDpvG2FihVLiCnJRTRZTnPp7LJJwNnfiOH7iRZT97aLg-->
    <!--http://www.watertms.or.kr : ABQIAAAAAUqzKskvQXw_UTKpILtz0BRh65fw2Kxj1BIR7J7H70cBjtzx7hSqIHfLy7XBbpwf_EdihwInIGtqCw-->
    <!--http://www.waterkorea.or.kr:8080 : ABQIAAAAAUqzKskvQXw_UTKpILtz0BRqs7OO1Tb_cumvo_a2JFiOp5iBHRSME5u3O-Ts911e0yjTpD4PjiNW5g-->
    <!--http://www.waterkorea.or.kr : ABQIAAAAAUqzKskvQXw_UTKpILtz0BQXHMXAZIIXSp0UaSHdDYhAeGul3BQy7aUdJ-XNu3Mp0zfHROBvN2NJpQ-->
    
    <!-- <script src="http://gmaps-utility-library.googlecode.com/svn/trunk/progressbarcontrol/1.0/src/progressbarcontrol.js" type="text/javascript" ></script> -->
		
    <script type="text/javascript">
    var hostIP = "115.93.37.67";//포팅시 변경해주십시오.//GIS서버:10.101.164.223:8399
    var URL="http://115.93.37.67/rest/services/wpgism/MapServer";
    var gmap = null;
    var dynMapOv = null;
    var queryTask;
    var geocoder = null;
    var dynamicMap = null;
    var layers = null ;
    var showLayerArray = [0,1,2];
    
    var mapExtension, identifyTask, layers, overlays;
    
    var markersArray = [];
    
    function initialize()
    {
      //Load Google Maps
      //gmap = new GMap2(document.getElementById("gmap"));
      var mapOptions = {
          center: new google.maps.LatLng(36.635412,128.287354),
          zoom: 7,
          mapTypeId: google.maps.MapTypeId.HYBRID
        };
        gmap = new google.maps.Map(document.getElementById("gmap"),
            mapOptions);
	  gmap.setMapType(G_PHYSICAL_MAP);//G_NORMAL_MAP, G_SATELLITE_MAP, G_HYBRID_MAP, G_PHYSICAL_MAP
	  gmap.addMapType(G_PHYSICAL_MAP);
	  gmap.addControl(new GLargeMapControl());
      var topRight = new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(5,5));
      gmap.addControl(new GMenuMapTypeControl(),topRight);
      gmap.addControl(new GOverviewMapControl());
      gmap.setCenter(new GLatLng(36.635412,128.287354),7);
      gmap.enableScrollWheelZoom();
      
      //create custom dynamic layer
      //esri.arcgis.gmaps.DynamicMapServiceLayer(url,esri.arcgis.gmaps.ImageParameters?,opacity?,callback?);
      
     // dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer("http://"+hostIP+"/rest/services/wpgism/MapServer", null, 0.75, dynmapcallback);
     
      dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer(URL, null, 0.75, dynmapcallback);
      geocoder = new GClientGeocoder();
      
      layers=dynamicMap.getVisibleLayers() ;
	  
	  mapExtension = new esri.arcgis.gmaps.MapExtension(gmap);
	  
	  //identifyTask = new esri.arcgis.gmaps.IdentifyTask("http://"+hostIP+"/rest/services/wpgism/MapServer");
	  identifyTask = new esri.arcgis.gmaps.IdentifyTask(URL);
	  
	  GEvent.addListener(gmap, "click", identify);

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

	  getAreaMoveDisable(34.07086232376631,125.70556640625,38.58252615935333,129.55078125);
	  getAreaLevelDisable(7,15);

      
      executeQueryinit();

    }

	
    function dynmapcallback(groundov) {
      //Add groundoverlay to map using gmap.addOverlay()
      gmap.addOverlay(groundov);
      dynMapOv = groundov;
    }

    function executeQuery(minorVal) {
        gmap.clearOverlays();
        
        //dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer("http://"+ hostIP +"/rest/services/wpgism/MapServer", null, 0.75, dynmapcallback);
        dynamicMap = new esri.arcgis.gmaps.DynamicMapServiceLayer(URL, null, 0.75, dynmapcallback);

		if(minorVal == '-1'){}
		else{

	        //queryTask = new esri.arcgis.gmaps.QueryTask("http://"+ hostIP +"/rest/services/wpgism/MapServer/1");
	        queryTask = new esri.arcgis.gmaps.QueryTask(URL+"/1");
	        
	        if(minorVal){
		        // create the query
		        var query = new esri.arcgis.gmaps.Query();
		        query.where = "MIN_OR = '" + minorVal + "'";
		        query.outFields = ["taksu.NAME", "MIN_OR"];
		
		        // execute the query
		        queryTask.execute(query, false, function(featureSet, error) { // callback
		          // display error message (if any)
		          if (error) {
		            alert("Error" + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
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
        var tinyIcon = new GIcon();
        tinyIcon.image = "/images/map/gong.png";
        tinyIcon.shadow = null;
        tinyIcon.iconSize = new GSize(10, 10);
        tinyIcon.iconAnchor = new GPoint(0, 0);
        tinyIcon.infoWindowAnchor = new GPoint(0, 0);
        
	       // queryTask = new esri.arcgis.gmaps.QueryTask("http://115.93.37.67/rest/services/wpgism/MapServer/1");
	       
	       		queryTask = new esri.arcgis.gmaps.QueryTask(URL+"/1");

	        
		        // create the query
		        var query = new esri.arcgis.gmaps.Query();
		        query.where = "1=1";
			    query.outFields = ["taksu.NAME", "MIN_OR", "MIN_VL", "MIN_TIME"];
		        // execute the query
		        queryTask.execute(query, false, function(featureSet, error) { // callback
		          // display error message (if any)
		          if (error) {
		            alert("Error taksu" + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
		            return;
		          }
		          // add the feature set to the map
		          var features = featureSet.features, geometry, attributes;
		          for (var i = 0; i < features.length; i++) { // process each county in the feature set
		            geometry = features[i].geometry;
		            attributes = features[i].attributes;
		            for (var j = 0; j < geometry.length; j++) { // Feature.geometry is an array of GPolygon/GPolyline/GMarker
		              var geom = geometry[j];
					  var initSym = new GMarker(new GLatLng(geom.getLatLng().y, geom.getLatLng().x), {icon:tinyIcon});
					  GEvent.addListener(initSym, "mouseover", GEvent.callbackArgs(geom, onMouseOverFunc_taksu, attributes));
		              GEvent.addListener(initSym, "mouseout", onMouseOutFunc);  
		              gmap.addOverlay(initSym);
		            }
		          }
		        });

		        //queryTask = new esri.arcgis.gmaps.QueryTask("http://"+ hostIP +"/rest/services/wpgism/MapServer/2");
		        queryTask = new esri.arcgis.gmaps.QueryTask(URL+"/2");


			        // create the query
		        var query = new esri.arcgis.gmaps.Query();
		        query.where = "1=1";
			    query.outFields = ["IPUSN.NAME", "MIN_OR", "MIN_VL", "MIN_TIME"];
		        // execute the query
		        queryTask.execute(query, false, function(featureSet, error) { // callback
		          // display error message (if any)
		          if (error) {
		            alert("Error ipsun " + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
		            return;
		          }
		          // add the feature set to the map
		          var features = featureSet.features, geometry, attributes;
		          for (var i = 0; i < features.length; i++) { // process each county in the feature set
		            geometry = features[i].geometry;
		            attributes = features[i].attributes;
		            for (var j = 0; j < geometry.length; j++) { // Feature.geometry is an array of GPolygon/GPolyline/GMarker
		              var geom = geometry[j];
					  var initSym = new GMarker(new GLatLng(geom.getLatLng().y, geom.getLatLng().x), {icon:tinyIcon});
					  GEvent.addListener(initSym, "mouseover", GEvent.callbackArgs(geom, onMouseOverFunc_ipusn, attributes));
		              GEvent.addListener(initSym, "mouseout", onMouseOutFunc);  
		              gmap.addOverlay(initSym);
		            }
		          }
		        });

		        //queryTask = new esri.arcgis.gmaps.QueryTask("http://"+ hostIP +"/rest/services/wpgism/MapServer/0");
		        queryTask = new esri.arcgis.gmaps.QueryTask(URL+"/0");
		        
		        // create the query
		        var query = new esri.arcgis.gmaps.Query();
		        query.where = "1=1";
			    query.outFields = ["auto.BASIN","auto.STATION", "MIN_OR", "MIN_VL", "MIN_TIME"];
		        // execute the query
		        queryTask.execute(query, false, function(featureSet, error) { // callback
		          // display error message (if any)
		          if (error) {
		            alert("Error auto " + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
		            return;
		          }
		          // add the feature set to the map
		          var features = featureSet.features, geometry, attributes;
		          for (var i = 0; i < features.length; i++) { // process each county in the feature set
		            geometry = features[i].geometry;
		            attributes = features[i].attributes;
		            for (var j = 0; j < geometry.length; j++) { // Feature.geometry is an array of GPolygon/GPolyline/GMarker
		              var geom = geometry[j];
					  var initSym = new GMarker(new GLatLng(geom.getLatLng().y, geom.getLatLng().x), {icon:tinyIcon});
					  GEvent.addListener(initSym, "mouseover", GEvent.callbackArgs(geom, onMofa, attributes));
		              GEvent.addListener(initSym, "mouseout", onMouseOutFunc);  
		              gmap.addOverlay(initSym);
		            }
		          }
		        });

 				queryTask = new esri.arcgis.gmaps.QueryTask(URL+"/3");
		        
		        // create the query
		        var query = new esri.arcgis.gmaps.Query();
		        query.where = "1=1";
			    query.outFields = ["TMS.NAME","MIN_OR", "MIN_VL", "MIN_TIME"];
		        // execute the query
		        queryTask.execute(query, false, function(featureSet, error) { // callback
		          // display error message (if any)
		          if (error) {
		            alert("Error auto " + error.code + ": " + (error.message || (error.details && error.details.join(" ")) || "Unknown error" ));
		            return;
		          }
		          // add the feature set to the map
		          var features = featureSet.features, geometry, attributes;
		          for (var i = 0; i < features.length; i++) { // process each county in the feature set
		            geometry = features[i].geometry;
		            attributes = features[i].attributes;
		            for (var j = 0; j < geometry.length; j++) { // Feature.geometry is an array of GPolygon/GPolyline/GMarker
		              var geom = geometry[j];
					  var initSym = new GMarker(new GLatLng(geom.getLatLng().y, geom.getLatLng().x), {icon:tinyIcon});
					  GEvent.addListener(initSym, "mouseover", GEvent.callbackArgs(geom, onMouseOverFunc_TMS, attributes));
		              GEvent.addListener(initSym, "mouseout", onMouseOutFunc);  
		              gmap.addOverlay(initSym);
		            }
		          }
		        });
      }
    
      // show info window for the county when the user moves the mouse over it
      function onMouseOverFunc_taksu(attributes)
      {
        var point = this;
        var stateVal;

        if (attributes["MIN_OR"] == '0'){stateVal = "정상";}
        else if (attributes["MIN_OR"] == '1'){stateVal = "관심";}
        else if (attributes["MIN_OR"] == '2'){stateVal = "주의";}
        else if (attributes["MIN_OR"] == '3'){stateVal = "경계";}
        else if (attributes["MIN_OR"] == '4'){stateVal = "심각";}
        else {stateVal = "미수집";}
        if(selTaksu.checked)
        {
			var html = "<table class='GISTable' border='1' width=\"170px\"><tr><td><b>명칭:</b> </td><td>" + attributes["taksu.NAME"] + "</td></tr><tr><td><b>상태값:</b> </td><td>" + stateVal+"</td></tr><tr><td><b>측정값:</b> </td><td>"+attributes["MIN_VL"]+"</td></tr></table>";
			gmap.openInfoWindowHtml(point.getPoint(), html);//nw
        }
        else
        {
            
        }
        
      }
      function onMouseOverFunc_ipusn(attributes)
      {
        var point = this;
        var stateVal;
		
        if (attributes["MIN_OR"] == '0'){stateVal = "정상";}
        else if (attributes["MIN_OR"] == '1'){stateVal = "관심";}
        else if (attributes["MIN_OR"] == '2'){stateVal = "주의";}
        else if (attributes["MIN_OR"] == '3'){stateVal = "경계";}
        else if (attributes["MIN_OR"] == '4'){stateVal = "심각";}
        else {stateVal = "미수집";}
        if(selIpusn.checked)
        {
			var html = "<table class='GISTable' border='1' width=\"170px\"><tr><td><b>명칭:</b> </td><td>" + attributes["IPSUN.NAME"] + "</td></tr><tr><td><b>상태값:</b> </td><td>" + stateVal+"</td></tr><tr><td><b>측정값:</b> </td><td>"+attributes["MIN_VL"]+"</td></tr></table>";
	        gmap.openInfoWindowHtml(point.getPoint(), html);//nw
        }
        else
        {
        }
        
      }
      function onMouseOverFunc_TMS(attributes)
      {
        var point = this;
        var stateVal;

        if (attributes["MIN_OR"] == '0'){stateVal = "정상";}
        else if (attributes["MIN_OR"] == '1'){stateVal = "관심";}
        else if (attributes["MIN_OR"] == '2'){stateVal = "주의";}
        else if (attributes["MIN_OR"] == '3'){stateVal = "경계";}
        else if (attributes["MIN_OR"] == '4'){stateVal = "심각";}
        else {stateVal = "미수집";}
        if(selTms.checked)
        {
        	var html = "<table class='GISTable' border='1' width=\"170px\"><tr><td><b>명칭:</b> </td><td>" + attributes["TMS.NAME"] + "</td></tr><tr><td><b>상태값:</b> </td><td>" + stateVal+"</td></tr><tr><td><b>측정값:</b> </td><td>"+attributes["MIN_VL"]+"</td></tr></table>";
            gmap.openInfoWindowHtml(point.getPoint(), html);//nw
        }
        else
        {
        }
              
		
      }

   // show info window for the county when the user moves the mouse over it
      function onMofa(attributes) {
        var point = this;
        var stateVal;

        if (attributes["MIN_OR"] == '0'){stateVal = "정상";}
        else if (attributes["MIN_OR"] == '1'){stateVal = "관심";}
        else if (attributes["MIN_OR"] == '2'){stateVal = "주의";}
        else if (attributes["MIN_OR"] == '3'){stateVal = "경계";}
        else if (attributes["MIN_OR"] == '4'){stateVal = "심각";}
        else {stateVal = "미수집";}
		if(selAuto.checked)
		{
			var html = "<table class='GISTable' border='1' width=\"170px\"><tr><td><b>명칭:</b> </td><td>" + attributes["auto.BASIN"] + "_" + attributes["auto.STATION"] + "</td></tr><tr><td><b>상태값:</b> </td><td>" + stateVal+"</td></tr><tr><td><b>측정값:</b> </td><td>"+attributes["MIN_VL"]+"</td></tr></table>";
	        gmap.openInfoWindowHtml(point.getPoint(), html);//nw
	        
	        
		}
		else
		{
		}
		
      }
      
      // close info window when the user moves the mouse out of a county
      function onMouseOutFunc() {
        var point = this;
        gmap.closeInfoWindow();
      }

      function identify(overlay, latLng) {
    	  alert('XX');
          if (overlay) return;

          // set the identify parameters
          var identifyParameters = new esri.arcgis.gmaps.IdentifyParameters();
          identifyParameters.geometry = latLng; // location where the user clicked on the map
          identifyParameters.tolerance = 3;
          identifyParameters.layerIds = [ 0, 1, 2,3  ];
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
          if (idResults.length > 0 ){
	          var selectLayerID = idResults[99].layerId;
	          if (selectLayerID == '0'){
	        	  layers = { "0": []};
	          }else if (selectLayerID == '1'){
	        	  layers = { "1": []};
	          }else if (selectLayerID == '2'){
	        	  layers = { "2": []};
	          }else if (selectLayerID == '3'){
	        	  layers = { "3": []};
	          }else{};

	          //for (var i = 0; i < idResults.length; i++) {
	            var result = idResults[99];
	            layers[result.layerId].push(result);
	          //}

	          // create and show the info-window with tabs, one for each map service layer
	          var tabs = [];
	          for (var layerId in layers) {
	            var results = layers[layerId];
	            var count = results.length;
	            var label = "", content = "";
	            switch(layerId) {
	            case "0":
	                label = "수질측정망";
	                content = "결과항목 : <b>" + count + "</b>";
	                if (count == 0) break;
	                //content += "<table class='GISTable' border='1'><th>수질측정망명</th><th>최종수집시간</th><th>측정값</th>";
	                content += "<table class='GISTable' border='1' width=\"15px\"><colgroup><col width=\"50px\" /><col width=\"80px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">수질측정망명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
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
	              case "1":
	                label = "탁수";
	                content = "결과항목 : <b>" + count + "</b>";
	                if (count == 0) break;
	                content += "<table class='GISTable' border='1'  width=\"150px\"><colgroup><col width=\"50px\" /><col width=\"100px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">탁수명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
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
	              case "2":
	                label = "이동형측정기기";
	                content = "결과항목 : <b>" + count + "</b>";
	                if (count == 0) break;
	                content += "<table class='GISTable'  border='1'  width=\"150px\"><colgroup><col width=\"70px\" /><col width=\"80px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">이동형측정기기명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
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
	              case "3":
		                label = "TMS";
		                content = "결과항목 : <b>" + count + "</b>";
		                if (count == 0) break;
		                content += "<table class='GISTable'  border='1'  width=\"150px\"><colgroup><col width=\"70px\" /><col width=\"80px\" /><col width=\"50px\"/></colgroup><th scope=\"col\">이동형측정기기명</th><th scope=\"col\">최종수집시간</th><th scope=\"col\">측정값</th>";
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
		
		this.map = gmap;
		google.maps.event.addListener(map, 'click', function(mouseEvent) {
			getAddress(mouseEvent.latLng);
		});
		
		function getAddress(latlng) {
			google.maps.Map.prototype.markers = new Array();

			google.maps.Map.prototype.addMarker = function(marker) {
			    this.markers[this.markers.length] = marker;
			};

			google.maps.Map.prototype.getMarkers = function() {
			    return this.markers
			};

			google.maps.Map.prototype.clearMarkers = function() {
			    for(var i=0; i<this.markers.length; i++){
			        this.markers[i].setMap(null);
			    }
			    this.markers = new Array();
			};
			
			var geocoder = new google.maps.Geocoder();
			var markersArray = [];	
			geocoder.geocode({
				latLng: latlng
			}, function(results, status) {
				if (status == google.maps.GeocoderStatus.OK) {
					
					//alert(results[0].geometry);
					/*
					if (results[0].geometry) {
						var address = results[0].formatted_address.replace(/^日本, /, '');
						
						
						new google.maps.InfoWindow({
							content: address + "<br>(Lat, Lng) = " + latlng
						}).open(map, new google.maps.Marker({
							position: latlng,
							map: map
						}));
					}
					*/
					clearOverlays();
					addMarker(latlng);
					/*
					new google.maps.Marker({
						position: latlng,
						map: map
					});
					*/
					/*
						var image = "/images/map/blue-circle.png";
						new google.maps.Marker({
						map:map,
						draggable:true,
						animation: google.maps.Animation.DROP,
						position: latlng,
						icon: image, // icon 속성에 위의 image 변수 적용 *
						shadow: shadow // shadow 속성에 위의 shadow 변수 적용: 그림자 *
						});
						*/
					var address = results[0].formatted_address.replace(/^日本, /, '');
					document.getElementById("addressPoint").value= address.substring(5,address.length);
					document.getElementById("lngx").value = results[0].geometry.location.lng();
	    			document.getElementById("laty").value = results[0].geometry.location.lat();
				} else if (status == google.maps.GeocoderStatus.ERROR) {
					alert("통신중 에러발생！");
				} else if (status == google.maps.GeocoderStatus.INVALID_REQUEST) {
					alert("요청에 문제발생！geocode()에 전달하는GeocoderRequest확인요！");
				} else if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
					alert("단시간에 쿼리 과다송신！");
				} else if (status == google.maps.GeocoderStatus.REQUEST_DENIED) {
					alert("이 페이지에는 지오코더 이용 불가");
				} else if (status == google.maps.GeocoderStatus.UNKNOWN_ERROR) {
					alert("서버에 문제발생");
				} else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
					alert("존재하지 않습니다.");
				} else {
					alert("버전업!!??");
				}
			});
		}

		/*
		var xIcon = new GIcon();
		xIcon.image = "/images/map/blue-circle.png";
		xIcon.shadow = "/images/map/blue-circle-shadow.png";
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
						geocoder.getLocations(point, showAddress);
						return point.x, point.y;
					} else {
						this.removeOverlay(marker)
					}
				} else {
					GEvent.removeListener(myEventListener);
				}
			}
		}); 
		*/
	}
	
	function addMarker(location) {
		  marker = new google.maps.Marker({
		    position: location,
		    map: map
		  });
		  markersArray.push(marker);
		}

		// Removes the overlays from the map, but keeps them in the array
		function clearOverlays() {
		  if (markersArray) {
		    for (i in markersArray) {
		      markersArray[i].setMap(null);
		    }
		  }
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
		if(valDis.style.display == "inline"){
			valDis.style.display = "none";
		}else if(valDis.style.display == "none"){
			valDis.style.display = "inline";
		};
	}

	function layerControl(){
			if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked){
				showLayerArray = [0,1,2,3,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked ){
				showLayerArray = [1,2,3,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked ){
				showLayerArray = [0,2,3,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked ){
				showLayerArray = [0,1,3,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked == false ){
				showLayerArray = [0,1,2,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked){
				showLayerArray = [2,3,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked){
				showLayerArray = [1,3,16];
			}else if(document.getElementById("selAuto").checked == false  && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked == false){
				showLayerArray = [1,2,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked){
				showLayerArray = [0,3,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked == false){
				showLayerArray = [0,2,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked == false){
				showLayerArray = [0,1,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked){
				showLayerArray = [3,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked && document.getElementById("selTms").checked == false){
				showLayerArray = [2,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked == false){
				showLayerArray = [1,16];
			}else if(document.getElementById("selAuto").checked && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked == false){
				showLayerArray = [0,16];
			}else if(document.getElementById("selAuto").checked == false && document.getElementById("selTaksu").checked == false && document.getElementById("selIpusn").checked == false && document.getElementById("selTms").checked == false){
				showLayerArray = [16];
			}else{};
			dynamicMap.setVisibleLayers(showLayerArray);
			dynamicMap.refresh();
	}

	function addTransIcon(lat, lng, iconUrl){
			var iconMole = new GIcon(); 
		    iconMole.image = iconUrl;
		    var marker = new GMarker(new GLatLng(lat, lng), {draggable: false, icon: iconMole});
          	gmap.addOverlay(marker);
	}
	
	function layerControlByVal(strType){
		if(strType == "A"){
			showLayerArray = [0];
		}else if(strType == "T"){
			showLayerArray = [1];
		}else if(strType == "U"){
			showLayerArray = [2];
		}else if(strType == "W"){
			showLayerArray = [3];
		}else{showLayerArray = [0,1,2];};
		dynamicMap.setVisibleLayers(showLayerArray);
		dynamicMap.refresh();
	}
	
	function showAndStoreAddress(response){
		if (response && response.Status.code == 200 && store_geocode) {
			store_geocode = false;
			if (debugging){
				document.getElementById("debugging").innerHTML = "In showAndStoreAddress."+"<br />"+document.getElementById("debugging").innerHTML;
			}
			var xmlhttp = create_xmlhttp();
			var d = new Date();
			if (document.getElementById("working")) {
				document.getElementById("working").src = "http://"+host+"/images/waiting-16.gif";
			}
			serverPage = "http://"+host+"/processors/store-reverse-geocode.php?lat_in="+lat+"&lon_in="+lon+"&lat_out="+response.Placemark[0].Point.coordinates[1]+"&lon_out="+response.Placemark[0].Point.coordinates[0]+"&accuracy="+response.Placemark[0].AddressDetails.Accuracy+"&sescod="+document.load_location.sescod.value+"&status="+response.Status.code+"&address="+escape(response.Placemark[0].address)+"&time="+d.getTime();
			if (debugging){
				document.getElementById("debugging").innerHTML = "serverPage: "+serverPage+"<br />"+document.getElementById("debugging").innerHTML;
				serverPage = serverPage+"&debugging=1"
			}
			xmlhttp.open("GET", serverPage, true); 
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					if (xmlhttp.responseText.length > 0){
						if (debugging){
							document.getElementById("debugging").innerHTML = xmlhttp.responseText+"<br />"+document.getElementById("debugging").innerHTML;
						}
						eval(xmlhttp.responseText);
					} else {
					}
					if (debugging){
						document.getElementById("debugging").innerHTML = "xmlhttp.responseText: "+xmlhttp.responseText+"<br />"+document.getElementById("debugging").innerHTML;
					}
				} else if (xmlhttp.readyState == 4 && xmlhttp.status != 200){
					if (debugging){
						document.getElementById("debugging").innerHTML = "xmlhttp.status: "+xmlhttp.status+"<br />"+document.getElementById("debugging").innerHTML;
					}
				}
				if (document.getElementById("working")) {
					document.getElementById("working").src = "http://"+host+"/images/pix.gif";
					document.getElementById("working").width = 16;
					document.getElementById("working").height = 16;
				}
			}
	
			xmlhttp.send(null);
		}
		showAddress(response);
	}

function showAddress(response) {
	  if (!response || response.Status.code != 200) {
		} else {
		place = response.Placemark[0];
			document.getElementById("addressPoint").value = place.address;	
			return place.address;	
	  }
	}
function mov2multiLanlng(latA, lngA, latB, lngB){
		gmap.setZoom(10);//setZoom must be 1st.
		gmap.panTo(new GLatLng((latA+latB)/2, (lngA+lngB)/2));
	}
  </script>
<!--#######################################################################-->
<!--##끝:구글과 esri에서 관련 js파일을 가져오기위해 반드시 필요한 스크립트입니다.##-->
<!--#######################################################################-->
</head>

<!--#######################################################################-->
<!--##body의 onload="initialize();" onunload="GUnload();"는 필수사항입니다.##-->
<!--#######################################################################-->
	<body onload="initialize();" onunload="GUnload();">

<!--###########################################################################-->
<!--### 맵상단의 수계선택 예입니다. 그대로 적용하셔도 되고 ctrl+c,v를 하셔도 됩니다.###-->
<!--### 임시시스템을 이용하기 위한 예이며 차후 플래쉬맵이 적용될경우 기본기능으로         ###-->
<!--### 포함될 예정입니다.                                                   ###-->
<!--###########################################################################-->
	<div class="roundBox roundBox1" id="infoRiver">
		<div class="top_l"><div class="top_r"><div class="top"></div></div></div>
		<div class="con">
			<div class="con_r">
				<ul> 
					<li class="first">
						수계선택 :
					</li>
					<li>
						<input type="radio" name="selRiver" value="36.635412,128.287354, 7" onclick="javascript:mov2level('36.635412,128.287354, 7');"/>전체
					</li>
					<li>
						<input type="radio" name="selRiver" value="37.5258497, 127.3081805, 9" onclick="javascript:mov2level('37.5258497, 127.3081805, 9');"/>한강
					</li>
					<li>
						<input type="radio" name="selRiver" value="35.8759486, 128.5950195, 8" onclick="javascript:mov2level('35.8759486, 128.5950195, 8');"/>낙동강
					</li>
					<li>
						<input type="radio" name="selRiver" value="36.1888999, 127.0926905, 9" onclick="javascript:mov2level('36.1888999, 127.0926905, 9');"/>금강
					</li>
					<li>
						<input type="radio" name="selRiver" value="35.0817827, 126.8315419, 10" onclick="javascript:mov2level('35.0817827, 126.8315419, 10');"/>영산강
					</li>
				</ul>
			</div>
		</div>
		<div class="bot_l"><div class="bot_r"><div class="bot"></div></div></div>
	</div>
<!--###맵상단의 수계선택 예입니다. 그대로 적용하셔도 되고 ctrl+c,v를 하셔도 됩니다.###-->




<!--#######################################################################-->
<!--## 페이지내에서 실제 맵div를 선언하는 파트로 id의 변경이 불가합니다.         ##-->
<!--#######################################################################-->	
		<div id="gmap" style="width: 100%; height: 575px;"></div><!--div : gmap sytle.height must need to be setted-->
		<!-- <div id="gmap" style="width: 100%; height: 472px;"></div>-->
		
<!--#######################################################################-->
<!--## 범례DIV : 변경 금지                                                                                                                                  ##-->
<!--#######################################################################-->
<div id="legend"><input type="button" value="범례" style="width:80px;height:17px;border:0;" onClick="javascript:legendDetailCont();"></input></div>
<div id="legendDetail" style="display:none"><font size="2"><input type="checkbox" id="selAuto" onClick="javascript:layerControl();" checked>국가수질자동측정망</input> <input type="checkbox" id="selIpusn" onClick="javascript:layerControl();" checked>이동형측정기기</input> <input type="checkbox" id="selTms" onClick="javascript:layerControl();" >TMS</input><br/><img src="<c:url value='/images/map/legend.png'/>"/></font></div>


<!--############              맵 컨트롤 예제는 mapview.html참조바랍니다.        ###################-->	

	</body>
</html>
<!--must be inserted up for including map page-->