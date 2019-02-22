
var v_protocol = "http://";
var vworldUrl = 'http://map.vworld.kr';
var vworld2DCache = 'http://2d.vworld.kr:8895/2DCache';
var vworldBaseMapUrl = 'http://xdworld.vworld.kr:8080/2d';
var vworldStyledMapUrl = 'http://2d.vworld.kr:8895/stmap';

var vworldIsValid = 'true';
var vworldErrMsg = '';
var vworldApiKey = '767B7ADF-10BA-3D86-AB7E-02816B5B92E9';
var vworld3DUrl = '/js/sopMapInit.js.do';
var vworldVers = {
	OpenLayers : "2.13",
	Base : 'service',
	Hybrid : 'service',
	Satellite : 'service',
	Gray : 'service',
	Midnight : 'service',
	ServerMaxLevel : 18
};
var vworldTimes = {
	times : [ "1950", "1978", "1989", "1996", "2006", "2007" ],
	types : [ "png", "png", "png", "png", "png", "jpeg" ]
};
if (!Array.indexOf) {
	Array.prototype.indexOf = function(obj) {
		for (var i = 0; i < this.length; i++) {
			if (this[i] == obj) {
				return i;
			}
		}
		return -1;
	}
}
var vworldUrls = {
	earth : vworldUrl + vworld3DUrl + "?apiKey=" + vworldApiKey,
	base : vworldBaseMapUrl + "/Base/" + vworldVers.Base + "/",
	hybrid : vworldBaseMapUrl + "/Hybrid/" + vworldVers.Hybrid + "/",
	raster : vworldBaseMapUrl + "/Satellite/" + vworldVers.Satellite + "/",
	gray : vworldBaseMapUrl + "/gray/" + vworldVers.Gray + "/",
	midnight : vworldBaseMapUrl + "/midnight/" + vworldVers.Midnight + "/",
	tile2d : vworld2DCache + '/tile',
	times : vworldBaseMapUrl + "/Satellite",
	print : vworldUrl + '/printMap.do',
	wms : vworld2DCache + '/gis/map/WMS?',
	wms2 : vworld2DCache + '/gis/map/WMS2?',
	wfs : vworld2DCache + '/gis/map/WFS?',
	apiCheck : vworldUrl + "/check2DNum.do?key=" + vworldApiKey
};
var vworldUrlsExt = {
	css : vworldUrl + "/css/vmap23.css",
	oltheme : vworldUrl + "/images/maps",
	openlayers : vworldUrl + "/js/map/OpenLayers-" + vworldVers.OpenLayers
			+ "/OpenLayers.js",
	layerobject : vworldUrl + "/js/map/LayerObjects.js",
	blankimage : vworldUrl + "/images/maps/no_service.gif",
	emptyimage : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOwAAADtCAMAAAH8VlkVAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAADUExURQAAAKd6PdoAAAABdFJOUwBA5thmAAAACXBIWXMAABcRAAAXEQHKJvM/AAAATklEQVR4Xu3BMQEAAADCoPVPbQ0PIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADhQA9w6AAGqmLf8AAAAAElFTkSuQmCC",
	marker : vworldUrl + "/images/maps",
	markerimage : "/marker.png"
};
var thisMap = null;
var vmap, vearth;
var vworldVar = {
	maptype : "",
	printpage : "a4",
	printdirect : "portrait",
	bldglayer : "LT_C_BLDGBASE"
};
var vworldOthers = {
	osmurl : [ v_protocol + 'a.tile.openstreetmap.org',
			v_protocol + 'b.tile.openstreetmap.org',
			v_protocol + 'c.tile.openstreetmap.org' ]
};
var vworldIDs = {
	idpanel : "",
	id2d : "",
	id3d : "",
	idloading : "",
	idshim : "",
	idmenu : "",
	idmode : []
};
var vworldInfo = {
	lonlat : null,
	pixel : {},
	group : null,
	prev3dlonlat : [],
	Layers3d : [],
	objects3d : [],
	objects2d : [],
	prevpixel : {}
};
var vworldCategory = {
	wms : "wms_theme_",
	cache : "cache_theme_",
	theme : "theme_",
	stat : "stat_theme_"
};
var vworldDefaultfiles = new Array(vworldUrlsExt.openlayers,
		vworldUrlsExt.layerobject, vworldUrls.earth);
var vworldChartfiles = new Array(vworldUrl + "/js/map/chart/raphael.js",
		vworldUrl + "/js/map/chart/v.g.raphael.max.js", vworldUrl
				+ "/js/map/chart/v.g.bar.max.js", vworldUrl
				+ "/js/map/chart/v.g.pie.max.js", vworldUrl
				+ "/js/map/chart/v.g.line.max.js", vworldUrl
				+ "/js/map/Charts.js");
var include2DApi = new Array(vworldUrl + "/js/map/include2DApi/include2DApi.js");
(function() {
	vworldFunc = {
		_browserName : function() {
			var agt = navigator.userAgent.toLowerCase();
			if (agt.indexOf("edge") != -1)
				return 'Edge';
			if (agt.indexOf("chrome") != -1)
				return 'Chrome';
			if (agt.indexOf("opera") != -1)
				return 'Opera';
			if (agt.indexOf("staroffice") != -1)
				return 'Star Office';
			if (agt.indexOf("webtv") != -1)
				return 'WebTV';
			if (agt.indexOf("beonex") != -1)
				return 'Beonex';
			if (agt.indexOf("chimera") != -1)
				return 'Chimera';
			if (agt.indexOf("netpositive") != -1)
				return 'NetPositive';
			if (agt.indexOf("phoenix") != -1)
				return 'Phoenix';
			if (agt.indexOf("firefox") != -1)
				return 'Firefox';
			if (agt.indexOf("safari") != -1)
				return 'Safari';
			if (agt.indexOf("skipstone") != -1)
				return 'SkipStone';
			if (agt.indexOf("msie") != -1 || agt.indexOf("trident") != -1)
				return 'Internet Explorer';
			if (agt.indexOf("netscape") != -1)
				return 'Netscape';
			if (agt.indexOf("mozilla/5.0") != -1)
				return 'Mozilla';
			return '';
		},
		_isIE : function() {
			return ((navigator.userAgent.indexOf("MSIE") != -1 || navigator.userAgent
					.indexOf("Trident") != -1)) ? true : false;
		},
		_isSupport : function() {
			var support = false;
			support = true && !this._isMobile() && !this._isUnNPAPI();
			return support;
		},
		_isMobile : function() {
			try {
				var browserCheckText = [ 'iPhone', 'iPod', 'BlackBerry',
						'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG',
						'SonyEricsson' ];
				for ( var word in browserCheckText) {
					if (navigator.userAgent.toUpperCase().match(
							browserCheckText[word].toUpperCase()) != null) {
						return true;
						break;
					}
				}
				return false;
			} catch (e) {
				return false;
			}
		},
		_isUnNPAPI : function() {
			try {
				var browserCheckText = [ 'Edge' ];
				for ( var word in browserCheckText) {
					if (navigator.userAgent.toUpperCase().match(
							browserCheckText[word].toUpperCase()) != null) {
						return true;
						break;
					}
				}
				return false;
			} catch (e) {
				return false;
			}
		},
		_commify : function(n) {
			var reg = /(^[+-]?\d+)(\d{3})/;
			n += '';
			while (reg.test(n))
				n = n.replace(reg, '$1' + ',' + '$2');
			return n;
		},
		_sleep : function(ms) {
			var start = new Date().getTime();
			for (var i = 0; i < 1e7; i++) {
				if ((new Date().getTime() - start) > ms) {
					break;
				}
			}
		},
		_popupView : function(url, name, width, height, sb, ispopup, html) {
			var w = vworldFunc._GetElement(vworldIDs.idpanel).offsetWidth;
			var h = vworldFunc._GetElement(vworldIDs.idpanel).offsetHeight;
			var minW = width + 10;
			var minH = height + 30;
			var isSafari = (vworldFunc._browserName() == 'Safari') ? true
					: false;
			if (w < minW || h < minH || ispopup || isSafari) {
				try {
					var pop = window
							.open(
									'',
									name,
									'top=100px, left=100px, width='
											+ width
											+ 'px, height='
											+ height
											+ 'px,resizable=no,scrollbars='
											+ sb
											+ ',toolbar=no,menubar=no,location=no,directories=no,status=no');
					if (html == '') {
						pop.location.href = url;
					} else {
						pop.document.write(html);
					}
				} catch (e) {
					alert('팝업을 허용해 주세요.');
				}
			} else {
				var pop = vworldFunc
						._GetElement(vworld.enums.POP_CALLBACK_FRAME_ID);
				if (pop == null) {
					pop = vworldFunc._CreateElement('iframe');
					pop.setAttribute('id', vworld.enums.POP_CALLBACK_FRAME_ID);
					pop.style.display = 'none';
					pop.frameBorder = '0';
					pop.scrolling = 'no';
					vworldFunc._GetElement(vworldIDs.idpanel).appendChild(pop);
				} else {
					pop.src = "about:blank";
					pop.contentWindow.document.close();
				}
				pop.frameBorder = '0';
				pop.scrolling = 'no';
				pop.style.position = 'absolute';
				pop.style.overflow = 'hidden';
				pop.style.width = width + 'px';
				pop.style.height = height + 'px';
				pop.style.left = '0px';
				pop.style.top = '0px';
				pop.style.zIndex = 10000;
				if (html == '') {
					pop.src = url;
				} else {
					pop.contentWindow.document.write(html);
				}
				pop.style.display = 'inline-block';
			}
		},
		_purge : function(d) {
			var a = d.attributes, i, l, n;
			if (a) {
				l = a.length;
				for (i = 0; i < l; i++) {
					if (!a[i].name) {
						n = a[i].name;
						if (typeof d[n] == 'function')
							d[n] = null;
					}
				}
			}
			a = d.childNodes;
			if (a) {
				l = a.length;
				for (i = 0; i < l; i++) {
					this._purge(d.childNodes[i]);
				}
			}
		},
		_GetElement : function(id) {
			return document.getElementById(id);
		},
		_CreateElement : function(type) {
			return document.createElement(type);
		},
		_ShimResize : function(type) {
			if ((this._GetElement(vworldIDs.idmenu) == null)
					|| (this._GetElement(vworldIDs.idmenu) == null))
				return false;
			if ((type == 'on') && (vworldVar.maptype.slice(-4) != 'only')) {
				if (!vworldFunc._isSupport()
						|| (vworldVar.maptype.slice(-4) == 'base')) {
					this._GetElement(vworldIDs.idmenu).style.height = this
							._GetElement(vworldIDs.idshim).style.height = '66px';
				} else {
					this._GetElement(vworldIDs.idmenu).style.height = this
							._GetElement(vworldIDs.idshim).style.height = '132px';
				}
				this._GetElement(vworldIDs.idmenu).style.opacity = this
						._GetElement(vworldIDs.idshim).style.opacity = 1;
				this._GetElement(vworldIDs.idmenu).style.filter = this
						._GetElement(vworldIDs.idshim).style.filter = 'alpha(opacity=100)';
			}
			if (type == 'off') {
				this._GetElement(vworldIDs.idmenu).style.height = this
						._GetElement(vworldIDs.idshim).style.height = '66px';
				this._GetElement(vworldIDs.idmenu).style.opacity = this
						._GetElement(vworldIDs.idshim).style.opacity = 1;
				this._GetElement(vworldIDs.idmenu).style.filter = this
						._GetElement(vworldIDs.idshim).style.filter = 'alpha(opacity=100)';
			}
		},
		_getAbsPos : function(obj) {
			var curleft = 0, curtop = 0;
			if (obj.offsetParent) {
				do {
					curleft += obj.offsetLeft;
					curtop += obj.offsetTop;
				} while (obj = obj.offsetParent);
			}
			return [ curleft, curtop ];
		},
		_linkExtStyle : function(srcUrl) {
			var js = this._CreateElement('link');
			js.setAttribute('type', "text/css");
			js.setAttribute('href', srcUrl);
			js.setAttribute('rel', 'stylesheet');
			document.getElementsByTagName('head')[0].appendChild(js);
			return false;
		},
		_loadExtLibs : function(UrlArray, afterFunc) {
			var srcUrl = '', afterUrl = '';
			var remainUrls = UrlArray;
			if (remainUrls != null && remainUrls.length > 0) {
				srcUrl = remainUrls.shift();
			}
			if (srcUrl != '') {
				if (remainUrls.length > 0) {
					afterUrl = remainUrls[0];
				}
				var js = this._CreateElement('script');
				js.setAttribute('type', "text/javascript");
				js.setAttribute('src', srcUrl);
				js.setAttribute('async', false);
				js.onreadystatechange = function() {
					if (js.readyState == 'loaded'
							|| js.readyState == 'complete') {
						if (afterUrl != '') {
							js.onreadystatechange = null;
							vworldFunc._loadExtLibs(remainUrls, afterFunc);
						} else {
							afterFunc();
						}
					}
				}
				js.onload = function() {
					if (afterUrl != '') {
						js.onload = null;
						vworldFunc._loadExtLibs(remainUrls, afterFunc);
					} else {
						afterFunc();
					}
				}
				document.getElementsByTagName('head')[0].appendChild(js);
			}
			return false;
		},
		_parseURL : function(url) {
			var a = vworldFunc._CreateElement('a');
			a.href = url;
			return {
				source : url,
				protocol : a.protocol.replace(':', ''),
				host : a.hostname,
				port : a.port,
				query : a.search,
				path : a.pathname.replace(/^([^\/])/, '/$1')
			};
		}
	};
	vworldUtil = {
		validSearchList : function(is3D) {
			var returnstr = '';
			var allowbldg = false;
			if (!is3D) {
				var z = vmap.getZoom();
				var typelist = getServiceLayerList();
				var types = typelist.split(',');
				for (var i = 0; i < types.length; i++) {
					if (types[i] == "")
						break;
					if (types[i].toUpperCase() == 'LP_PA_CBND_BUBUN') {
						if (z >= 17)
							returnstr = returnstr + types[i] + ",";
					} else if (types[i].toUpperCase() == vworldVar.bldglayer) {
						if (z >= 16)
							returnstr = returnstr + types[i] + ",";
					} else {
						returnstr = returnstr + types[i] + ",";
					}
				}
				if (z >= 16)
					allowbldg = true;
			} else {
				if (vearth != null) {
					var dist = vearth.getViewCamera().getDistance();
					var len = vworldInfo.Layers3d.length;
					for (var i = len - 1; i >= 0; i--) {
						var tname = vworldInfo.Layers3d[i].info;
						if (tname.toUpperCase() == 'LP_PA_CBND_BUBUN') {
							if (dist <= 860)
								returnstr = returnstr + tname + ",";
						} else if (tname.toUpperCase() == vworldVar.bldglayer) {
							if (dist <= 2000)
								returnstr = returnstr + types[i] + ",";
						} else {
							returnstr = returnstr + tname + ",";
						}
					}
					if (dist <= 2000)
						allowbldg = true;
				}
			}
			if (allowbldg) {
				if (returnstr == '')
					returnstr = vworldVar.bldglayer;
			}
			return returnstr;
		},
		requestSearch : function(lon, lat, pixelX, pixelY, projection,
				searchlist, success, failure, extbuffer) {
			var msg = '검색좌표(lon):' + lon;
			msg += '\n검색좌표(lat):' + lat;
			msg += '\n검색픽셀(pixelX):' + pixelX;
			msg += '\n검색좌표(pixelY):' + pixelY;
			msg += '\n좌표계(projection):' + projection;
			msg += '\n검색대상(searchlist):' + searchlist;
			try {
				if (typeof (searchlist) != 'string' || searchlist.length == 0)
					return;
				var buffer = 1;
				if (typeof extbuffer == 'number')
					buffer = extbuffer;
				var typeName = (searchlist != null) ? searchlist : '';
				var types = typeName.split(',');
				if (typeof lon != 'number' || typeof lat != 'number'
						|| typeof pixelX != 'number'
						|| typeof pixelY != 'number'
						|| typeof searchlist != 'string' || types.length == 0) {
					alert('검색조건(인자)이 올바르지 않습니다. 확인 후 다시 시도하여 주십시오.\n\n' + msg);
					return;
				}
				vworldUtil._initInfos();
				vworldInfo.lonlat = new OpenLayers.LonLat(lon, lat);
				vworldInfo.pixel.x = pixelX;
				vworldInfo.pixel.y = pixelY;
				var x = lon;
				var y = lat;
				if (projection == 'EPSG:4326' || projection == 'EPSG:4019') {
					var min = OpenLayers.Util.destinationVincenty(
							new OpenLayers.LonLat(lon, lat), 225, buffer);
					var max = OpenLayers.Util.destinationVincenty(
							new OpenLayers.LonLat(lon, lat), 45, buffer);
					var MinX = Math.abs(min.lat);
					var MinY = Math.abs(min.lon);
					var MaxX = Math.abs(max.lat);
					var MaxY = Math.abs(max.lon);
				} else {
					var pixel = new OpenLayers.Pixel(pixelX - 4, pixelY + 4);
					var min = thisMap.getLonLatFromPixel(pixel);
					var pixel = new OpenLayers.Pixel(pixelX + 4, pixelY - 4);
					var max = thisMap.getLonLatFromPixel(pixel);
					var MinX = Math.abs(min.lon);
					var MinY = Math.abs(min.lat);
					var MaxX = Math.abs(max.lon);
					var MaxY = Math.abs(max.lat);
				}
				var SearchPoint = MinX + "," + MinY + "," + MaxX + "," + MaxY;
				var filterText = "BBOX=" + SearchPoint;
				var fieldinfo = null;
				var properties = "";
				for (var i = 0; i < types.length; i++) {
					fieldinfo = null;
					if (types[i] == "")
						break;
					if ((typeof _queryFields == 'object')
							&& (_queryFields.length > 0)) {
						fieldinfo = _queryFields.getList(types[i])
					}
					;
					if (fieldinfo != null) {
						properties += "(" + fieldinfo.fields.join(',')
								+ ",AG_GEOM)";
					} else {
						if (i == 0 && types.length == 2) {
							properties += ",";
						} else {
							properties += "()";
						}
					}
				}
				if (typeName.substr(-1) === ',')
					typeName = typeName.substring(0, typeName.length - 1);
				if (properties.substr(-1) === ',')
					properties = properties.substring(0, properties.length - 1);
				var successCall = vworldUtil.treatResponse;
				var failureCall = vworldUtil.treatFailure;
				if (typeof success == 'function') {
					successCall = success;
				}
				if (typeof failure == 'function') {
					failureCall = failure;
				}
				var params = "TYPENAME=" + typeName;
				params += "&" + filterText;
				if (properties != ',' && properties != '()')
					params += "&propertyname=" + properties;
				if (typeName.indexOf(vworldVar.bldglayer) == 0)
					params += "&MAXFEATURES=1";
				params += "&SERVICE=WFS";
				params += "&REQUEST=GetFeature";
				params += "&srsname=" + projection.toLowerCase();
				params += "&OUTPUTFORMAT=text/xml;%20subtype=gml/2.1.2";
				params += "&VERSION=1.1.0";
				params += "&EXCEPTIONS=text/xml";
				params += "&apiKey=" + vworldApiKey;
				var reqUrl = "";
				var callbackurl = null;
				var lkey = "";
				if ((typeof _queryCallBacks == 'object')
						&& _queryCallBacks.length > 0) {
					callbackurl = _queryCallBacks.getList(typeName);
				}
				if (callbackurl != null && !callbackurl.wfs) {
					params += "&bldgPos=POINT(" + lon + " " + lat + ")";
					reqUrl = callbackurl.urls[0];
					successCall = vworldUtil.treatResponseBldg;
					failureCall = vworldUtil.treatFailureBldg;
				} else {
					reqUrl = vworldUrls.wfs;
				}
				var reqConfig = OpenLayers.Util.extend({
					url : reqUrl,
					data : params,
					headers : {
						"Content-Type" : "text/plain"
					},
					success : successCall,
					failure : failureCall,
					scope : this
				}, {
					method : "POST"
				});
				OpenLayers.Request.issue(reqConfig);
			} catch (e) {
				alert("공간정보조회를 실패하였습니다.\n\n" + e.message);
			}
		},
		treatFailureBldg : function(response) {
		},
		treatResponseBldg : function(response) {
			var html = response.responseText;
			if (html != "") {
				vworldFunc._popupView('', 'layerView0', 500, 500, "hidden",
						false, html);
			}
		},
		treatFailure : function(response) {
		},
		treatResponse : function(response) {
			var xmlObj = response.responseXML;
			var g = new OpenLayers.Format.GML();
			g.featureNS = v_protocol + "www.deegree.org/app";
			g.featurePrefix = "app";
			var responStr = response.responseText;
			var features = g.read(responStr);
			if (features.length < 1)
				return;
			var bounds;
			var hideinfo = true;
			features.sort(function(a, b) {
				var aval = a.fid.split('.')[0];
				var bval = b.fid.split('.')[0];
				return aval < bval ? -1 : aval == bval ? 0 : 1;
			});
			vworldInfo.group = [];
			var initGroup = false;
			var curAlias = "";
			var curFeats = [];
			var curGroup = "";
			var tabCount = 0;
			for (var i = 0; i < features.length; i++) {
				initGroup = false;
				var tmpgroup = features[i].fid.split('.')[0];
				if (curGroup == "" || curGroup != tmpgroup) {
					if (curGroup != "") {
						vworldInfo.group.push({
							"alias" : curAlias,
							"layer" : curGroup,
							"features" : curFeats
						});
						tabCount++;
					}
					initGroup = true;
					curFeats = [];
					curAlias = "";
					curGroup = tmpgroup;
				}
				if (initGroup) {
					curAlias = allLayerList.getLayerKoNameFromName(curGroup);
					if (curAlias == '') {
						curAlias = curGroup;
					}
				}
				curFeats.push(features[i]);
				if (i == features.length - 1) {
					vworldInfo.group.push({
						"alias" : curAlias,
						"layer" : curGroup,
						"features" : curFeats
					});
					tabCount++;
				}
			}
			vworldUtil._information(0, 0);
			features = null;
		},
		_information : function(groupid, idx) {
			if (groupid >= vworldInfo.group.length || groupid == null) {
				groupid = 0;
			}
			if (idx >= vworldInfo.group[groupid].length || idx == null) {
				idx = 0;
			}
			var feature = vworldInfo.group[groupid].features[idx];
			var is3D = vworld.is3D();
			var canShow = true;
			var layername = feature.fid.split('.')[0];
			var callbackurl = null;
			if ((typeof _queryCallBacks == 'object')
					&& _queryCallBacks.length > 0) {
				callbackurl = _queryCallBacks.getList(layername);
			}
			if (callbackurl != null) {
				var lkey = callbackurl.key.toUpperCase();
				var lurls = callbackurl.urls;
				for ( var j in feature.attributes) {
					var key = null;
					if (j.indexOf(":") > 0)
						j = j.split(":")[1];
					if (j.toUpperCase() == lkey) {
						canShow = false;
						var key = feature.attributes[j];
						for (var i = 0; i < lurls.length; i++) {
							var url = lurls[i] + key;
							if (i > 0) {
								vworldFunc._popupView(url, 'layerView' + i,
										500, 500, "hidden", true, '');
							} else {
								vworldFunc._popupView(url, 'layerView' + i,
										500, 500, "hidden", false, '');
							}
						}
						break;
					}
				}
			}
			var content = "", subcontent = "";
			var Titles = null;
			var lcnt = 0;
			var alias = allLayerList.getLayerKoNameFromName(layername);
			if (alias == '' || alias == 'undefined' || alias == undefined) {
				alias = layername;
			}
			var sizeW = 140;
			var sizeH = 0;
			if (canShow || vworldInfo.group[groupid].features.length > 1
					|| vworldInfo.group.length > 1) {
				content = '<div class="olInfolayer olInfoboard" style="border:0!important;width:100%">';
				content += '  <div class="title"><h2 style="color: #026da5;font-size: 14px;font-weight: bold;margin: 0 0 0 7px;padding:2px 0 3px 0;"><span style="vertical-align:top">'
						+ alias + '</span></h2>';
				content += '    <a href="#" style="position: absolute;right: 45px;top: 0;margin-top: 9px;" onclick="vworldUtil._zoomToFeature(\''
						+ groupid
						+ '\',\''
						+ idx
						+ '\');"><img style="vertical-align:middle" src="/images/v2map/map/icon/icon_viewplus.gif"></a>';
				content += '    <a href="#" style="position: absolute;right: 30px;top: 0;margin-top: 9px;" onclick="vworldUtil._prevMap();"><img style="vertical-align:middle" src="/images/v2map/map/icon/icon_viewback.gif"></a>';
				content += '    <a href="#" class="layerX btnClose" onclick="vworldUtil._initInfos();"><img style="vertical-align:middle" src="/images/v2map/map/btn/btn-layer-x.png"></a>';
				content += '  </div>';
				content += '</div>';
				sizeH += 45;
				var tmpW = (alias.length * 24) + 45;
				if (sizeW < tmpW) {
					sizeW = tmpW;
				}
			}
			var height = 0;
			if (canShow) {
				if ((typeof _queryFields == 'object')
						&& _queryFields.length > 0) {
					Titles = _queryFields.getList(layername);
				}
				if (Titles != null) {
					for (var k = 0; k < Titles.fields.length; k++) {
						var fieldname = Titles.fields[k];
						var title = Titles.titles[k];
						var value = feature.attributes[fieldname.toLowerCase()]
								|| feature.attributes[fieldname.toUpperCase()];
						if (value == null || value == 'undefined'
								|| value == '0000') {
							value = "-";
						}
						var topBorder = "";
						var tmp1 = "" + k + "";
						var tmp2 = "" + value + "";
						var tmpW = 90 + (tmp2.length * 13) + 50;
						if (sizeW < tmpW) {
							sizeW = tmpW;
						}
						if (lcnt == 0)
							topBorder = 'style="border-top: 1px #a8a8a8 solid;"';
						subcontent += "<div class='nam' " + topBorder + ">"
								+ title + "</div><div class='val' " + topBorder
								+ " title='" + value + "'>" + value + "</div>";
						lcnt++;
					}
				} else {
					for ( var k in feature.attributes) {
						if ((k.toUpperCase() == 'BOUNDEDBY')
								|| (k.toUpperCase() == 'OBJECTID')
								|| (k.toUpperCase() == 'GID')
								|| (k.toUpperCase() == 'SHAPE_AREA')
								|| (k.toUpperCase() == 'SHAPE_LEN'))
							continue;
						var title = k;
						var value = feature.attributes[k];
						if (value == null || value == 'undefined'
								|| value == '0000') {
							value = "-";
						}
						var topBorder = "";
						var tmp1 = "" + k + "";
						var tmp2 = "" + value + "";
						var tmpW = 90 + (tmp2.length * 13) + 50;
						if (sizeW < tmpW) {
							sizeW = tmpW;
						}
						if (lcnt == 0)
							topBorder = 'style="border-top: 1px #a8a8a8 solid;"';
						subcontent += "<div class='nam' " + topBorder + ">"
								+ title + "</div><div class='val' " + topBorder
								+ " title='" + value + "'>" + value + "</div>";
						lcnt++;
					}
				}
				height = lcnt * 26;
				sizeH += height + 7;
			}
			if (height > 300) {
				sizeH = 350;
				height = 301;
			}
			var paging = "";
			if (vworldInfo.group[groupid].features.length > 1) {
				paging = "<div class='no_list' style='height:35px;'>&nbsp;</div>";
				paging += "<div class='navi' style='padding-left:calc(50% - "
						+ (vworldInfo.group[groupid].features.length * 10)
						+ "px)'>";
				for (var ei = 0; ei < vworldInfo.group[groupid].features.length; ei++) {
					var ci = ei + 1;
					var classname = "";
					if (ei == idx) {
						classname = "navi_focus";
					} else {
						classname = "navi";
					}
					paging += "<a class='" + classname
							+ "' href='javascript:vworldUtil._information("
							+ groupid + "," + ei + ");'>" + ci + "</a>";
				}
				paging += "</div>";
				var tmpW = vworldInfo.group[groupid].features.length * 21;
				if (sizeW < tmpW) {
					sizeW = tmpW;
				}
				sizeH += 37;
			}
			if (height > 0) {
				content += "<div class='list' style=\'margin-top:42px;height:"
						+ height + "px;overflow: hidden; overflow-y: auto;\'>"
						+ subcontent + "</div>";
			}
			content += paging;
			var nidx = idx + 1;
			if (nidx >= vworldInfo.group.length) {
				nidx = 0;
			}
			if (vworldInfo.group.length > 1) {
				var str = "[지도 선택]";
				content += "<div class='etc'><div class='name'> " + str
						+ "</div>";
				sizeH += 95;
			}
			var tmpW = 0;
			for (var ni = 0; ni < vworldInfo.group.length; ni++) {
				if (ni != groupid) {
					var alias = vworldInfo.group[ni].alias;
					content += "<a class='etc' href='javascript:vworldUtil._information("
							+ ni + ",0);'>" + alias + "</a>";
					tmpW += alias.length * 12 + 10;
					if (tmpW > 250) {
						tmpW = 250;
						sizeH += 30;
					}
					if (sizeW < tmpW) {
						sizeW = tmpW;
					}
					if (tmpW >= 250) {
						tmpW = 0;
					}
				}
			}
			if (canShow && (vworldInfo.group[groupid].features.length >= 1)) {
				if (vworldInfo.group.length > 1) {
					content += '    <a href="#" style="position: absolute;top: 63px;left: 15px;bottom: 0px;margin-bottom: 10px;" onclick="vworldUtil._getFeatureInfos(\''
							+ groupid
							+ '\');"><img style="vertical-align:middle" src="/images/v2map/map/btn/btn-excel.gif"></a>';
				} else {
					content += '    <div><a href="#" style="padding-left: 15px;" onclick="vworldUtil._getFeatureInfos(\''
							+ groupid
							+ '\');"><img style="vertical-align:middle" src="/images/v2map/map/btn/btn-excel.gif"></a></div>';
					sizeH += 30;
				}
			}
			if (vworldInfo.group.length > 1) {
				content += "</div>";
			}
			var finalX = finalY = 0;
			var curCenter = vworldInfo.lonlat.clone();
			var maxw = vworldFunc._GetElement(vworldIDs.idpanel).offsetWidth;
			var maxh = vworldFunc._GetElement(vworldIDs.idpanel).offsetHeight;
			if (!canShow && (content != "")) {
				var top = vworldFunc._GetElement(vworldIDs.idpanel).offsetTop;
				if (maxw >= 600 && maxh >= 600) {
					if (!is3D) {
						vworldInfo.pixel = vmap.getPixelFromLonLat(curCenter);
					}
					finalX = 630 - vworldInfo.pixel.x;
					if (finalX > 0) {
						if (!is3D) {
							vworldInfo.pixel.x = 630;
							vmap.pan(-finalX, 0);
						} else {
							var camcenter = vearth.getViewCamera()
									.getCenterPoint();
							if (curCenter.lon < camcenter.Longitude) {
								vworldInfo.pixel.x = 630;
								var newLon = feature.geometry.getBounds().left;
								vearth.getViewCamera().moveLonLat(newLon,
										camcenter.Latitude);
							}
						}
					}
				}
			}
			if (content != "") {
				var width = sizeW * 1.3;
				var height = sizeH;
				if (width > 600) {
					width = 600;
				}
				var tmpw = vworldInfo.pixel.x + width;
				var tmph = vworldInfo.pixel.y + height;
				if (tmpw > maxw) {
					vworldInfo.pixel.x -= (tmpw - maxw);
				}
				if (tmph > maxh) {
					vworldInfo.pixel.y -= (tmph - maxh);
				}
				var left = vworldInfo.pixel.x;
				var top = vworldInfo.pixel.y;
				var divpop = vworldFunc
						._GetElement(vworld.enums.POP_CONTENT_ID);
				if (divpop == null) {
					divpop = vworldFunc._CreateElement('div');
				}
				divpop.style.display = 'none';
				divpop.setAttribute('id', vworld.enums.POP_CONTENT_ID);
				divpop.frameBorder = '0';
				divpop.scrolling = 'no';
				divpop.style.position = 'absolute';
				divpop.style.overflow = 'hidden';
				divpop.style.width = width + 'px';
				divpop.style.height = height + 'px';
				divpop.style.left = left + 'px';
				divpop.style.top = top + 'px';
				divpop.style.border = "2px solid #696969";
				divpop.className = 'olFramedCloudPopupContent';
				divpop.style.zIndex = 10001;
				var infopop = vworldFunc._GetElement(vworld.enums.POP_FRAME_ID);
				if (infopop == null) {
					infopop = vworldFunc._CreateElement('iframe');
				}
				infopop.style.display = 'none';
				infopop.setAttribute('id', vworld.enums.POP_FRAME_ID);
				infopop.frameBorder = '0';
				infopop.scrolling = 'no';
				infopop.style.position = 'absolute';
				infopop.style.overflow = 'hidden';
				infopop.style.width = width + 'px';
				infopop.style.height = height + 'px';
				infopop.style.left = left + 'px';
				infopop.style.top = top + 'px';
				infopop.style.zIndex = 10000;
				vworldFunc._GetElement(vworldIDs.idpanel).appendChild(infopop);
				vworldFunc._GetElement(vworldIDs.idpanel).appendChild(divpop);
				divpop.innerHTML = content;
				divpop.style.display = 'inline-block';
				infopop.style.display = 'inline-block';
				var ifdocDrag = false;
				var originXtitle = 0;
				var originYtitle = 0;
				var tempX = 0;
				var tempY = 0;
				divpop.onmouseup = function() {
					ifdocDrag = false;
				};
				divpop.onmousedown = function() {
					ifdocDrag = true;
					originXtitle = infopop.style.pixelLeft;
					originYtitle = infopop.style.pixelTop;
					tempX = self.event.clientX;
					tempY = self.event.clientY;
					document.onmousemove = function() {
						if (ifdocDrag) {
							vworldInfo.pixel.x = originXtitle
									+ self.event.clientX - tempX;
							vworldInfo.pixel.y = originYtitle
									+ self.event.clientY - tempY;
							vworldFunc._GetElement(vworld.enums.POP_CONTENT_ID).style.pixelLeft = vworldInfo.pixel.x;
							vworldFunc._GetElement(vworld.enums.POP_CONTENT_ID).style.pixelTop = vworldInfo.pixel.y;
							infopop.style.pixelLeft = vworldInfo.pixel.x;
							infopop.style.pixelTop = vworldInfo.pixel.y;
							return false;
						}
					};
				}
				vworldUtil._addFeature(feature);
			}
		},
		_getFeatureInfos : function(groupid) {
			if (groupid >= vworldInfo.group.length || groupid == null) {
				groupid = 0;
			}
			var feature = vworldInfo.group[groupid].features[0];
			var layername = feature.fid.split('.')[0];
			var response = [];
			var Titles = null;
			var values = [];
			var lcnt = 0;
			var alias = allLayerList.getLayerKoNameFromName(layername);
			if (alias == '' || alias == 'undefined' || alias == undefined) {
				alias = layername;
			}
			if ((typeof _queryFields == 'object') && _queryFields.length > 0) {
				Titles = _queryFields.getList(layername);
			}
			response.push({
				name : alias,
				titles : [],
				values : []
			});
			if (Titles != null) {
				response[0].titles = JSON.parse(JSON.stringify(Titles.titles));
			} else {
				for ( var k in feature.attributes) {
					if ((k.toUpperCase() == 'BOUNDEDBY')
							|| (k.toUpperCase() == 'OBJECTID')
							|| (k.toUpperCase() == 'GID')
							|| (k.toUpperCase() == 'SHAPE_AREA')
							|| (k.toUpperCase() == 'SHAPE_LEN'))
						continue;
					var title = k;
					response[0].titles.push(title);
				}
			}
			response[0].titles.push("지오메트리(WKT)");
			var wkt = new OpenLayers.Format.WKT();
			for (var i = 0; i < vworldInfo.group[groupid].features.length; i++) {
				var feature = vworldInfo.group[groupid].features[i];
				var geomWkt = wkt.write(feature);
				var curline = [];
				if (Titles != null) {
					for (var k = 0; k < Titles.fields.length; k++) {
						var fieldname = Titles.fields[k];
						var title = Titles.titles[k];
						var value = feature.attributes[fieldname.toLowerCase()]
								|| feature.attributes[fieldname.toUpperCase()];
						if (value == null || value == 'undefined'
								|| value == '0000') {
							value = " ";
						}
						curline.push(value);
					}
				} else {
					for ( var k in feature.attributes) {
						if ((k.toUpperCase() == 'BOUNDEDBY')
								|| (k.toUpperCase() == 'OBJECTID')
								|| (k.toUpperCase() == 'GID')
								|| (k.toUpperCase() == 'SHAPE_AREA')
								|| (k.toUpperCase() == 'SHAPE_LEN'))
							continue;
						var title = k;
						var value = feature.attributes[k];
						if (value == null || value == 'undefined'
								|| value == '0000') {
							value = " ";
						}
						curline.push(value);
					}
				}
				curline.push(geomWkt);
				values.push(curline);
			}
			response[0].values = values;
			var _body = document.getElementsByTagName('body')[0];
			var form = vworldFunc._CreateElement('form');
			form.method = 'POST';
			form.action = '/js/util/features.jsp';
			var field = vworldFunc._CreateElement('input');
			field.type = 'hidden';
			field.name = "data";
			field.value = JSON.stringify(response[0]);
			form.appendChild(field);
			_body.appendChild(form);
			form.submit();
			_body.removeChild(form);
		},
		_initInfos : function() {
			vworldInfo.group = null;
			for (var i = 0; i < vworld.pops.length; i++) {
				var pop = vworldFunc._GetElement(vworld.pops[i]);
				if (pop != null) {
					pop.style.display = 'none';
				}
			}
			var is3D = vworld.is3D();
			var objects = [];
			if (is3D && (vearth != null)) {
			} else {
				objects = vworldInfo.objects2d.slice();
				vworldInfo.objects2d = [];
				for (var i = 0; i < objects.length; i++) {
					try {
						var feat = vmap.vectorLayer.getFeatureById(objects[i]);
						if (feat) {
							vmap.vectorLayer.removeFeatures([ feat ], {
								silent : true
							});
						}
					} catch (e) {
					}
				}
			}
			objects = [];
		},
		_initInfoFeature : function() {
			var is3D = vworld.is3D();
			var objects = [];
			if (is3D && (vearth != null)) {
				objects = vworldInfo.objects3d.slice();
				vworldInfo.objects3d = [];
				for (var i = 0; i < objects.length; i++) {
					try {
						vearth.getUserLayer().removeAtID(objects[i]);
					} catch (e) {
					}
				}
			} else {
				objects = vworldInfo.objects2d.slice();
				vworldInfo.objects2d = [];
				for (var i = 0; i < objects.length; i++) {
					try {
						var feat = vmap.vectorLayer.getFeatureById(objects[i]);
						if (feat) {
							vmap.vectorLayer.removeFeatures([ feat ], {
								silent : true
							});
						}
					} catch (e) {
					}
				}
			}
			objects = [];
		},
		_addFeature : function(feature) {
			var is3D = vworld.is3D();
			vworldUtil._initInfoFeature();
			var geometry = feature.geometry;
			var featureId = feature.fid;
			var addPoint = function(pointgeom, featureId) {
				if ((typeof (pointgeom) == 'undefined'))
					return;
				var vecarray = vearth.createVec3Array();
				var buffer = 0.00001;
				vecarray.pushLonLatAlt(pointgeom.x - Math.abs(buffer),
						pointgeom.y + Math.abs(buffer), '0');
				vecarray.pushLonLatAlt(pointgeom.x + Math.abs(buffer),
						pointgeom.y + Math.abs(buffer), '0');
				vecarray.pushLonLatAlt(pointgeom.x + Math.abs(buffer),
						pointgeom.y - Math.abs(buffer), '0');
				vecarray.pushLonLatAlt(pointgeom.x - Math.abs(buffer),
						pointgeom.y - Math.abs(buffer), '0');
				var poirect = vearth.createPolygon(featureId);
				poirect.setCoordinates(vecarray);
				var polyStyle = poirect.getStyle();
				var sopColor = polyStyle.getOutLineColor();
				sopColor.setARGB(255, 0, 255, 255);
				polyStyle.setOutLineColor(sopColor);
				var sopFillColor = polyStyle.getFillColor();
				sopFillColor.setARGB(255, 0, 255, 255);
				polyStyle.setFillColor(sopFillColor);
				polyStyle.setOutLineWidth(5.0);
				poirect.setStyle(polyStyle);
				vearth.getView().addChild(poirect, 13);
				vworldInfo.objects3d.push(poirect.getId());
			};
			var addLine = function(linegeom, featureId) {
				var vecarray = vearth.createVec3Array();
				for (var i = 0; i < linegeom.components.length; i++) {
					if ((typeof (linegeom.components[i]) == 'undefined'))
						continue;
					vecarray.pushLonLatAlt(linegeom.components[i].x,
							linegeom.components[i].y, '0');
				}
				var ls = vearth.createLineString(featureId);
				ls.setCoordinates(vecarray);
				var lineStyle = ls.getStyle();
				var sopColor = lineStyle.getColor();
				sopColor.setARGB(255, 0, 255, 255);
				lineStyle.setColor(sopColor);
				lineStyle.setWidth(5.0);
				ls.setStyle(lineStyle);
				vearth.getView().addChild(ls, 13);
				vworldInfo.objects3d.push(ls.getId());
			};
			var addPolygon = function(polygeom, featureId) {
				for (var j = 0; j < polygeom.components.length; j++) {
					var vecarray = vearth.createVec3Array();
					var vertices = polygeom.components[j].getVertices();
					var vlength = vertices.length;
					var totdist = 0;
					for (var i = 0; i < vlength; i++) {
						if ((typeof (vertices[i]) == 'undefined'))
							continue;
						vecarray.pushLonLatAlt(vertices[i].x, vertices[i].y,
								'0');
					}
					var rect = vearth.createPolygon(featureId + "_" + j);
					rect.setCoordinates(vecarray);
					var polyStyle = rect.getStyle();
					var sopColor = polyStyle.getOutLineColor();
					sopColor.setARGB(255, 0, 255, 255);
					polyStyle.setOutLineColor(sopColor);
					var sopFillColor = polyStyle.getFillColor();
					sopFillColor.setARGB(10, 0, 255, 255);
					polyStyle.setFillColor(sopFillColor);
					polyStyle.setOutLineWidth(5.0);
					rect.setStyle(polyStyle);
					vearth.getView().addChild(rect, 13);
					vworldInfo.objects3d.push(rect.getId());
				}
			};
			var addMultiPolygon = function(polygeom, featureId) {
				for (var j = 0; j < polygeom.components.length; j++) {
					if (polygeom.components[j].components != null) {
						var plength = polygeom.components[j].components.length;
						for (var k = 0; k < plength; k++) {
							var vertices = polygeom.components[j].components[k]
									.getVertices();
							var vlength = vertices.length;
							var totdist = 0;
							var vecarray = vearth.createVec3Array();
							for (var i = 0; i < vlength; i++) {
								if ((typeof (vertices[i]) == 'undefined'))
									continue;
								vecarray.pushLonLatAlt(vertices[i].x,
										vertices[i].y, '0');
							}
							var rect = vearth
									.createPolygon(featureId + "_" + k);
							rect.setCoordinates(vecarray);
							var polyStyle = rect.getStyle();
							var sopColor = polyStyle.getOutLineColor();
							sopColor.setARGB(255, 0, 255, 255);
							polyStyle.setOutLineColor(sopColor);
							var sopFillColor = polyStyle.getFillColor();
							sopFillColor.setARGB(10, 0, 255, 255);
							polyStyle.setFillColor(sopFillColor);
							polyStyle.setOutLineWidth(5.0);
							rect.setStyle(polyStyle);
							vearth.getView().addChild(rect, 13);
							vworldInfo.objects3d.push(rect.getId());
						}
					}
				}
			};
			try {
				if (is3D && (vearth != null)) {
					switch (geometry.CLASS_NAME) {
					case "OpenLayers.Geometry.Point":
						addPoint(geometry, featureId);
						break;
					case "OpenLayers.Geometry.LineString":
						addLine(geometry, featureId);
						break;
					case "OpenLayers.Geometry.LinearRing":
						addLine(geometry, featureId);
						break;
					case "OpenLayers.Geometry.Polygon":
						addPolygon(geometry, featureId);
						break;
					case "OpenLayers.Geometry.MultiPolygon":
						addMultiPolygon(geometry, featureId);
						break;
					default:
						break;
					}
				} else if (!is3D) {
					vmap.vectorLayer.addFeatures(feature);
					vworldInfo.objects2d.push(feature.id);
				}
				addPoint = addLine = addPolygon = null;
			} catch (e) {
			}
		},
		_zoomToFeature : function(groupid, idx) {
			var is3D = vworld.is3D();
			if (is3D && (vearth != null)) {
				var bounds = vworldInfo.group[groupid].features[idx].geometry
						.getBounds().clone();
				var center = bounds.getCenterLonLat();
				bounds = bounds.transform(
						new OpenLayers.Projection("EPSG:4326"),
						new OpenLayers.Projection("EPSG:900913"));
				var w = bounds.getWidth();
				var h = bounds.getHeight();
				if (w > h) {
					var dist = w * 1.2;
				} else {
					var dist = h * 1.2;
				}
				if (dist < 200) {
					dist = 200;
				}
				var vec3 = vearth.createVec3();
				vec3.Longitude = center.lon;
				vec3.Latitude = center.lat;
				var tilt = vearth.getViewCamera().getTilt();
				var direct = vearth.getViewCamera().getDirect();
				var camcenter = vearth.getViewCamera().getCenterPoint();
				var camdistance = vearth.getViewCamera().getDistance();
				vworldInfo.prev3dlonlat.push({
					lon : camcenter.Longitude,
					lat : camcenter.Latitude,
					tilt : tilt,
					direct : direct,
					distance : camdistance
				});
				vearth.getViewCamera().moveDist(vec3, tilt, direct, dist, 0);
			} else {
				vmap.zoomToExtent(
						vworldInfo.group[groupid].features[idx].geometry
								.getBounds(), false);
			}
		},
		_prevMap : function() {
			var is3D = vworld.is3D();
			if (is3D && (vearth != null)) {
				if (typeof vworldInfo.prev3dlonlat == "object"
						&& vworldInfo.prev3dlonlat.length > 0) {
					var prev = vworldInfo.prev3dlonlat.pop();
					var vec3 = vearth.createVec3();
					vec3.Longitude = prev.lon;
					vec3.Latitude = prev.lat;
					var tilt = prev.tilt;
					var direct = prev.direct;
					var dist = prev.distance;
					vearth.getViewCamera()
							.moveDist(vec3, tilt, direct, dist, 0);
				} else {
					return;
				}
			} else {
				vmap.prevMap();
			}
		},
		getProxyUrl : function() {
			return OpenLayers.ProxyHost;
		},
		setProxyUrl : function(newProxy) {
			try {
				OpenLayers.ProxyHost = newProxy;
			} catch (e) {
			}
		}
	};
	vworld = {
		useChart : false,
		useOSM : false,
		isLoaded : false,
		isLocked : false,
		showMode : true,
		viewMode : 0,
		_initCallBack : null,
		_failCallBack : null,
		_modeCallBack : null,
		_lockCallBack : null,
		_unlockCallBack : null,
		_queryFields : [],
		_queryCallBacks : [],
		_2dCalled : false,
		hideNotice : false,
		isMobile : false,
		setupMap : function() {
			try {
				if ((typeof (OpenLayers) == 'object')
						&& (typeof (LayerObjects) == 'object')) {
					this.isLoaded = true;
					vworld.WaterMark = OpenLayers
							.Class(
									OpenLayers.Control,
									{
										autoActivate : true,
										element : null,
										dataSource : 'VWORLD',
										isSimple : false,
										emptyString : null,
										initialize : function(options) {
											OpenLayers.Control.prototype.initialize
													.apply(this, arguments);
										},
										destroy : function() {
											this.deactivate();
											OpenLayers.Control.prototype.destroy
													.apply(this, arguments);
										},
										activate : function() {
											if (OpenLayers.Control.prototype.activate
													.apply(this, arguments)) {
												this.redraw();
												return true;
											} else {
												return false;
											}
										},
										deactivate : function() {
											if (OpenLayers.Control.prototype.deactivate
													.apply(this, arguments)) {
												return true;
											} else {
												return false;
											}
										},
										draw : function() {
											OpenLayers.Control.prototype.draw
													.apply(this, arguments);
											if (!this.element) {
												this.div.style.left = '10px';
												this.div.style.bottom = '6px';
												this.div.style.fontSize = '12px';
												this.div.style.fontWeight = 'bold';
												this.element = this.div;
											}
											return this.div;
										},
										redraw : function(evt) {
											if (evt == null) {
												this.reset();
											}
											var newHtml = this.formatOutput();
											if (newHtml != this.element.innerHTML) {
												vworldFunc._purge(this.element);
												this.element.innerHTML = newHtml;
											}
										},
										reset : function(evt) {
											if (this.emptyString != null) {
												vworldFunc._purge(this.element);
												this.element.innerHTML = this.emptyString;
											}
										},
										formatOutput : function() {
											this.element.style.color = "#111";
											if (this.isSimple)
												return "<img src='"
														+ vworldUrl
														+ "/images/maps/logo_openplatform_simple.png'/>";
											else
												return "<img src='"
														+ vworldUrl
														+ "/images/maps/logo_openplatform.png'/>";
										},
										changeMark : function(sType) {
											this.dataSource = sType;
											this.redraw();
										},
										CLASS_NAME : "vworld.WaterMark"
									});
					OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
					OpenLayers.DOTS_PER_INCH = 25.4 / 0.28;
					OpenLayers.Util.onImageLoadErrorColor = 'transparent';
					OpenLayers.Util.onImageLoadError = function() {
					};
					OpenLayers.Tile.Image.prototype.onImageError = function() {
					};
					OpenLayers.ImgPath = vworldUrlsExt.oltheme + "/";
					OpenLayers.ProxyHost = vworldUrl + "/proxy.do?url=";
					var displayProj = "EPSG:4326";
					var originalProj = "EPSG:900913";
					var buttonWidth = 30;
					var M_GROUP = -1;
					var M_LENGTH = "";
					var M_MEASURERING = false;
					var M_POPUP = null;
					var mapBounds = new OpenLayers.Bounds(119.532,
							31.95216223802497, 133, 45.089);
					var lonLatPosition;
					var focus_style = OpenLayers.Util.extend({},
							OpenLayers.Feature.Vector.style['default']);
					focus_style.strokeColor = "#E96016";
					focus_style.fillColor = "#ffffff";
					focus_style.strokeWidth = 4;
					focus_style.pointRadius = 6;
					focus_style.fillOpacity = 0.5;
					focus_style.strokeOpacity = 0.9;
					var stat_style = OpenLayers.Util.extend({},
							OpenLayers.Feature.Vector.style['default']);
					stat_style.strokeColor = "#E8ED7A";
					stat_style.fillColor = "#363441";
					stat_style.strokeWidth = 4;
					stat_style.fillOpacity = 0.5;
					stat_style.strokeOpacity = 0.7;
					stat_style.label = "${label}",
							stat_style.fontColor = "#C0C0FA";
					stat_style.fontFamily = "Dotum";
					stat_style.fontWeight = "bold";
					stat_style.fontSize = "14px";
					var stat_style_focus = OpenLayers.Util.extend({},
							OpenLayers.Feature.Vector.style['select']);
					stat_style_focus.strokeColor = "#FFFF00";
					stat_style_focus.fillColor = "#0000FF";
					stat_style_focus.strokeWidth = 8;
					stat_style_focus.fillOpacity = 1;
					stat_style_focus.strokeOpacity = 0.7;
					stat_style_focus.fontColor = "#FFFF00";
					stat_style_focus.fontSize = "22px";
					vworld.Maps = OpenLayers
							.Class(
									OpenLayers.Map,
									{
										tileManager : null,
										vworldBaseMap : null,
										vworldGrayMap : null,
										vworldMidnightMap : null,
										vworldRaster : null,
										vworldHybrid : null,
										vworldOrthoImg : null,
										vworldIndex : null,
										HybridVisibility : true,
										ovOptions : null,
										lastBounds : null,
										useOSM : false,
										minlevel : 6,
										maxlevel : 19,
										serverMaxlevel : vworldVers.ServerMaxLevel,
										ziRatio : 1,
										zoRatio : 1,
										zoomBarPosition : 'right',
										panZoomBarType : 'normal',
										mapToolPosition : "left-top",
										mapToolDirection : 'horizontal',
										mapToolbar : null,
										navi : null,
										zoomOutCon : null,
										zoomInCon : null,
										geolocCon : null,
										userMarkers : null,
										userGraphic : null,
										vectorLayer : null,
										userKml : null,
										posLayer : null,
										accLayer : null,
										measureControls : null,
										touchControl : null,
										displayProjection : null,
										projection : null,
										maxResolution : 2048,
										maxExtent : null,
										indexExtent : null,
										restrictedExtent : null,
										units : 'm',
										controls : [],
										indexMap : null,
										infoCon : null,
										noticeCon : null,
										clickAttribution : false,
										custompopups : [],
										initialize : function(div, options) {
											OpenLayers.Map.prototype.initialize
													.apply(this,
															[ div, options ]);
											if (options != null)
												return false;
											this.name = "VWORLD MAP";
											this.useOSM = vworld.useOSM;
											if (this.useOSM) {
												mapBounds = new OpenLayers.Bounds(
														119.532,
														31.95216223802497, 133,
														45.089);
											}
											mapBounds = this
													.getTransformBounds(mapBounds
															.clone());
											var maxExt = new OpenLayers.Bounds(
													-20037508.34, -20037508.34,
													20037508.34, 20037508.34);
											var maxRange = ((maxExt.right - maxExt.left) > (maxExt.top - maxExt.bottom)) ? (maxExt.right - maxExt.left)
													: (maxExt.top - maxExt.bottom);
											var indexExtent = new OpenLayers.Bounds(
													13149614.84995544,
													3757032.814272985,
													15028131.257091935,
													5635549.221409474);
											this.displayProjection = new OpenLayers.Projection(
													displayProj);
											this.projection = new OpenLayers.Projection(
													originalProj);
											this.maxExtent = maxExt;
											this.numZoomLevels = 21;
											this.maxResolution = 156543.0339;
											this.tileSize = new OpenLayers.Size(
													256, 256);
											this.center = new OpenLayers.LonLat(
													127, 38);
											this.indexBaseMap = new OpenLayers.Layer.TMS(
													"인덱스맵(배경지도)",
													vworldUrls.base,
													{
														isBaseLayer : true,
														maxExtent : maxExt,
														layername : 'index',
														type : 'png',
														numZoomLevels : 16,
														buffer : 0,
														getURL : this._getIndexBaseURL
													});
											this.indexRaster = new OpenLayers.Layer.TMS(
													"인덱스맵(영상)",
													vworldUrls.raster,
													{
														isBaseLayer : true,
														maxExtent : maxExt,
														layername : 'index',
														type : 'jpeg',
														numZoomLevels : 16,
														buffer : 0,
														getURL : this._getIndexBaseURL
													});
											if (vworldUrls.raster != "") {
												this.vworldRaster = new OpenLayers.Layer.TMS(
														"영상",
														vworldUrls.raster,
														{
															isBaseLayer : true,
															type : 'jpeg',
															maxExtent : maxExt,
															displayOutsideMaxExtent : true,
															wrapDateLine : true,
															transitionEffect : 'null',
															tileSize : new OpenLayers.Size(
																	256, 256),
															buffer : 0,
															numZoomLevels : 20,
															attribution : vworld.enums.COMMON_NOTICE_R,
															getURL : this._getBaseURL,
															displayInLayerSwitcher : false
														});
											} else {
												this.vworldRaster = null;
											}
											;
											this.vworldThemeBase = new OpenLayers.Layer.TMS(
													"theme",
													"",
													{
														isBaseLayer : false,
														type : 'jpg',
														maxExtent : maxExt,
														buffer : 0,
														singleTile : true,
														visibility : false,
														opacity : 0.5,
														getURL : this._getThemeURL,
														displayInLayerSwitcher : false
													});
											this.vworldBaseMap = new OpenLayers.Layer.TMS(
													"배경지도",
													vworldUrls.base,
													{
														isBaseLayer : true,
														type : 'png',
														maxExtent : maxExt,
														displayOutsideMaxExtent : true,
														wrapDateLine : true,
														transitionEffect : 'null',
														tileSize : new OpenLayers.Size(
																256, 256),
														buffer : 0,
														numZoomLevels : 20,
														attribution : vworld.enums.COMMON_NOTICE,
														getURL : this._getBaseURL,
														displayInLayerSwitcher : false
													});
											this.vworldGrayMap = new OpenLayers.Layer.TMS(
													"2D회색",
													vworldUrls.gray,
													{
														isBaseLayer : true,
														type : 'png',
														maxExtent : maxExt,
														displayOutsideMaxExtent : true,
														wrapDateLine : true,
														transitionEffect : 'null',
														tileSize : new OpenLayers.Size(
																256, 256),
														buffer : 0,
														numZoomLevels : 20,
														attribution : vworld.enums.COMMON_NOTICE,
														getURL : this._getBaseURL,
														displayInLayerSwitcher : false
													});
											this.vworldMidnightMap = new OpenLayers.Layer.TMS(
													"2D야간",
													vworldUrls.midnight,
													{
														isBaseLayer : true,
														type : 'png',
														maxExtent : maxExt,
														displayOutsideMaxExtent : true,
														wrapDateLine : true,
														transitionEffect : 'null',
														tileSize : new OpenLayers.Size(
																256, 256),
														buffer : 0,
														numZoomLevels : 20,
														attribution : vworld.enums.COMMON_NOTICE,
														getURL : this._getBaseURL,
														displayInLayerSwitcher : false
													});
											if (vworldUrls.hybrid != "") {
												this.vworldHybrid = new OpenLayers.Layer.TMS(
														"교통시설/명칭",
														vworldUrls.hybrid,
														{
															isBaseLayer : false,
															transitionEffect : 'null',
															displayOutsideMaxExtent : true,
															wrapDateLine : true,
															maxExtent : maxExt,
															tileSize : new OpenLayers.Size(
																	256, 256),
															type : 'png',
															numZoomLevels : this.numZoomLevels,
															buffer : 0,
															getURL : this._getBaseURL,
															visibility : false
														});
											} else {
												this.vworldHybrid = null;
											}
											;
											this.ovOptions = {
												maximized : true,
												mapOptions : {
													projection : new OpenLayers.Projection(
															originalProj),
													units : 'm',
													minZoomLevel : this.minlevel,
													maxResolution : this.maxResolution,
													maxExtent : maxExt
												},
												layers : [ this.indexBaseMap,
														this.indexRaster ]
											};
											this
													.addControls([
															new OpenLayers.Control.Navigation(),
															this.noticeCon = new OpenLayers.Control.Attribution(
																	{
																		separator : " "
																	}),
															this.vworldIndex = new vworld.OverviewMap(
																	this.ovOptions),
															new OpenLayers.Control.ScaleLine(
																	{
																		bottomOutUnits : '',
																		geodesic : true
																	}),
															new vworld.PanZoomBar(),
															new vworld.WaterMark() ]);
											this.userMarkers = new OpenLayers.Layer.Markers(
													"마커 레이어",
													{
														displayInLayerSwitcher : false
													});
											var renderer = OpenLayers.Util
													.getParameters(window.location.href).renderer;
											renderer = (renderer) ? [ renderer ]
													: OpenLayers.Layer.Vector.prototype.renderers;
											this.userGraphic = new OpenLayers.Layer.Vector(
													"사용자 도형 레이어",
													{
														styleMap : new OpenLayers.StyleMap(
																{
																	'default' : {
																		strokeColor : "${strokeColor}",
																		strokeOpacity : "${strokeOpacity}",
																		strokeWidth : "${strokeWidth}",
																		fillColor : "${fillColor}",
																		fillOpacity : "${fillOpacity}",
																		pointRadius : "${pointRadius}",
																		pointerEvents : 'visiblePainted',
																		graphicName : "${graphicName}",
																		fontColor : "${fontColor}",
																		fontSize : "${fontSize}",
																		fontFamily : "맑은 고딕, Lucida Console",
																		label : "${label}",
																		labelBackgroundColor : "${labelBackgroundColor}",
																		labelBorderColor : "${labelBorderColor}",
																		labelBorderSize : "1px",
																		labelAlign : "${labelAlign}"
																	}
																}),
														renderers : renderer,
														displayInLayerSwitcher : false
													});
											this.vectorLayer = new OpenLayers.Layer.Vector(
													"vectorLayer",
													{
														styleMap : new OpenLayers.StyleMap(
																focus_style),
														extractAttributes : true,
														displayInLayerSwitcher : false
													});
											if (this.vworldRaster != null) {
												this
														.addLayer(this.vworldRaster);
												if (this.vworldHybrid != null) {
													this
															.addLayer(this.vworldHybrid);
													this.vworldHybrid.events
															.register(
																	'visibilitychanged',
																	this,
																	function() {
																		if (this.baseLayer == this.vworldRaster)
																			this.HybridVisibility = this.vworldHybrid.visibility;
																	});
												}
											}
											this.addLayers([
													this.vworldBaseMap,
													this.vworldGrayMap,
													this.vworldMidnightMap,
													this.userGraphic,
													this.userMarkers,
													this.vworldThemeBase,
													this.vectorLayer ]);
											this.zoomTo(7);
											this.panTo(new OpenLayers.LonLat(
													14243425.793355,
													4342305.8698004));
											thisMap = this;
											this.events.unregister('moveend',
													this, this.onZoomChanged);
											this.events.register('moveend',
													this, this.onZoomChanged);
											this.events.unregister('zoomend',
													this, this.onZoomEnded);
											this.events.register('zoomend',
													this, this.onZoomEnded);
											this.events.register('zoomend',
													this,
													this.setThemeBackground);
											this.events.register('click', this,
													this.onMapClicked);
											this.vectorLayer.events
													.on({
														'beforefeatureremoved' : this.onBeforeFeatureRemoved
													});
											this.userGraphic.events
													.on({
														'beforefeatureremoved' : this.onBeforeFeatureRemoved
													});
											this.navi = new OpenLayers.Control.NavigationHistory();
											this.addControl(this.navi);
											this.zoomInCon = new OpenLayers.Control.ZoomBox();
											this.addControl(this.zoomInCon);
											this.zoomOutCon = new OpenLayers.Control.ZoomBox(
													{
														out : true
													});
											this.addControl(this.zoomOutCon);
											this.geolocCon = new OpenLayers.Control.Geolocate();
											this.addControl(this.geolocCon);
											if (this
													.getControlsByClass("vworld.PanZoomBar")[0] != null)
												this
														.getControlsByClass("vworld.PanZoomBar")[0].div.style.display = 'none';
											if (this
													.getControlsByClass("vworld.OverviewMap")[0] != null)
												this
														.getControlsByClass("vworld.OverviewMap")[0].div.style.display = 'none';
											this.infoCon = new vworld.InfoPoint();
											this.addControl(this.infoCon);
											this.mapToolbar = new OpenLayers.Control.Panel();
											this.addControl(this.mapToolbar);
											this.mapToolbar.div.style.width = 'auto';
											this.mapToolbar.div.style.height = buttonWidth
													+ 'px';
											var toolbarEvt = function(e) {
												OpenLayers.Event.stop(e);
												if (typeof e.target == 'object') {
													var ctl = null;
													for ( var x in thisMap.mapToolbar.controls) {
														thisMap.mapToolbar.controls[x]
																.deactivate();
														if (e.target.className
																.indexOf(thisMap.mapToolbar.controls[x].displayClass) == 0) {
															ctl = thisMap.mapToolbar.controls[x];
														}
													}
													if (ctl)
														ctl.trigger();
												}
											};
											if (this.mapToolbar.div.addEventListener) {
												this.mapToolbar.div
														.addEventListener(
																"touchend",
																toolbarEvt);
											} else if (this.mapToolbar.div.attachEvent) {
												this.mapToolbar.div
														.attachEvent(
																'ontouchend',
																toolbarEvt);
											}
											this.initMeasurement();
											this.viewPortDiv.oncontextmenu = OpenLayers.Function.False;
											this.events
													.register(
															'changebaselayer',
															this,
															function(e) {
																if ((e.layer.name == "배경지도")
																		|| (e.layer.name == "2D회색")
																		|| (e.layer.name == "2D야간")) {
																	if (this.vworldHybrid != null)
																		this.vworldHybrid
																				.setVisibility(false);
																}
															});
											var context = {
												getPointRadius : function(feat) {
													var res = thisMap
															.getResolution();
													return Math
															.round(feat.attributes.accuracy
																	/ res);
												}
											};
											var template = {
												pointRadius : "${getPointRadius}",
												fillColor : "#66ccff",
												fillOpacity : 0.3,
												strokeColor : "#3399ff",
												strokeWidth : 2
											};
											var style = new OpenLayers.Style(
													template, {
														context : context
													});
											if (this.getLayersByName("내 위치").length == 0) {
												this.posLayer = new OpenLayers.Layer.Markers(
														'내 위치',
														{
															numZoomLevels : this.numZoomLevels,
															maxExtent : maxExt
														});
												this.accLayer = new OpenLayers.Layer.Vector(
														'범위 표시',
														{
															numZoomLevels : this.numZoomLevels,
															maxExtent : maxExt,
															styleMap : new OpenLayers.StyleMap(
																	style)
														});
											}
										},
										_set3dInfoLayerState : function(name,
												state, wfsName) {
											var find = -1;
											var len = vworldInfo.Layers3d.length;
											for (var i = len - 1; i >= 0; i--) {
												if (i < 0)
													break;
												var tname = vworldInfo.Layers3d[i].name;
												if (tname == name) {
													find = i;
													break;
												}
											}
											if (find >= 0 && state == false) {
												vworldInfo.Layers3d.splice(
														find, 1);
											} else if (find < 0
													&& state == true) {
												vworldInfo.Layers3d.push({
													"name" : name,
													"info" : wfsName
												});
											}
										},
										_setInfoLayerState : function(title,
												state, wfsName) {
											if (allLayerList.size == 0)
												thisMap._setInfoLayers();
											for (var i = 0, len = thisMap.layers.length; i < len; i++) {
												var layer = thisMap.layers[i];
												var tmpname = layer.name;
												if (tmpname == title) {
													allLayerList.setLayerState(
															title, state);
												}
												if (layer.name
														.indexOf("theme_") > -1) {
													tmpname = layer.name
															.replace('theme_',
																	'');
													allLayerList.setLayerState(
															tmpname,
															layer.visibility);
												}
											}
											if (wfsName != null
													&& typeof wfsName != "undefined") {
												allLayerList
														.setLayerStateFromName(
																wfsName, state);
												if (title != null
														&& typeof title != "undefined") {
													allLayerList
															.setLayerKoNameFromName(
																	wfsName,
																	title);
												}
											}
										},
										_setInfoLayers : function() {
											var capabilitiesReq = "request=GetCapabilities&version=1.1.0&service=WFS&outputformat=text/xml";
											var reqConfig = OpenLayers.Util
													.extend(
															{
																url : vworldUrls.wfs
																		+ capabilitiesReq,
																headers : {
																	"Content-Type" : "text/plain"
																},
																success : setServiceLayerList,
																scope : this
															}, {
																method : "GET"
															});
											try {
												OpenLayers.Request
														.issue(reqConfig);
											} catch (e) {
											}
										},
										_clearInfos : function() {
											vworldUtil._initInfos();
											this.clearDisplayLayer(true);
										},
										_infoPointImplements : function(e) {
											if ((typeof _queryFields == 'undefined')
													|| (_queryFields.length < 1))
												return;
											var searchlist = "";
											thisMap._setInfoLayerState();
											searchlist = vworldUtil
													.validSearchList(false);
											var px = thisMap
													.getPixelFromLonLat(lonLatPosition);
											vworldUtil.requestSearch(
													lonLatPosition.lon,
													lonLatPosition.lat, px.x,
													px.y, originalProj,
													searchlist);
										},
										_getThemeURL : function(bounds) {
											return vworldUrl
													+ "/images/maps/themelayer.png";
										},
										_getIndexBaseURL : function(bounds) {
											var res = this.map.getResolution();
											var x = Math
													.round((bounds.left - this.maxExtent.left)
															/ (res * this.tileSize.w));
											var y = Math
													.round((this.maxExtent.top - bounds.top)
															/ (res * this.tileSize.h));
											var z = this.map.getZoom();
											var limit = Math.pow(2, z);
											if (y < 0 || y >= limit) {
												return vworldUrlsExt.blankimage;
											} else {
												x = ((x % limit) + limit)
														% limit;
												return this.url + z + "/" + x
														+ "/" + y + "."
														+ this.type;
											}
										},
										_getBaseURL : function(bounds) {
											var res = this.map.getResolution();
											var x = Math
													.round((bounds.left - this.maxExtent.left)
															/ (res * this.tileSize.w));
											var y = Math
													.round((this.maxExtent.top - bounds.top)
															/ (res * this.tileSize.h));
											var z = this.map.getZoom();
											var limit = Math.pow(2, z);
											if (y < 0 || y >= limit) {
												return vworldUrlsExt.blankimage;
											} else {
												x = ((x % limit) + limit)
														% limit;
												if (z > 0 && z < 6) {
													if (this.map.useOSM) {
														var path = "/" + z
																+ "/" + x + "/"
																+ y + ".png";
														if (OpenLayers.Util
																.isArray(vworldOthers.osmurl)) {
															var thisurl = this
																	.selectUrl(
																			path,
																			vworldOthers.osmurl);
															return thisurl
																	+ path;
														}
													} else {
														return this.url + z
																+ "/" + x + "/"
																+ y + "."
																+ this.type;
													}
												} else {
													if (mapBounds
															.intersectsBounds(bounds)) {
														if (z >= 6
																&& z <= this.map.serverMaxlevel) {
															return this.url + z
																	+ "/" + x
																	+ "/" + y
																	+ "."
																	+ this.type;
														} else if (z > this.map.serverMaxlevel) {
															var n = z
																	- this.map.serverMaxlevel;
															var z2 = z - n;
															var nsize = 256 * Math
																	.pow(2, n);
															var x = Math
																	.round((bounds.left - this.maxExtent.left)
																			/ (res * nsize));
															var y = Math
																	.round((this.maxExtent.top - bounds.top)
																			/ (res * nsize));
															x = ((x % limit) + limit)
																	% limit;
															return this.url
																	+ z2 + "/"
																	+ x + "/"
																	+ y + "."
																	+ this.type;
														} else
															return vworldUrlsExt.blankimage;
													} else {
														if (this.map.useOSM) {
															var path = "/" + z
																	+ "/" + x
																	+ "/" + y
																	+ ".png";
															if (OpenLayers.Util
																	.isArray(vworldOthers.osmurl)) {
																var thisurl = this
																		.selectUrl(
																				path,
																				vworldOthers.osmurl);
																return thisurl
																		+ path;
															}
														} else
															return vworldUrlsExt.blankimage;
													}
												}
											}
										},
										getThemeLayerByName : function(name) {
											var layer = thisMap
													.getLayerByName(vworldCategory.theme
															+ name);
											if (layer == null)
												layer = thisMap
														.getLayerByName(vworldCategory.wms
																+ name);
											if (layer == null)
												layer = thisMap
														.getLayerByName(vworldCategory.cache
																+ name);
											if (layer == null)
												layer = thisMap
														.getLayerByName(vworldCategory.stat
																+ name);
											return layer;
										},
										getLayerByName : function(name) {
											for (var i = 0, len = thisMap.layers.length; i < len; i++) {
												var layer = thisMap.layers[i];
												if (layer.name == name) {
													return layer;
													break;
												}
											}
											return null;
										},
										alarmInit : function(msg) {
											alert(msg);
											for ( var a in this) {
												this[a] = function() {
												};
											}
										},
										checkZoomLevel : function(zoom) {
											var res = false;
											if (zoom < this.minlevel) {
												alert("최소 줌레벨인 "
														+ this.minlevel
														+ " 이하로 줌레벨을 설정할 수 없습니다.");
												res = true;
											}
											if (zoom > this.maxlevel) {
												alert("최대 줌레벨인 "
														+ this.maxlevel
														+ " 이상으로 줌레벨을 설정할 수 없습니다.");
												res = true;
											}
											return res;
										},
										onMapClicked : function(e) {
											e = e ? e : window.event;
											if (!thisMap.isMeasuring()) {
												var curoffset = vworldFunc
														._getAbsPos(vworldFunc
																._GetElement(vworldIDs.id2d));
												var x = e.clientX
														- curoffset[0];
												var y = e.clientY
														- curoffset[1];
												var pixel = new OpenLayers.Pixel(
														x, y);
												lonLatPosition = thisMap
														.getLonLatFromPixel(pixel);
												thisMap
														._infoPointImplements(null);
											}
											if (e.preventDefault) {
												e.preventDefault();
											} else {
												return false;
											}
											return false;
										},
										onBeforeFeatureRemoved : function(e) {
											var feat = e.feature;
											if (feat.popup != null) {
												this.map
														.removePopup(feat.popup);
												feat.popup.destroy();
												delete feat.popup;
											}
										},
										onZoomEnded : function(e) {
											var x = this.getZoom();
											if (x < 0) {
												this.zoomTo(0);
												this.zoomToExtent(this
														.getExtent(), true);
												setTimeout(
														'alert("지도를 더이상 축소하실 수 없습니다.")',
														200);
											}
											if (x < this.minlevel) {
												this
														.setZoomLevel(this.minlevel);
											} else if (x > this.maxlevel) {
												this
														.setZoomLevel(this.maxlevel);
											} else
												return;
										},
										_onDummyZoomChanged : function(x, max) {
											var gridRedraw = function(layer, x) {
												if (layer == null)
													return;
												if (x > max) {
													var n = x - max;
													var nsize = 256 * Math.pow(
															2, n);
													layer.initProperties();
													layer.clearGrid();
													layer.tileSize = new OpenLayers.Size(
															nsize, nsize);
													layer.setTileSize();
													layer.redraw();
												} else {
													if (layer.tileSize == null)
														return;
													if (layer.tileSize.w != 256) {
														layer.initProperties();
														layer.clearGrid();
														layer.tileSize = new OpenLayers.Size(
																256, 256);
														layer.setTileSize();
														layer.redraw();
													}
												}
											};
											if (this.vworldBaseMap != null)
												gridRedraw(this.vworldBaseMap,
														x);
											if (this.vworldRaster != null)
												gridRedraw(this.vworldRaster, x);
											if (this.vworldHybrid != null)
												gridRedraw(this.vworldHybrid, x);
											if (this.vworldGrayMap != null)
												gridRedraw(this.vworldGrayMap,
														x);
											if (this.vworldMidnightMap != null)
												gridRedraw(
														this.vworldMidnightMap,
														x);
										},
										onZoomChanged : function(e) {
											for (var i = 0, len = this.custompopups.length; i < len; i++) {
												if (this.custompopups[i] != null)
													this.custompopups[i]
															.updatePosition();
											}
											var x = this.getZoom();
											this._onDummyZoomChanged(x,
													this.serverMaxlevel);
										},
										setBounds : function(bounds) {
											this
													.zoomToExtent(new OpenLayers.Bounds(
															bounds.left,
															bounds.top,
															bounds.right,
															bounds.bottom));
										},
										getBounds : function() {
											return this.calculateBounds();
										},
										showProgress : function(type) {
											var div = vworldFunc
													._GetElement(vworldIDs.idloading);
											if (div == null)
												return;
											if (div.style.display != "inline-block") {
												div.style.display = "inline-block";
											}
											div.style.visibility = 'visible';
										},
										hideProgress : function() {
											var div = vworldFunc
													._GetElement(vworldIDs.idloading);
											if (div == null)
												return;
											div.innerText = "";
											div.style.display = "none";
											div.style.visibility = 'hidden';
										},
										initAll : function() {
											this.init();
											this.clear();
										},
										init : function() {
											this._emptyMeasurement();
											this.clearMeasureEvent();
											this.clearButtonEvent();
										},
										clear : function() {
											this.initMeasurement();
											this._clearInfos();
										},
										zoomIn : function() {
											this.clearButtonEvent();
											var zl = this.getZoom();
											if (!isNaN(this.getZoominRatio())) {
												this
														.zoomTo(eval(zl
																+ (1 * this
																		.getZoominRatio())));
											} else {
												this.zoomTo(eval(zl + 1));
											}
										},
										zoomOut : function() {
											this.clearButtonEvent();
											var zl = this.getZoom();
											if (!isNaN(this.getZoomoutRatio())) {
												this
														.zoomTo(eval(zl
																- (1 * this
																		.getZoomoutRatio())));
											} else {
												this.zoomTo(eval(zl - 1));
											}
										},
										zoomBoxIn : function() {
											this.init();
											this.zoomInCon.activate();
											this.div.style.cursor = "url("
													+ vworldUrl
													+ "/images/maps/zoomin.cur),default";
										},
										zoomBoxOut : function() {
											this.init();
											this.zoomOutCon.activate();
											this.div.style.cursor = "url("
													+ vworldUrl
													+ "/images/maps/zoomout.cur),default";
										},
										infoOn : function() {
											this.init();
											this.infoCon.activate();
											this.div.style.cursor = "url("
													+ vworldUrl
													+ "/images/maps/info.cur),default";
										},
										getControlName : function(type) {
											var controlName = '';
											switch (type) {
											case 'zoomBar':
												controlName = "vworld.PanZoomBar";
												break;
											case 'indexMap':
												controlName = "vworld.OverviewMap";
												break;
											case 'layerSwitch':
												controlName = "OpenLayers.Control.LayerSwitcher";
												break;
											default:
												break;
											}
											return controlName;
										},
										zoomToAuto : function(bounds, zoom,
												closest) {
											var center = bounds
													.getCenterLonLat();
											var res = OpenLayers.Util
													.getResolutionFromScale(
															zoom, this.units);
											var size = this.size;
											var w = size.w * res;
											var h = size.h * res;
											var extent = new OpenLayers.Bounds(
													center.lon - w / 2,
													center.lat - h / 2,
													center.lon + w / 2,
													center.lat + h / 2);
											extent.extend(bounds);
											var mzoom = this.getZoomLevel();
											var bzoom = this.getZoomForExtent(
													bounds, closest);
											if (!this.getExtent()
													.containsBounds(bounds)) {
												if (mzoom > bzoom) {
													this.zoomToExtent(extent,
															closest);
												} else {
													this.setCenter(center,
															mzoom);
												}
											} else {
												this.setCenter(center, mzoom);
											}
										},
										setCenterAndZoom : function(cx, cy,
												zoom, proj) {
											if (zoom == -1)
												zoom = this.getZoomLevel();
											if (typeof (proj) == 'undefined')
												proj = originalProj;
											var lonlat = new OpenLayers.LonLat(
													cx, cy).transform(
													new OpenLayers.Projection(
															proj),
													new OpenLayers.Projection(
															originalProj));
											this.setCenter(lonlat, zoom, false,
													true);
										},
										setCenterXY : function(cx, cy) {
											this.setCenter(
													new OpenLayers.LonLat(cx,
															cy), this
															.getZoomLevel());
										},
										getCenterXY : function() {
											return {
												cx : this.getCenter().lon,
												cy : this.getCenter().lat
											};
										},
										setZoomLevel : function(zoom) {
											this.setCenter(this.getCenter(),
													zoom);
										},
										getZoomLevel : function() {
											return this.getZoom();
										},
										zoomInRatio : function() {
											var zi = eval(this.getZoom())
													+ eval(this
															.getZoominRatio());
											if (zi > this.maxlevel) {
												alert("최대 줌레벨인 "
														+ this.maxlevel
														+ " 이상으로 줌레벨을 설정할 수 없습니다.");
											} else {
												this.zoomTo(zi);
											}
										},
										zoomOutRatio : function() {
											var zo = eval(this.getZoom())
													- eval(this
															.getZoomoutRatio());
											if (zo < this.minlevel) {
												alert("최소 줌레벨인 "
														+ this.minlevel
														+ " 이하로 줌레벨을 설정할 수 없습니다.");
											} else
												this.zoomTo(zo);
										},
										setZoominRatio : function(zr) {
											this.ziRatio = zr;
										},
										getZoominRatio : function() {
											return this.ziRatio;
										},
										setZoomoutRatio : function(zr) {
											this.zoRatio = zr;
										},
										getZoomoutRatio : function() {
											return this.zoRatio;
										},
										setMinLevel : function(minZoom) {
											this.minlevel = minZoom;
										},
										getMinLevel : function() {
											return this.minlevel;
										},
										setMaxLevel : function(maxZoom) {
											this.maxlevel = maxZoom;
										},
										getMaxLevel : function() {
											return this.maxlevel;
										},
										setMaxExtent : function(extent) {
											if (extent
													&& (extent instanceof OpenLayers.Bounds)) {
												this.setOptions({
													restrictedExtent : extent
												});
											}
										},
										addVWORLDControl : function(type) {
											var controlName = this
													.getControlName(type);
											if (this
													.getControlsByClass("OpenLayers.Control."
															+ type)[0] == null) {
												switch (type) {
												case 'zoomBar':
													if (this
															.getControlsByClass("vworld.PanZoomBar")[0] == null) {
														this
																.addControl(new vworld.PanZoomBar());
													} else {
														this
																.getControlsByClass("vworld.PanZoomBar")[0].div.style.display = 'block';
													}
													break;
												case 'indexMap':
													if (this
															.getControlsByClass("vworld.OverviewMap")[0] == null) {
														this
																.addControl(new vworld.OverviewMap(
																		this.ovOptions));
													} else {
														this
																.getControlsByClass("vworld.OverviewMap")[0].div.style.display = 'block';
													}
													break;
												case 'layerSwitch':
													if (this
															.getControlsByClass("OpenLayers.Control.LayerSwitcher")[0] == null) {
														this
																.addControl(new OpenLayers.Control.LayerSwitcher(
																		{
																			roundedCornerColor : "#3f3f3f"
																		}));
													} else {
														this
																.getControlsByClass("OpenLayers.Control.LayerSwitcher")[0].div.style.display = 'block';
													}
													break;
												default:
													break;
												}
											}
											if (type == 'mapTool')
												this.mapToolbar.activate();
											else {
												if (this
														.getControlsByClass(controlName)[0] != null) {
													this
															.getControlsByClass(controlName)[0]
															.activate();
												}
											}
										},
										removeVWORLDControl : function(type) {
											if (type != 'mapTool') {
												var controlName = this
														.getControlName(type);
												if ((controlName != '')
														&& (this
																.getControlsByClass(controlName)[0] != null)) {
													if (type == 'indexMap') {
														this
																.getControlsByClass(controlName)[0].div.style.display = 'none';
													} else {
														this
																.removeControl(this
																		.getControlsByClass(controlName)[0]);
													}
												}
											} else {
												this.mapToolbar.deactivate();
											}
										},
										isVWORLDControlEnable : function(type) {
											if (type != 'mapTool') {
												var controlName = this
														.getControlName(type);
												return ((this
														.getControlsByClass(controlName)[0] != null) && (this
														.getControlsByClass(controlName)[0].active));
											} else {
												return this.mapToolbar.active;
											}
										},
										_removeCustomPopup : function(popup) {
											OpenLayers.Util.removeItem(
													this.custompopups, popup);
											if (popup.div) {
												try {
													this.layerContainerDiv
															.removeChild(popup.div);
												} catch (e) {
												}
											}
											popup.map = null;
										},
										_addCustomPopup : function(popup,
												exclusive) {
											popup.map = this;
											this.custompopups.push(popup);
											var popupDiv = popup.draw();
											if (popupDiv) {
												popupDiv.style.zIndex = this.Z_INDEX_BASE['Popup']
														+ this.custompopups.length;
												this.layerContainerDiv
														.appendChild(popupDiv);
											}
										},
										addEvent : function(name, func) {
											this.events.register(name, this,
													func);
										},
										removeEvent : function(name, func) {
											this.events.unregister(name, this,
													func);
										},
										isEventExist : function(name, funcName) {
											var res = false;
											var sFunc = '';
											for (var i = 0; i < this.events.listeners[name].length; i++) {
												sFunc = ''
														+ this.events.listeners[name][i].func;
												res = (sFunc.indexOf(funcName) > -1);
											}
											return res;
										},
										panXy : function(mx, my) {
											this.pan(mx, my);
										},
										fullExtent : function() {
											this.zoomToMaxExtent();
										},
										getCurrentLocation : function() {
											if (this.geolocCon != null) {
												this.geolocCon.activate();
												this.geolocCon
														.getCurrentLocation();
											}
										},
										prevMap : function() {
											if (this.navi != null)
												this.navi.previous.trigger();
										},
										nextMap : function() {
											if (this.navi != null)
												this.navi.next.trigger();
										},
										_emptyMeasurement : function() {
											if (M_POPUP != null) {
												M_POPUP.hide();
											}
											if (M_GROUP > -1
													&& M_MEASURERING == true)
												this._clearMeasurement(M_GROUP);
											M_MEASURERING = false;
										},
										_clearMeasurement : function(idx) {
											while (this.userGraphic
													.getFeatureBy('groupId',
															idx) != null) {
												var feat = this.userGraphic
														.getFeatureBy(
																'groupId', idx);
												if (feat != null) {
													this.userGraphic
															.removeFeatures(feat);
												}
											}
										},
										initMeasurement : function() {
											this._emptyMeasurement();
											for (var i = 0; i <= M_GROUP; i++) {
												this._clearMeasurement(i);
											}
											M_GROUP = -1;
											if (this.measureControls != null) {
												this.measureControls['line']
														.deactivate();
												this.measureControls['polygon']
														.deactivate();
											}
											var sketchColor = '#0649FB';
											var sketchSymbolizers = {
												'Point' : {
													pointRadius : 4,
													graphicName : 'square',
													fillColor : 'white',
													fillOpacity : 1,
													strokeWidth : 1,
													strokeOpacity : 1,
													strokeColor : sketchColor
												},
												'Line' : {
													strokeWidth : 4,
													strokeOpacity : 0.6,
													strokeColor : sketchColor,
													strokeDashstyle : 'solid'
												},
												'Polygon' : {
													strokeWidth : 4,
													strokeOpacity : 0.6,
													strokeColor : sketchColor,
													fillColor : sketchColor,
													fillOpacity : 0.3
												}
											};
											var style = new OpenLayers.Style();
											style
													.addRules([ new OpenLayers.Rule(
															{
																symbolizer : sketchSymbolizers
															}) ]);
											var styleMap = new OpenLayers.StyleMap(
													{
														'default' : style
													});
											var getTimeString = function(min) {
												var h = parseInt(min / 60);
												var m = parseInt(min % 60);
												if (h != 0 && m != 0) {
													return h + "시간 " + m + "분";
												} else if (h != 0 && m == 0) {
													return h + "시간 ";
												} else if (h == 0 && m != 0) {
													return m + "분";
												} else {
													return "1분 미만";
												}
											};
											var getTimeStringhtml = function(
													min) {
												var h = parseInt(min / 60);
												var m = parseInt(min % 60);
												if (h != 0 && m != 0) {
													return "<strong class='num'>"
															+ h
															+ "</strong>시간<strong class='num'> "
															+ m + "</strong>분";
												} else if (h != 0 && m == 0) {
													return "<strong class='num'>"
															+ h
															+ "</strong>시간 ";
												} else if (h == 0 && m != 0) {
													return "<strong class='num'>"
															+ m + "</strong>분";
												} else {
													return "<strong class='num'>1</strong>분 미만";
												}
											};
											vworld.PathHandler = OpenLayers
													.Class(
															OpenLayers.Handler.Path,
															{
																handlers : null,
																initialize : function(
																		control,
																		callbacks,
																		options) {
																	this.handlers = {
																		keyboard : new OpenLayers.Handler.Keyboard(
																				this,
																				{
																					keydown : this.handleKeypress
																				})
																	};
																	OpenLayers.Handler.Path.prototype.initialize
																			.apply(
																					this,
																					arguments);
																},
																activate : function() {
																	return this.handlers.keyboard
																			.activate()
																			&& OpenLayers.Handler.Path.prototype.activate
																					.apply(
																							this,
																							arguments);
																},
																deactivate : function() {
																	var deactivated = false;
																	if (OpenLayers.Handler.Path.prototype.deactivate
																			.apply(
																					this,
																					arguments)) {
																		this.handlers.keyboard
																				.deactivate();
																		deactivated = true;
																	}
																	return deactivated;
																},
																handleKeypress : function(
																		evt) {
																	var code = evt.keyCode;
																	if (code === 27) {
																		if (M_MEASURERING) {
																			this
																					.finishGeometry();
																		}
																	}
																},
																addPoint : function(
																		pixel) {
																	this.layer
																			.removeFeatures([ this.point ]);
																	var lonlat = this.layer
																			.getLonLatFromViewPortPx(pixel);
																	this.point = new OpenLayers.Feature.Vector(
																			new OpenLayers.Geometry.Point(
																					lonlat.lon,
																					lonlat.lat));
																	this.line.geometry
																			.addComponent(
																					this.point.geometry,
																					this.line.geometry.components.length);
																	this.layer
																			.addFeatures([ this.point ]);
																	this
																			.callback(
																					"point",
																					[
																							this.point.geometry,
																							this
																									.getGeometry() ]);
																	this
																			.callback(
																					"modify",
																					[
																							this.point.geometry,
																							this
																									.getSketch() ]);
																	this
																			.drawFeature();
																	delete this.redoStack;
																	var vertices = this.line.geometry
																			.getVertices();
																	var vlength = vertices.length;
																	var totdist = 0;
																	for (var i = 0; i < vlength - 1; i++) {
																		var p1 = new OpenLayers.Geometry.Point(
																				vertices[i].x,
																				vertices[i].y);
																		var p2 = new OpenLayers.Geometry.Point(
																				vertices[i + 1].x,
																				vertices[i + 1].y);
																		if ((typeof (p1) == 'undefined')
																				|| (typeof (p2) == 'undefined'))
																			continue;
																		var segment = new OpenLayers.Geometry.LineString(
																				[
																						p1,
																						p2 ]);
																		var tmpdist = segment
																				.getGeodesicLength(new OpenLayers.Projection(
																						originalProj));
																		totdist += tmpdist;
																	}
																	totdist = totdist / 1000;
																	if (totdist >= 1.0) {
																		M_LENGTH = totdist
																				.toFixed(1)
																				+ "㎞";
																	} else {
																		M_LENGTH = (totdist * 1000)
																				.toFixed(1)
																				+ "m";
																	}
																	var lonlat = this.map
																			.getLonLatFromPixel(pixel);
																	var pointFeature = new OpenLayers.Feature.Vector(
																			new OpenLayers.Geometry.Point(
																					lonlat.lon,
																					lonlat.lat));
																	var out = "";
																	var middlehtml = "";
																	var relativePosition = "bl";
																	if (!M_MEASURERING) {
																		relativePosition = "bl";
																		out = "START";
																		middlehtml += "<div class='etcbox_s'>START</div>";
																		M_LENGTH = "";
																		M_GROUP++;
																		pointFeature.attributes = {
																			pointRadius : 4,
																			graphicName : 'square',
																			fillColor : 'white',
																			fillOpacity : 1,
																			strokeWidth : 1,
																			strokeOpacity : 1,
																			strokeColor : sketchColor,
																			fontSize : '11px',
																			fontColor : "white",
																			labelBackgroundColor : sketchColor,
																			labelBorderColor : sketchColor,
																			labelAlign : 'rt',
																			label : "",
																			labeltext : out
																		};
																	} else {
																		relativePosition = "tr";
																		out = M_LENGTH;
																		middlehtml += "<div class='etcbox_m'>"
																				+ M_LENGTH
																				+ "</div>";
																		pointFeature.attributes = {
																			pointRadius : 4,
																			graphicName : 'square',
																			fillColor : 'white',
																			fillOpacity : 1,
																			strokeWidth : 1,
																			strokeOpacity : 1,
																			strokeColor : sketchColor,
																			fontSize : '11px',
																			fontColor : sketchColor,
																			labelBackgroundColor : 'white',
																			labelBorderColor : sketchColor,
																			labelAlign : 'lb',
																			label : "",
																			labeltext : out
																		};
																	}
																	pointFeature.groupId = M_GROUP;
																	this.map.userGraphic
																			.addFeatures([ pointFeature ]);
																	M_MEASURERING = true;
																	if (middlehtml != "") {
																		var px = this.map
																				.getPixelFromLonLat(lonlat);
																		var position = this.map
																				.getLonLatFromPixel(px);
																		var labelpop = new vworld.AnchoredPopup(
																				"label_d_pop",
																				new OpenLayers.LonLat(
																						position.lon,
																						position.lat),
																				null,
																				middlehtml,
																				null,
																				false);
																		labelpop.relativePosition = relativePosition;
																		pointFeature.popup = labelpop;
																		this.map
																				._addCustomPopup(pointFeature.popup);
																	}
																}
															});
											vworld.PolygonHandler = OpenLayers
													.Class(
															OpenLayers.Handler.Polygon,
															{
																handlers : null,
																initialize : function(
																		control,
																		callbacks,
																		options) {
																	this.handlers = {
																		keyboard : new OpenLayers.Handler.Keyboard(
																				this,
																				{
																					keydown : this.handleKeypress
																				})
																	};
																	OpenLayers.Handler.Polygon.prototype.initialize
																			.apply(
																					this,
																					arguments);
																},
																activate : function() {
																	return this.handlers.keyboard
																			.activate()
																			&& OpenLayers.Handler.Polygon.prototype.activate
																					.apply(
																							this,
																							arguments);
																},
																deactivate : function() {
																	var deactivated = false;
																	if (OpenLayers.Handler.Polygon.prototype.deactivate
																			.apply(
																					this,
																					arguments)) {
																		this.handlers.keyboard
																				.deactivate();
																		deactivated = true;
																	}
																	return deactivated;
																},
																handleKeypress : function(
																		evt) {
																	var code = evt.keyCode;
																	if (code === 27
																			|| code === 39) {
																		if (M_MEASURERING) {
																			this
																					.finishGeometry();
																		}
																	}
																},
																addPoint : function(
																		pixel) {
																	if (!this.drawingHole
																			&& this.holeModifier
																			&& this.evt
																			&& this.evt[this.holeModifier]) {
																		var geometry = this.point.geometry;
																		var features = this.control.layer.features;
																		var candidate, polygon;
																		for (var i = features.length - 1; i >= 0; --i) {
																			candidate = features[i].geometry;
																			if ((candidate instanceof OpenLayers.Geometry.Polygon || candidate instanceof OpenLayers.Geometry.MultiPolygon)
																					&& candidate
																							.intersects(geometry)) {
																				polygon = features[i];
																				this.control.layer
																						.removeFeatures(
																								[ polygon ],
																								{
																									silent : true
																								});
																				this.control.layer.events
																						.registerPriority(
																								"sketchcomplete",
																								this,
																								this.finalizeInteriorRing);
																				this.control.layer.events
																						.registerPriority(
																								"sketchmodified",
																								this,
																								this.enforceTopology);
																				polygon.geometry
																						.addComponent(this.line.geometry);
																				this.polygon = polygon;
																				this.drawingHole = true;
																				break;
																			}
																		}
																	}
																	OpenLayers.Handler.Path.prototype.addPoint
																			.apply(
																					this,
																					arguments);
																	var out = "";
																	var vertices = this.polygon.geometry
																			.getVertices();
																	var vlength = vertices.length;
																	if (vlength >= 2) {
																		var totdist = curdist = 0;
																		for (var i = 0; i < vlength - 1; i++) {
																			var p1 = new OpenLayers.Geometry.Point(
																					vertices[i].x,
																					vertices[i].y);
																			var p2 = new OpenLayers.Geometry.Point(
																					vertices[i + 1].x,
																					vertices[i + 1].y);
																			if ((typeof (p1) == 'undefined')
																					|| (typeof (p2) == 'undefined'))
																				continue;
																			var segment = new OpenLayers.Geometry.LineString(
																					[
																							p1,
																							p2 ]);
																			var tmpdist = segment
																					.getGeodesicLength(new OpenLayers.Projection(
																							originalProj));
																			if (tmpdist > 0)
																				curdist = tmpdist;
																			totdist += tmpdist;
																		}
																		curdist = (curdist / 1000);
																		if (curdist >= 1.0) {
																			out = curdist
																					.toFixed(1)
																					+ "㎞";
																		} else {
																			out = (curdist * 1000)
																					.toFixed(1)
																					+ "m";
																		}
																		totdist = (totdist / 1000);
																		if (totdist >= 1.0) {
																			out += "/"
																					+ totdist
																							.toFixed(1)
																					+ "㎞";
																		} else {
																			out += "/"
																					+ (totdist * 1000)
																							.toFixed(1)
																					+ "m";
																		}
																		M_LENGTH = "<div class='measurebox_b'>"
																				+ out
																				+ "</div>";
																	}
																	var lonlat = this.map
																			.getLonLatFromPixel(pixel);
																	var pointFeature = new OpenLayers.Feature.Vector(
																			new OpenLayers.Geometry.Point(
																					lonlat.lon,
																					lonlat.lat));
																	var middlehtml = "";
																	var relativePosition = "bl";
																	if (!M_MEASURERING) {
																		out = "";
																		M_LENGTH = "";
																		M_GROUP++;
																		pointFeature.attributes = {
																			pointRadius : 4,
																			graphicName : 'square',
																			fillColor : 'white',
																			fillOpacity : 1,
																			strokeWidth : 1,
																			strokeOpacity : 1,
																			strokeColor : sketchColor,
																			fontSize : '11px',
																			fontColor : "white",
																			labelBackgroundColor : sketchColor,
																			labelBorderColor : "white",
																			labelAlign : 'rt',
																			label : "",
																			labeltext : out
																		};
																	} else {
																		relativePosition = "tr";
																		middlehtml += M_LENGTH;
																		pointFeature.attributes = {
																			pointRadius : 4,
																			graphicName : 'square',
																			fillColor : 'white',
																			fillOpacity : 1,
																			strokeWidth : 1,
																			strokeOpacity : 1,
																			strokeColor : sketchColor,
																			fontSize : '11px',
																			fontColor : sketchColor,
																			labelBackgroundColor : 'white',
																			labelBorderColor : sketchColor,
																			labelAlign : 'lb',
																			label : "",
																			labeltext : out
																		};
																	}
																	pointFeature.groupId = M_GROUP;
																	this.map.userGraphic
																			.addFeatures([ pointFeature ]);
																	M_MEASURERING = true;
																	if (middlehtml != "") {
																		var px = this.map
																				.getPixelFromLonLat(lonlat);
																		var position = this.map
																				.getLonLatFromPixel(px);
																		var labelpop = new vworld.AnchoredPopup(
																				"label_a_pop",
																				new OpenLayers.LonLat(
																						position.lon,
																						position.lat),
																				null,
																				middlehtml,
																				null,
																				false);
																		labelpop.relativePosition = relativePosition;
																		pointFeature.popup = labelpop;
																		this.map
																				._addCustomPopup(pointFeature.popup);
																	}
																}
															});
											if (this.measureControls == null) {
												this.measureControls = {
													line : new OpenLayers.Control.Measure(
															vworld.PathHandler,
															{
																persist : false,
																geodesic : true,
																immediate : true,
																handlerOptions : {
																	layerOptions : {
																		styleMap : styleMap
																	}
																}
															}),
													polygon : new OpenLayers.Control.Measure(
															vworld.PolygonHandler,
															{
																persist : false,
																geodesic : true,
																immediate : true,
																handlerOptions : {
																	layerOptions : {
																		styleMap : styleMap
																	}
																}
															})
												};
												if (this
														.getControlsByClass("OpenLayers.Control.Measure") != null) {
													for ( var key in this.measureControls) {
														this.measureControls[key].events
																.on({
																	'measure' : function(
																			event) {
																		var geometry = event.geometry;
																		var units = event.units;
																		var order = event.order;
																		var measure = event.measure;
																		var val = Math
																				.floor(1000 * measure) / 1000;
																		var dist = val;
																		var out = val
																				.toFixed(1)
																				+ ""
																				+ units;
																		if (units == 'm')
																			dist = dist / 1000;
																		var id = M_GROUP;
																		var middlehtml = "";
																		var relativePosition = "tr";
																		M_LENGTH = "";
																		M_MEASURERING = false;
																		var out3 = "";
																		if (order == 1) {
																			var wtime1 = getTimeString(parseInt((dist * 1000 * 60) / 4000));
																			var btime1 = getTimeString(parseInt((dist * 1000 * 60) / 20000));
																			out3 = "총거리     "
																					+ out
																					+ "\n"
																					+ "도보     "
																					+ wtime1
																					+ "\n"
																					+ "자전거     "
																					+ btime1;
																			var wtime = getTimeStringhtml(parseInt((dist * 1000 * 60) / 4000));
																			var btime = getTimeStringhtml(parseInt((dist * 1000 * 60) / 20000));
																			var out2 = "총거리     "
																					+ out
																					+ "\n"
																					+ "도보     "
																					+ wtime
																					+ "\n"
																					+ "자전거     "
																					+ btime;
																			var valc = vworldFunc
																					._commify(val
																							.toFixed(1));
																			middlehtml = "<div class='measurebox'><ul><li><span class='name'>총거리</span><span class='value'><strong class='num'>"
																					+ valc
																					+ "</strong>"
																					+ units
																					+ "</span></li>";
																			middlehtml += "<li><span class='name'>도   보</span><span class='value'>"
																					+ wtime
																					+ "</span></li>";
																			middlehtml += "<li><span class='name'>자전거</span><span class='value'>"
																					+ btime
																					+ "</span></li></ul></div>";
																		} else {
																			dist = Math
																					.floor(1000 * val) / 1000;
																			if (units == 'm') {
																				units = "㎡ ";
																			} else if (units == 'km') {
																				units = "㎢ ";
																			}
																			var valc = vworldFunc
																					._commify(dist
																							.toFixed(1));
																			out3 = "총면적    "
																					+ valc
																					+ ""
																					+ units;
																			middlehtml = "<div class='measurebox'><ul><li><span class='name'>총면적</span><span class='value'><strong class='num'>"
																					+ valc
																					+ "</strong>"
																					+ units
																					+ "</span></li></ul></div>";
																		}
																		var temp = geometry.components[geometry.components.length - 1];
																		if (typeof (temp.x) == 'undefined') {
																			temp = temp.components[0];
																		}
																		var pos = new OpenLayers.LonLat(
																				temp.x,
																				temp.y);
																		var pointFeature = new OpenLayers.Feature.Vector(
																				new OpenLayers.Geometry.Point(
																						pos.lon,
																						pos.lat));
																		pointFeature.attributes = {
																			pointRadius : 4,
																			graphicName : 'square',
																			fillColor : 'white',
																			fillOpacity : 1,
																			strokeWidth : 1,
																			strokeOpacity : 1,
																			strokeColor : sketchColor,
																			fontSize : '11px',
																			fontColor : sketchColor,
																			labelBackgroundColor : 'white',
																			labelBorderColor : sketchColor,
																			labelAlign : 'lb',
																			label : "",
																			labeltext : out3
																		};
																		pointFeature.groupId = id;
																		if (middlehtml != "") {
																			var px = this.map
																					.getPixelFromLonLat(pos);
																			var position = this.map
																					.getLonLatFromPixel(px);
																			var labelpop = new vworld.AnchoredPopup(
																					"label_a_pop",
																					new OpenLayers.LonLat(
																							position.lon,
																							position.lat),
																					null,
																					middlehtml,
																					null,
																					false);
																			labelpop.relativePosition = relativePosition;
																			pointFeature.popup = labelpop;
																			this.map
																					._addCustomPopup(pointFeature.popup);
																		}
																		var lineFeature = new OpenLayers.Feature.Vector(
																				geometry
																						.clone());
																		lineFeature.attributes = {
																			strokeWidth : 4,
																			strokeOpacity : 0.6,
																			strokeColor : sketchColor,
																			fillColor : sketchColor,
																			fillOpacity : 0.3,
																			pointRadius : "2",
																			fontSize : '11px',
																			fontColor : sketchColor,
																			labelBackgroundColor : 'white',
																			labelBorderColor : sketchColor,
																			labelAlign : 'rb',
																			label : '',
																			labeltext : ''
																		};
																		lineFeature.groupId = id;
																		this.map.userGraphic
																				.addFeatures([
																						lineFeature,
																						pointFeature ]);
																		var close = new vworld.ClosePopup(
																				new OpenLayers.LonLat(
																						pos.lon,
																						pos.lat),
																				function() {
																					this.map
																							._clearMeasurement(id);
																				});
																		lineFeature.popup = close;
																		this.map
																				._addCustomPopup(lineFeature.popup);
																		if (M_POPUP != null) {
																			M_POPUP
																					.hide();
																		}
																		thisMap
																				.init();
																	},
																	'measurepartial' : function(
																			event) {
																		var geometry = event.geometry;
																		var units = event.units;
																		var order = event.order;
																		var measure = event.measure;
																		var val = Math
																				.floor(1000 * measure) / 1000;
																		var dist = val;
																		var out = "";
																		var id = M_GROUP;
																		var middlehtml = "";
																		if (units == 'm')
																			dist = dist / 1000;
																		var vertices = geometry
																				.getVertices();
																		var vlength = vertices.length;
																		if (order == 1) {
																			var wtime = getTimeStringhtml(parseInt((dist * 1000 * 60) / 4000));
																			var btime = getTimeStringhtml(parseInt((dist * 1000 * 60) / 20000));
																			var valc = vworldFunc
																					._commify(val
																							.toFixed(1));
																			middlehtml = "<div class='measurebox'><ul><li><span class='name'>총거리</span><span class='value'><strong class='num'>"
																					+ valc
																					+ "</strong>"
																					+ units
																					+ "</span></li>";
																			middlehtml += "<li><span class='name'>도   보</span><span class='value'>"
																					+ wtime
																					+ "</span></li>";
																			middlehtml += "<li><span class='name'>자전거</span><span class='value'>"
																					+ btime
																					+ "</span></li></ul></div>";
																			middlehtml += "<div class='etcbox'>화면 더블클릭 또는 </br>키보드 'Esc'를 누르면</br> 종료합니다.</div>";
																		} else {
																			if (units == 'm') {
																				units = "㎡ ";
																			} else if (units == 'km') {
																				units = "㎢ ";
																			}
																			var valc = vworldFunc
																					._commify(val
																							.toFixed(1));
																			middlehtml = "<div class='measurebox'><ul><li><span class='name'>총면적</span><span class='value'><strong class='num'>"
																					+ valc
																					+ "</strong>"
																					+ units
																					+ "</span></li></ul></div>";
																			middlehtml += "<div class='etcbox'>화면 더블클릭 또는 </br>키보드 'Esc'를 누르면</br> 종료합니다.</div>";
																		}
																		var temp = geometry.components[geometry.components.length - 1];
																		if (typeof (temp.x) == 'undefined') {
																			temp = temp.components[0];
																		}
																		temp = new OpenLayers.Geometry.Point(
																				vertices[vlength - 1].x,
																				vertices[vlength - 1].y);
																		if (middlehtml != "") {
																			var pos = new OpenLayers.LonLat(
																					temp.x,
																					temp.y);
																			var px = this.map
																					.getPixelFromLonLat(pos);
																			px.x += 4;
																			px.y += 2;
																			var position = this.map
																					.getLonLatFromPixel(px);
																			if (M_POPUP == null) {
																				M_POPUP = new OpenLayers.Popup(
																						"M_POPUP",
																						new OpenLayers.LonLat(
																								position.lon,
																								position.lat),
																						null,
																						middlehtml,
																						false);
																				M_POPUP.autoSize = true;
																			} else {
																				M_POPUP
																						.show();
																			}
																			M_POPUP.lonlat = new OpenLayers.LonLat(
																					position.lon,
																					position.lat);
																			M_POPUP.contentHTML = middlehtml;
																			this.map
																					.addPopup(
																							M_POPUP,
																							true);
																		} else {
																			if (M_POPUP != null) {
																				M_POPUP
																						.hide();
																			}
																		}
																	}
																});
														this
																.addControl(this.measureControls[key]);
													}
												}
											}
										},
										calcDistance : function() {
											this.init();
											this.measureControls['line']
													.activate();
											if (vworldFunc._isIE()) {
												this.div.style.cursor = "url("
														+ vworldUrl
														+ "/images/maps/caldist.cur),default";
											} else {
												this.div.style.cursor = "url("
														+ vworldUrl
														+ "/images/maps/caldist.cur) 0 31,default";
											}
										},
										calcArea : function() {
											this.init();
											this.measureControls['polygon']
													.activate();
											if (vworldFunc._isIE()) {
												this.div.style.cursor = "url("
														+ vworldUrl
														+ "/images/maps/calarea.cur),default";
											} else {
												this.div.style.cursor = "url("
														+ vworldUrl
														+ "/images/maps/calarea.cur) 0 31,default";
											}
										},
										mapRefresh : function() {
											for (var i = 0; i < this.layers.length; i++)
												this.layers[i].redraw();
										},
										addMarker : function(marker) {
											this.userMarkers.addMarker(marker);
										},
										addMarkers : function(markers) {
											if (typeof markers !== 'object')
												return null;
											var fragment = document
													.createDocumentFragment();
											var opacity = this.userMarkers.opacity;
											for (var i = 0, len = markers.length; i < len; i++) {
												markers[i].map = thisMap;
												markers[i].setOpacity(opacity);
												var px = thisMap
														.getLayerPxFromLonLat(markers[i].lonlat);
												if (px != null) {
													var markerImg = markers[i]
															.draw(px);
													fragment
															.appendChild(markerImg);
												}
											}
											this.userMarkers.markers = this.userMarkers.markers
													.concat(markers);
											this.userMarkers.div
													.appendChild(fragment);
										},
										clearMarkers : function() {
											this.userMarkers.clearMarkers();
										},
										getMarker : function(index) {
											return this.userMarkers.markers[index];
										},
										getMarkerSize : function(index) {
											return this.userMarkers.markers[index].icon.size;
										},
										getMarkerCount : function() {
											return this.userMarkers.markers.length;
										},
										getMarkerIndex : function(marker) {
											return OpenLayers.Util.indexOf(
													this.userMarkers.markers,
													marker);
										},
										setMarkerOrder : function(marker, type) {
											if (this.userMarkers.markers.length < 1)
												return;
											var topindex = this.userMarkers.markers.length - 1;
											var index = 0;
											var oldIndex = this
													.getMarkerIndex(marker);
											if (type == 'top') {
												index = topindex;
											} else if (type == 'bottom') {
												index = 0;
											} else if (type == 'back') {
												index = oldIndex - 1;
												if (index < 0)
													index = 0;
											} else if (type == 'front') {
												index = oldIndex + 1;
												if (index > topindex)
													index = topindex;
											}
											var tmpmarker = marker;
											var parentId = this.userMarkers.id;
											var curId = parentId;
											for (var i = 0; i < this.userMarkers.markers.length; i++) {
												if (this.userMarkers.markers[i] == marker
														&& i != index) {
													oldIndex = i;
													curId = this.userMarkers.markers[oldIndex].icon.imageDiv.id;
													tmpmarker = vworldFunc
															._GetElement(curId);
													this.userMarkers.markers
															.splice(i, 1);
													break;
												}
											}
											if (oldIndex != index) {
												if ((type == 'back' || type == 'bottom')) {
													this.userMarkers.markers
															.splice(index, 0,
																	marker);
													var list = vworldFunc
															._GetElement(parentId);
													var items = list.childNodes;
													list
															.removeChild(items[oldIndex]);
													items = vworldFunc
															._GetElement(parentId).childNodes;
													list.insertBefore(
															tmpmarker,
															items[index]);
												} else {
													this.userMarkers.markers
															.splice(index, 0,
																	marker);
													var list = vworldFunc
															._GetElement(parentId);
													var items = list.childNodes;
													list
															.removeChild(items[oldIndex]);
													items = vworldFunc
															._GetElement(parentId).childNodes;
													list
															.insertBefore(
																	tmpmarker,
																	items[index - 1].nextSibling);
												}
											}
											this.userMarkers.redraw();
											return;
										},
										addGraphic : function(g) {
											this.userGraphic.addFeatures([ g ]);
										},
										clearGraphics : function() {
											this.userGraphic
													.removeFeatures(this.userGraphic.features);
										},
										getGraphicById : function(id) {
											return this.userGraphic
													.getFeatureById(id);
										},
										deleteGraphicById : function(id) {
											if ((this.getGraphicById(id) != null)
													&& (this.getGraphicById(id) != 'undefined'))
												this.userGraphic
														.removeFeatures([ this
																.getGraphicById(id) ]);
										},
										redrawGraphics : function() {
											this.userGraphic.redraw();
										},
										setShowZoomConfig : function(func) {
											this.onShowZoomConfig = func;
										},
										getTransformXY : function(x, y, inProj,
												outProj) {
											try {
												var ll = new OpenLayers.LonLat(
														parseFloat(x),
														parseFloat(y))
														.transform(
																new OpenLayers.Projection(
																		inProj),
																new OpenLayers.Projection(
																		outProj));
												return {
													x : ll.lon,
													y : ll.lat
												};
											} catch (e) {
												return null;
											}
										},
										getTransformBounds : function(bounds) {
											return bounds.transform(
													new OpenLayers.Projection(
															displayProj),
													new OpenLayers.Projection(
															originalProj));
										},
										clearButtonEvent : function() {
											var map = this;
											for ( var x in map.controls) {
												conid = map.controls[x].id;
												if (conid == null)
													break;
												if (conid
														.indexOf("OpenLayers.Control.Button") > -1
														|| conid
																.indexOf("OpenLayers_Control_Button") > -1) {
													map.controls[x]
															.deactivate();
												}
											}
										},
										clearMeasureEvent : function() {
											var map = this;
											for ( var x in map.controls) {
												conid = map.controls[x].id;
												if (conid == null)
													break;
												if ((conid
														.indexOf(".Control.Measure") > -1)
														|| (conid
																.indexOf(".Control.ZoomBox") > -1)
														|| (conid
																.indexOf("vworld.InfoPoint") > -1)
														|| (conid
																.indexOf("_Control_Measure") > -1)
														|| (conid
																.indexOf("_Control_ZoomBox") > -1)
														|| (conid
																.indexOf("vworld_InfoPoint") > -1)) {
													map.controls[x]
															.deactivate();
												}
											}
											this.div.style.cursor = "url("
													+ vworldUrl
													+ "/images/maps/hand.cur), default";
										},
										isMeasuring : function() {
											var map = this;
											for ( var x in map.controls) {
												conid = map.controls[x].id;
												if (conid == null)
													break;
												if ((conid
														.indexOf(".Control.Measure") > -1)
														|| (conid
																.indexOf(".Control.ZoomBox") > -1)
														|| (conid
																.indexOf("vworld.InfoPoint") > -1)
														|| (conid
																.indexOf("_Control_Measure") > -1)
														|| (conid
																.indexOf("_Control_ZoomBox") > -1)
														|| (conid
																.indexOf("vworld_InfoPoint") > -1)) {
													if (map.controls[x].active) {
														return true;
													}
												}
											}
											return false;
										},
										addMapToolButton : function(type) {
											var map = this;
											if (type == 'init') {
												this
														.addPanelButton(
																function() {
																	map
																			.initAll();
																},
																this.mapToolDirection == 'horizontal' ? 'olInitH'
																		: 'olInit',
																'초기화');
											} else if (type == 'zoomin') {
												this
														.addPanelButton(
																function() {
																	map
																			.zoomIn();
																},
																this.mapToolDirection == 'horizontal' ? 'olZoominH'
																		: 'olZoomin',
																'확대');
											} else if (type == 'zoomout') {
												this
														.addPanelButton(
																function() {
																	map
																			.zoomOut();
																},
																this.mapToolDirection == 'horizontal' ? 'olZoomoutH'
																		: 'olZoomout',
																'축소');
											} else if (type == 'zoominbox') {
												this
														.addPanelButton(
																function() {
																	map
																			.zoomBoxIn();
																},
																this.mapToolDirection == 'horizontal' ? 'olZoominH'
																		: 'olZoomin',
																'영역확대');
											} else if (type == 'zoomoutbox') {
												this
														.addPanelButton(
																function() {
																	map
																			.zoomBoxOut();
																},
																this.mapToolDirection == 'horizontal' ? 'olZoomoutH'
																		: 'olZoomout',
																'축소');
											} else if (type == 'pan') {
												this
														.addPanelButton(
																function() {
																	thisMap
																			.init();
																	map
																			.getControlsByClass("OpenLayers.Control.Navigation")[0]
																			.activate();
																},
																this.mapToolDirection == 'horizontal' ? 'olPanH'
																		: 'olPan',
																'이동');
											} else if (type == 'prev') {
												this
														.addPanelButton(
																function() {
																	map.navi.previous
																			.trigger();
																},
																this.mapToolDirection == 'horizontal' ? 'olPrevH'
																		: 'olPrev',
																'이전화면');
											} else if (type == 'next') {
												this
														.addPanelButton(
																function() {
																	map.navi.next
																			.trigger();
																},
																this.mapToolDirection == 'horizontal' ? 'olNextH'
																		: 'olNext',
																'다음화면');
											} else if (type == 'fullext') {
												this
														.addPanelButton(
																function() {
																	map
																			.clearButtonEvent();
																	map
																			.fullExtent();
																},
																this.mapToolDirection == 'horizontal' ? 'olFullExtH'
																		: 'olFullExt',
																'전체보기');
											} else if (type == 'geolocate') {
												this
														.addPanelButton(
																function() {
																	map
																			.getCurrentLocation();
																},
																this.mapToolDirection == 'horizontal' ? 'olGeolocateH'
																		: 'olGeolocate',
																'현재위치찾기');
											} else if (type == 'caldist') {
												this
														.addPanelButton(
																function() {
																	map
																			.calcDistance();
																},
																this.mapToolDirection == 'horizontal' ? 'calDistH'
																		: 'calDist',
																'거리측정');
											} else if (type == 'calarea') {
												this
														.addPanelButton(
																function() {
																	map
																			.calcArea();
																},
																this.mapToolDirection == 'horizontal' ? 'calAreaH'
																		: 'calArea',
																'면적측정');
											} else if (type == 'info') {
												this
														.addPanelButton(
																function() {
																	map
																			.infoOn();
																},
																this.mapToolDirection == 'horizontal' ? 'olinfoOnH'
																		: 'olinfoOn',
																'정보조회');
											}
											this
													.setMapToolPosition(this.mapToolPosition);
											this.mapToolbar.redraw();
										},
										addPanelButton : function(func,
												classname, tooltip) {
											var mtb = this.mapToolbar;
											var btnControl = new OpenLayers.Control.Button(
													{
														trigger : func,
														displayClass : classname
													});
											btnControl.title = tooltip;
											var tmpControls = [];
											var k = mtb.controls.length;
											for ( var x in mtb.controls) {
												var mid = mtb.controls[x].id;
												if (mid == null)
													break;
												tmpControls
														.push(mtb.controls[x]);
											}
											for ( var x in this.controls) {
												conid = this.controls[x].id;
												if (conid == null)
													break;
												if (conid
														.indexOf("OpenLayers.Control.Button") > -1) {
													this
															.removeControl(this.controls[x]);
												}
											}
											tmpControls.push(btnControl);
											this.mapToolbar.controls = [];
											this.mapToolbar
													.addControls(tmpControls);
											k = 0;
											if (this.mapToolDirection == 'vertical') {
												for ( var x in mtb.controls) {
													var mid = mtb.controls[x].id;
													if (mid == null)
														break;
													mtb.controls[x].div.style.top = eval(k
															* buttonWidth)
															+ 'px';
													mtb.controls[x].div.style.left = '0px';
													mtb.controls[x].activate();
													k++;
												}
												mtb.div.style.width = buttonWidth
														+ 'px';
												mtb.div.style.height = eval(k
														* buttonWidth)
														+ 'px';
											} else {
												for ( var x in mtb.controls) {
													var mid = mtb.controls[x].id;
													if (mid == null)
														break;
													mtb.controls[x].div.style.top = '0px';
													mtb.controls[x].div.style.left = k
															* buttonWidth
															+ 'px';
													mtb.controls[x].activate();
													k++;
												}
												mtb.div.style.width = eval(k
														* buttonWidth)
														+ 'px';
												mtb.div.style.height = buttonWidth
														+ 'px';
											}
											return btnControl;
										},
										removePanelButton : function(btn) {
											OpenLayers.Util.removeItem(
													this.mapToolbar.controls,
													btn);
											this.mapToolbar.redraw();
										},
										setIndexMapPosition : function(pos) {
											var bar = this
													.getControlsByClass("vworld.OverviewMap")[0];
											if (bar == null)
												return;
											if (pos == "right-top") {
												bar.div.style.top = '0px';
												bar.div.style.left = '';
												bar.maximizeDiv.style.top = bar.minimizeDiv.style.top = '0px';
											} else if (pos == "right-bottom") {
												bar.div.style.bottom = '0px';
												bar.maximizeDiv.style.bottom = bar.minimizeDiv.style.bottom = bar.div.style.top;
												bar.div.style.top = '';
												bar.div.style.left = '';
												bar.maximizeDiv.style.top = '';
												bar.minimizeDiv.style.top = '';
												bar.div.style.bottom = '0px';
												bar.maximizeDiv.style.bottom = '0px';
												bar.minimizeDiv.style.bottom = '0px';
											} else if (pos == "left-top") {
												bar.div.style.left = bar.div.style.top = '0px';
												bar.div.style.width = Math
														.round(eval(bar.size.w * 1.02))
														+ 'px';
												bar.maximizeDiv.style.left = bar.minimizeDiv.style.left = '0px';
												bar.maximizeDiv.style.top = bar.minimizeDiv.style.top = '0px';
											} else if (pos == "left-bottom") {
												bar.div.style.left = '0px';
												bar.div.style.width = Math
														.round(eval(bar.size.w * 1.02))
														+ 'px';
												bar.maximizeDiv.style.left = bar.minimizeDiv.style.left = '0px';
												bar.maximizeDiv.style.bottom = bar.minimizeDiv.style.bottom = bar.div.style.top;
												bar.div.style.top = '';
												bar.maximizeDiv.style.top = '';
												bar.minimizeDiv.style.top = '';
												bar.div.style.bottom = '0px';
												bar.maximizeDiv.style.bottom = '0px';
												bar.minimizeDiv.style.bottom = '0px';
											}
											bar = null;
										},
										setControlsType : function(params) {
											if (params
													.hasOwnProperty('zoomBarPosition')) {
												this.zoomBarPosition = params.zoomBarPosition;
												this
														.getControlsByClass("vworld.PanZoomBar")[0].curPosition = params.zoomBarPosition;
											}
											if (params
													.hasOwnProperty('simpleMap')) {
												this
														.getControlsByClass("vworld.WaterMark")[0].isSimple = this
														.getControlsByClass("vworld.PanZoomBar")[0].isSimpleBar = params.simpleMap;
											}
											if ((params
													.hasOwnProperty('simpleMap'))
													|| (params
															.hasOwnProperty('zoomBarPosition'))) {
												this
														.getControlsByClass("vworld.PanZoomBar")[0]
														.redraw();
											}
											if (params
													.hasOwnProperty('mapToolDirection')) {
												this.mapToolDirection = params.mapToolDirection;
												this.mapToolbar.redraw();
											}
											if (params
													.hasOwnProperty('mapToolPosition')) {
												this.mapToolPosition = params.mapToolPosition;
											}
											this.refreshControls();
											return true;
										},
										refreshControls : function() {
											this
													.setMapToolPosition(this.mapToolPosition);
											this
													.getControlsByClass("vworld.WaterMark")[0]
													.redraw();
										},
										setMapToolDirection : function(type) {
											if ((type == 'vertical')
													|| (type == 'horizontal')) {
												this.mapToolDirection = type;
											} else {
												this.mapToolDirection = 'vertical';
											}
											this.mapToolbar.redraw();
										},
										setMapToolPosition : function(pos) {
											var leftmargin = 0;
											var rightmargin = 0;
											var bottommargin = 20;
											leftmargin = 80;
											if ((this.zoomBarPosition == 'right')
													|| (vworld.showMode)) {
												if (!vworld.showMode) {
													leftmargin = 0;
												}
												rightmargin = 90;
											}
											var tooldiv = this
													.getControlsByClass("OpenLayers.Control.Panel")[0];
											if (tooldiv == null)
												return false;
											tooldiv.div.style.top = null;
											tooldiv.div.style.right = null;
											tooldiv.div.style.left = null;
											tooldiv.div.style.bottom = null;
											this.mapToolPosition = pos;
											if (pos == "right-top") {
												tooldiv.div.style.top = '4px';
												tooldiv.div.style.right = rightmargin
														+ 10 + 'px';
											} else if (pos == "right-bottom") {
												tooldiv.div.style.right = 10 + 'px';
												tooldiv.div.style.bottom = 4 + 'px';
											} else if (pos == "left-top") {
												tooldiv.div.style.top = '4px';
												tooldiv.div.style.left = leftmargin
														+ 10 + 'px';
											} else if (pos == "left-bottom") {
												tooldiv.div.style.left = 10 + 'px';
												tooldiv.div.style.bottom = 4 + 'px';
											}
										},
										setZoomBarPosition : function(pos) {
											this.zoomBarPosition = pos;
											if (pos == 'left') {
												this
														.getControlsByClass("vworld.PanZoomBar")[0].div.style.left = '10px';
											} else {
												this.zoomBarPosition = 'right';
												this
														.getControlsByClass("vworld.PanZoomBar")[0].div.style.right = '10px';
												this
														.getControlsByClass("vworld.PanZoomBar")[0].div.style.left = '';
											}
										},
										GetLayerStyles : function(layers,
												callback, styles) {
											var theStyles = (styles != null) ? styles
													: layers;
											var params = "layers=" + layers;
											params += "&styles=" + theStyles;
											params += "&SERVICE=WMS";
											params += "&REQUEST=GetStyles";
											params += "&VERSION=1.3.0";
											params += "&outputformat=text/xml";
											params += "&EXCEPTIONS=text/xml";
											params += "&apiKey=" + vworldApiKey;
											var reqConfig = OpenLayers.Util
													.extend(
															{
																url : vworldUrls.wms
																		+ params,
																headers : {
																	"Content-Type" : "text/plain"
																},
																success : callback,
																scope : this
															}, {
																method : "GET"
															});
											try {
												OpenLayers.Request
														.issue(reqConfig);
											} catch (e) {
											}
										},
										showTimeSeriesLayer : function(title,
												time) {
											if (time == null
													|| typeof time == 'undefined')
												return null;
											var idx = vworldTimes.times
													.indexOf(time);
											if (idx < 0)
												return null;
											var type = vworldTimes.types[idx];
											var cacheLayer = null;
											var state = true;
											cacheLayer = thisMap
													.getLayerByName(title);
											if (cacheLayer != null) {
												cacheLayer.changeTime(time);
											} else {
												var options = {
													serviceVersion : "",
													layername : time,
													isBaseLayer : false,
													opacity : 1,
													type : type,
													transitionEffect : 'null',
													tileSize : new OpenLayers.Size(
															256, 256),
													min_level : 9,
													max_level : 18,
													buffer : 0
												};
												cacheLayer = new vworld.TimeCache(
														title,
														vworldUrls.times,
														options);
												if (cacheLayer != null) {
													thisMap
															.addLayer(cacheLayer);
												}
											}
											return cacheLayer;
										},
										showTileCacheLayer : function(title,
												layerId, servicelevels, etc) {
											var cacheLayer = null;
											var state = true;
											var cat = vworldCategory.cache;
											cacheLayer = thisMap
													.getLayerByName(cat + title);
											if (cacheLayer != null) {
												state = !cacheLayer
														.getVisibility();
												cacheLayer.setVisibility(state);
												cacheLayer.redraw();
											} else {
												var options = {
													serviceVersion : "",
													layername : layerId,
													isBaseLayer : false,
													opacity : (etc != null && etc.opacity != null) ? etc.opacity
															: 1,
													type : 'png',
													transitionEffect : 'null',
													tileSize : new OpenLayers.Size(
															256, 256),
													min_level : (servicelevels.min != null) ? servicelevels.min
															: 9,
													max_level : (servicelevels.max != null) ? servicelevels.max
															: 18,
													buffer : 0
												};
												cacheLayer = new vworld.TileCache(
														cat + title,
														vworldUrls.tile2d,
														options);
												if (cacheLayer != null) {
													thisMap
															.addLayer(cacheLayer);
												}
											}
											return cacheLayer;
										},
										hideTileCacheLayer : function(title) {
											var theLayer = null;
											var cat = vworldCategory.cache;
											theLayer = thisMap
													.getLayerByName(cat + title);
											if (theLayer != null) {
												theLayer.setVisibility(false);
												theLayer.redraw();
											}
											return true;
										},
										ImportWMSLayer : function(title, params) {
											if (typeof params !== 'object')
												return null;
											var url = (params.url != null) ? params.url
													: null;
											var layerIds = (params.layers != null) ? params.layers
													: null;
											var styles = (params.styles != null) ? params.styles
													: layerIds;
											var format = (params.format != null) ? params.format
													: 'image/png';
											var crs = (params.crs != null) ? params.crs
													: originalProj;
											var srs = (params.srs != null) ? params.srs
													: originalProj;
											var version = (params.version != null) ? params.version
													: "1.3.0";
											var transparent = (params.transparent != null) ? params.transparent
													: true;
											var tilesize = (typeof params.tilesize == 'object') ? params.tilesize
													: new OpenLayers.Size(512,
															512);
											if (url == null)
												return null;
											var cat = vworldCategory.wms;
											var impLayer = new OpenLayers.Layer.WMS(
													cat + title,
													url,
													{
														'layers' : layerIds,
														'styles' : styles,
														'format' : format,
														'crs' : crs,
														'srs' : srs,
														'projection' : 'none',
														'exceptions' : "text/xml",
														'version' : version,
														'transparent' : transparent
													}, {
														'isBaseLayer' : false,
														'singleTile' : false,
														'tileSize' : tilesize,
														'visibility' : true
													});
											thisMap.addLayer(impLayer);
											return impLayer;
										},
										clearDisplayLayer : function(clear) {
											if (!clear) {
												theLayer = thisMap
														.getLayerByName(vworldCategory.theme
																+ "지적도");
												if (theLayer != null)
													thisMap
															.raiseLayer(
																	theLayer,
																	thisMap.layers.length);
												thisMap.raiseLayer(
														thisMap.vectorLayer,
														thisMap.layers.length);
												thisMap.raiseLayer(
														thisMap.userGraphic,
														thisMap.layers.length);
												var markerLayers = thisMap
														.getLayersByClass('OpenLayers.Layer.Markers');
												for (var i = 0; i < markerLayers.length; i++) {
													thisMap
															.raiseLayer(
																	markerLayers[i],
																	thisMap.layers.length)
												}
											} else {
												vworldInfo.objects2d = [];
												thisMap.vectorLayer
														.removeAllFeatures();
												thisMap.userGraphic
														.removeAllFeatures();
												thisMap.clearMarkers();
											}
										},
										setThemeBackground : function() {
											var backLayer = null;
											var visibleCount = 0;
											var cat = vworldCategory.theme;
											var z = thisMap.getZoom();
											var layer = thisMap
													.getLayerByName(cat + "지적도");
											if (layer != null) {
												if (z < 17) {
													if (vworld.viewMode == 1) {
														layer.attribution = vworld.enums.JIJUK_INVISIBLE_NOTICE_R;
													} else {
														layer.attribution = vworld.enums.JIJUK_INVISIBLE_NOTICE;
													}
													if (layer.getVisibility() == false) {
														if (vworld.viewMode == 1) {
															if (thisMap.vworldRaster != null)
																thisMap.vworldRaster.attribution = vworld.enums.COMMON_NOTICE_R;
														} else {
															thisMap.vworldBaseMap.attribution = vworld.enums.COMMON_NOTICE;
														}
													} else {
														if (vworld.viewMode == 1) {
															if (thisMap.vworldRaster != null)
																thisMap.vworldRaster.attribution = "";
														} else {
															thisMap.vworldBaseMap.attribution = "";
														}
													}
													;
												} else {
													layer.attribution = vworld.enums.JIJUK_VISIBLE_NOTICE;
													thisMap.vworldBaseMap.attribution = vworld.enums.COMMON_NOTICE;
													if (thisMap.vworldRaster != null)
														thisMap.vworldRaster.attribution = vworld.enums.COMMON_NOTICE_R;
												}
											}
											this.clearDisplayLayer(false);
											return true;
										},
										hideAllThemeLayer : function() {
											var cat = vworldCategory.theme;
											for (var i = 0, len = thisMap.layers.length; i < len; i++) {
												var layer = thisMap.layers[i];
												if (layer.name
														.indexOf(vworldCategory.theme) > -1
														|| layer.name
																.indexOf(vworldCategory.cache) > -1) {
													layer.setVisibility(false);
													layer.redraw();
												}
											}
											thisMap._setInfoLayerState();
											vworldUtil._initInfos();
											return true;
										},
										hideThemeLayer : function(title) {
											var theLayer = null;
											var cat = vworldCategory.theme;
											theLayer = thisMap
													.getLayerByName(cat + title);
											if (theLayer != null) {
												theLayer.setVisibility(false);
												theLayer.redraw();
												thisMap._setInfoLayerState(
														title, false);
											}
											return true;
										},
										showThemeLayer : function(title,
												params, etc1, etc2, etc3) {
											var layerIds = null;
											var styles = null;
											var imgType = null;
											var wfsName = null;
											var setvisible = false;
											if (typeof params !== 'object')
												return null;
											if (typeof params == 'object') {
												layerIds = (params.layers != null) ? params.layers
														: null;
												styles = (params.styles != null) ? params.styles
														: layerIds;
												imgType = (params.imgType != null) ? params.imgType
														: 'image/png';
												wfsName = (params.typename != null) ? params.typename
														: layerIds;
												setvisible = (params.setvisible != null) ? params.setvisible
														: false;
											} else {
												if (typeof params == 'string')
													layerIds = params;
												if (typeof etc1 == 'string')
													styles = etc1;
												if (typeof etc2 == 'string')
													imgType = etc2;
												if (typeof etc3 == 'string')
													wfsName = etc3;
											}
											if (layerIds == null) {
												alert(title
														+ " 지도의 공간정보 조회정보가 잘못되었습니다.");
												return;
											}
											var theLayer = null;
											var state = true;
											var cat = vworldCategory.theme;
											theLayer = thisMap
													.getLayerByName(cat + title);
											var attr = "";
											if (title == "지적도") {
												attr = vworld.enums.JIJUK_VISIBLE_NOTICE;
											}
											if (theLayer != null) {
												state = !theLayer
														.getVisibility();
												if (setvisible)
													state = true;
												theLayer.setVisibility(state);
												theLayer.redraw();
											} else {
												theLayer = new OpenLayers.Layer.TMS(
														cat + title,
														vworldUrls.wms2,
														{
															isBaseLayer : false,
															type : 'png',
															buffer : 0,
															transitionEffect : 'null',
															attribution : attr,
															tileSize : new OpenLayers.Size(
																	512, 512),
															getURL : function(
																	bounds) {
																var z = this.map
																		.getZoom();
																if (z >= 6
																		&& z <= this.map.maxlevel) {
																	var newParams = {};
																	newParams.LAYERS = layerIds;
																	newParams.STYLES = styles;
																	newParams.CRS = originalProj;
																	newParams.BBOX = bounds.left
																			+ ","
																			+ bounds.bottom
																			+ ","
																			+ bounds.right
																			+ ","
																			+ bounds.top;
																	newParams.SIZE = 512;
																	newParams.APIKEY = vworldApiKey;
																	var requestString = this
																			.getFullRequestString(newParams);
																	return requestString;
																} else
																	return;
															},
															getFullRequestString : function(
																	newParams,
																	altUrl) {
																this.options = newParams;
																this.options.TITLE = title;
																return OpenLayers.Layer.Grid.prototype.getFullRequestString
																		.apply(
																				this,
																				arguments);
															}
														});
												if (title == "지적도") {
													theLayer.events
															.register(
																	'visibilitychanged',
																	this,
																	this.setThemeBackground);
												}
												thisMap.addLayer(theLayer);
												theLayer.setVisibility(true);
											}
											thisMap._setInfoLayerState(title,
													state, wfsName);
											this.setThemeBackground();
											return theLayer;
										},
										hideAll3DThemeLayer : function() {
											if (vearth != null) {
												var sopLayerList = vearth
														.getLayerList();
												var layCnt = sopLayerList
														.count();
												for (var k = 0; k < layCnt; k++) {
													var layers = sopLayerList
															.indexAtLayer(k);
													if (layers.getName() == "facility_dokdo") {
														layers
																.setVisible(sop.cons.enums.SOPVISIBLE_ON);
													} else {
														layers
																.setVisible(sop.cons.enums.SOPVISIBLE_OFF);
													}
												}
												vworldInfo.Layers3d = [];
											}
										},
										hide3DThemeLayer : function(title) {
											if (vearth != null) {
												var sopLayerList = vearth
														.getLayerList();
												var layer = sopLayerList
														.nameAtLayer(title);
												if (layer != null) {
													layer
															.setVisible(sop.cons.enums.SOPVISIBLE_OFF);
												}
												thisMap._set3dInfoLayerState(
														title, false);
											}
										},
										show3DThemeLayer : function(title,
												params) {
											if (typeof params !== 'object')
												return null;
											var layerIds = (params.layers != null) ? params.layers
													: null;
											var styles = (params.styles != null) ? params.styles
													: layerIds;
											var imgType = (params.imgType != null) ? params.imgType
													: 'image/png';
											var wfsName = (params.typename != null) ? params.typename
													: layerIds;
											var minlevel = (params.minlevel != null) ? params.minlevel
													: 15;
											var maxlevel = (params.maxlevel != null) ? params.maxlevel
													: 17;
											var setvisible = (params.setvisible != null) ? params.setvisible
													: false;
											var isSld = (params.isSld != null) ? params.isSld
													: false;
											var sld = (params.sld != null) ? params.sld
													: null;
											var is3D = vworld.is3D();
											var layers = null;
											var state = visibility = sop.cons.enums.SOPVISIBLE_ON;
											var bNew = true;
											if (vearth != null) {
												var get3DLayer = function(
														alias, names) {
													var sopLayerList = vearth
															.getLayerList();
													var layer = sopLayerList
															.nameAtLayer(alias)
															|| sopLayerList
																	.nameAtLayer(names);
													return layer;
												};
												layers = get3DLayer(title,
														layerIds);
												if (layers != null) {
													bNew = false;
													visibility = layers
															.getVisible();
													if (visibility == sop.cons.enums.SOPVISIBLE_ON
															&& setvisible == false) {
														state = sop.cons.enums.SOPVISIBLE_OFF;
													} else {
														state = sop.cons.enums.SOPVISIBLE_ON;
													}
												}
												var con = vworldFunc
														._parseURL(vworldUrls.wms);
												if (!bNew) {
													layers.setVisible(state);
												} else {
													layers = vearth
															.getLayerList()
															.createWMSLayer(
																	title);
													if (layers == null) {
														layers = get3DLayer(
																title, layerIds);
														if (layers != null) {
															layers
																	.setVisible(state);
														}
													} else {
													}
												}
												layers.setConnectionWMS(
														con.host, con.port,
														con.path + "?");
												layers.setLayersWMS(layerIds);
												layers.setStylesWMS(styles);
												layers.setTileSizeWMS(256);
												layers.setLevelWMS(minlevel,
														maxlevel);
												if (isSld) {
													layers.setTileSizeWMS(1024);
													layers
															.setWMSRequestParam("&USERMAP=true&SLD="
																	+ vworldUrl
																	+ "/getXmlFile.do?fleNam="
																	+ sld);
												} else {
													layers
															.setWMSRequestParam("&USERMAP=false&SLD=null");
													layers.setTileSizeWMS(256);
												}
												if (state == sop.cons.enums.SOPVISIBLE_ON) {
													thisMap
															._set3dInfoLayerState(
																	title,
																	true,
																	wfsName);
												} else {
													thisMap
															._set3dInfoLayerState(
																	title,
																	false,
																	wfsName);
												}
											}
											return layers;
										},
										show3DWFSLayer : function(title, params) {
											if (typeof params !== 'object')
												return null;
											try {
												var layerIds = (params.typename != null) ? params.typename
														: null;
												var searchfield = (params.propertyname != null) ? params.propertyname
														: null;
												var labelfield = (params.label != null) ? params.label
														: null;
												var minlevel = (params.minlevel != null) ? params.minlevel
														: 15;
												var maxlevel = (params.maxlevel != null) ? params.maxlevel
														: 17;
												var fillcolor = (params.fillcolor != null) ? params.fillcolor
														: {
															A : 255,
															R : 255,
															G : 255,
															B : 255
														};
												var strokecolor = (params.strokecolor != null) ? params.strokecolor
														: {
															A : 255,
															R : 108,
															G : 54,
															B : 0
														};
												var fontsize = (params.fontsize != null) ? params.fontsize
														: 11;
												var font = (params.font != null) ? params.font
														: '굴림';
												var maxcount = (params.maxcount != null) ? params.maxcount
														: 500;
												var viewlimit = (params.viewlimit != null) ? params.viewlimit
														: 35;
												var thumpath = (params.thumpath != null) ? params.thumpath
														: null;
												var wfsname = (params.wfsname != null) ? params.wfsname
														: null;
												if (layerIds == null
														|| searchfield == null
														|| labelfield == null) {
													alert(title
															+ " 지도의 공간정보 조회정보가 잘못되었습니다.");
													return;
												}
												var layers = null;
												var state = visibility = sop.cons.enums.SOPVISIBLE_ON;
												var bNew = true;
												if (vearth != null) {
													var get3DLayer = function(
															alias, names) {
														var sopLayerList = vearth
																.getLayerList();
														var layer = sopLayerList
																.nameAtLayer(alias)
																|| sopLayerList
																		.nameAtLayer(names);
														return layer;
													};
													layers = get3DLayer(title,
															layerIds);
													if (layers != null) {
														bNew = false;
														visibility = layers
																.getVisible();
													}
													if (visibility == sop.cons.enums.SOPVISIBLE_ON) {
														state = sop.cons.enums.SOPVISIBLE_OFF;
													} else {
														state = sop.cons.enums.SOPVISIBLE_ON;
													}
													var con = vworldFunc
															._parseURL(vworldUrls.wfs);
													if (!bNew) {
														layers
																.setVisible(state);
													} else {
														layers = vearth
																.getLayerList()
																.createWFSLayer(
																		title,
																		0);
														if (thumpath != null) {
															var icon = thumpath;
															var SOPSymbol = layers
																	.getWFSSymbol();
															var SOPIcon = SOPSymbol
																	.getIcon();
															SOPIcon
																	.setNormalIcon(icon);
															SOPSymbol
																	.setIcon(SOPIcon);
															layers
																	.setWFSSymbol(SOPSymbol);
														}
														if (layers == null) {
															layers = get3DLayer(
																	title,
																	layerIds);
															if (layers != null) {
																layers
																		.setVisible(state);
															}
														} else {
															layers
																	.setConnectionWFS(
																			con.host,
																			con.port,
																			con.path
																					+ "?");
															layers
																	.setLayersWFS(layerIds);
															layers
																	.setRequestFeatureCount(maxcount);
															if (labelfield != null) {
																pFColor = XDcom
																		.createColor();
																pFColor
																		.setARGB(
																				fillcolor.A,
																				fillcolor.R,
																				fillcolor.G,
																				fillcolor.B);
																pOColor = XDcom
																		.createColor();
																pOColor
																		.setARGB(
																				strokecolor.A,
																				strokecolor.R,
																				strokecolor.G,
																				strokecolor.B);
																layers
																		.setFontStyle(
																				font,
																				fontsize,
																				200,
																				pFColor,
																				pOColor);
																layers
																		.setWFSPointName(labelfield);
															}
															layers
																	.setLevelWFS(minlevel);
															layers
																	.setViewLimit(viewlimit);
															layers
																	.setWFSPropertyName(searchfield);
															layers
																	.setSelectable(sop.cons.enums.SOPSELECTABLE_OFF);
															state = layers
																	.getVisible();
														}
													}
													if (wfsname != null
															&& wfsname.length > 5) {
														if (state == sop.cons.enums.SOPVISIBLE_ON) {
															thisMap
																	._set3dInfoLayerState(
																			title,
																			true,
																			wfsname);
														} else {
															thisMap
																	._set3dInfoLayerState(
																			title,
																			false,
																			wfsname);
														}
													}
												}
												return layers;
											} catch (e) {
												alert('설치된 3D 플러그인은 공간정보 조회서비스를 지원하지 않습니다.\n'
														+ e.message);
											}
										},
										previewResponse : function(response) {
											var url = "";
											if ((response != null)
													&& (response.responseText != "")) {
												url = response.responseText;
											}
											if (url == "")
												return;
											var size = thisMap.getPrintSize();
											var print = thisMap.getPrintPage();
											var popupPage = "/preview2D.do?width="
													+ size.width
													+ "&height="
													+ size.height
													+ "&page="
													+ print.page
													+ "&direct="
													+ print.direct
													+ "&url="
													+ vworldUrls.print
													+ "?file=" + url;
											var popupCondition = 'width=640px,height=760px,scrollbars=yes,resizable=yes';
											var winPopup = window.open(
													popupPage, "preview",
													popupCondition);
										},
										getPreviewMap : function(callback) {
											var size = thisMap.getPrintSize();
											var successCall = thisMap.previewResponse;
											if (typeof callback == 'function') {
												successCall = callback;
											}
											var params = "mapSizeW="
													+ size.width;
											params += "&mapSizeH="
													+ size.height;
											params += "&disposition=file";
											var reqConfig = OpenLayers.Util
													.extend(
															{
																url : vworldUrls.print
																		+ "?"
																		+ params,
																data : thisMap
																		.getPrintData(),
																headers : {
																	"Content-Type" : "text/plain"
																},
																success : successCall,
																scope : this
															}, {
																method : "POST"
															});
											try {
												OpenLayers.Request
														.issue(reqConfig);
											} catch (e) {
											}
											return true;
										},
										getPrintMap : function() {
											var params = thisMap
													.getPrintParams();
											params.disposition = "attachment";
											var _body = document
													.getElementsByTagName('body')[0];
											var _frag = document
													.createDocumentFragment();
											var imgDiv = document
													.createElement('div');
											_frag.appendChild(imgDiv);
											_body.insertBefore(_frag,
													_body.firstChild);
											var form = vworldFunc
													._CreateElement('form');
											form.method = 'POST';
											form.action = vworldUrls.print;
											for ( var par in params) {
												var field = vworldFunc
														._CreateElement('input');
												field.type = 'hidden';
												field.name = par;
												field.value = params[par];
												form.appendChild(field);
											}
											imgDiv.appendChild(form);
											form.submit();
											imgDiv.removeChild(form);
											return true;
										},
										setPrintPage : function(params) {
											vworldVar.printpage = (params.page != null) ? params.page
													: "a4";
											vworldVar.printdirect = (params.direct != null) ? params.direct
													: "portrait";
										},
										getPrintPage : function() {
											return {
												page : vworldVar.printpage,
												direct : vworldVar.printdirect
											};
										},
										getPrintSize : function() {
											if (vworld.viewMode == 2) {
												var width = parseInt(vworldFunc
														._GetElement(vworldIDs.id3d).offsetWidth);
												var height = parseInt(vworldFunc
														._GetElement(vworldIDs.id3d).offsetHeight);
											} else {
												var width = parseInt(vworldFunc
														._GetElement(vworldIDs.id2d).offsetWidth);
												var height = parseInt(vworldFunc
														._GetElement(vworldIDs.id2d).offsetHeight);
											}
											return {
												width : width,
												height : height
											};
										},
										getPrintParams : function() {
											var size = thisMap.getPrintSize();
											return {
												"mapSizeW" : size.width,
												"mapSizeH" : size.height,
												"params" : thisMap
														.getPrintData()
											};
										},
										getPrintData : function() {
											thisMap.setCenter(thisMap
													.getCenter(), thisMap
													.getZoom(), false, true);
											var allLayerObj = new Array();
											var urlPosObj = new Array();
											var layerObj = new Array();
											var GEOMETRY_TYPE = {
												"OpenLayers.Geometry.Point" : "Point",
												"OpenLayers.Geometry.Polygon" : "Polygon",
												"OpenLayers.Geometry.LineString" : "LineString"
											};
											var getVertices = function(
													component) {
												var xyArray = [];
												var vertices = component
														.getVertices();
												for (var v = 0; v < vertices.length; v++) {
													var lonlat = new OpenLayers.LonLat(
															vertices[v].x,
															vertices[v].y);
													var px = thisMap
															.getLayerPxFromLonLat(lonlat);
													var xy = {};
													xy.x = px.x;
													xy.y = px.y;
													xyArray.push(xy);
												}
												return xyArray;
											};
											var getComponents = function(type,
													geometry) {
												var components = [];
												switch (type) {
												case "Point":
												case "LineString":
													var vertices = getVertices(geometry);
													if (vertices.length > 0) {
														components
																.push(vertices);
													}
													break;
												case "Polygon":
													for (var i = 0; i < geometry.components.length; i++) {
														var vertices = getVertices(geometry.components[i]);
														if (vertices.length > 0) {
															components
																	.push(vertices);
														}
													}
													break;
												case "LinearRing":
													for (var i = 0; i < geometry.components.length; i++) {
														var vertices = getVertices(geometry.components[i]);
														if (vertices.length > 0) {
															components
																	.push(vertices);
														}
													}
													break;
												}
												return components;
											};
											var tmsInfo = function(layer,
													stretchable) {
												var tms = {};
												var grids = layer.grid;
												var tiles = [];
												for (var i = 0; i < grids.length; i++) {
													for (var j = 0; j < grids[i].length; j++) {
														var tile = {};
														tile.url = grids[i][j].url;
														if (tile.url != null) {
															tile.position = {};
															tile.position.x = grids[i][j].position.x;
															tile.position.y = grids[i][j].position.y;
															tiles.push(tile);
														}
													}
												}
												tms.tiles = tiles;
												tms.options = {};
												tms.options.opacity = 1;
												tms.options.scale = 1;
												if (stretchable
														&& layer.tileSize.w != null
														&& layer.tileSize.w > 256) {
													tms.options.scale = layer.tileSize.w / 256;
												}
												return tms;
											};
											var wmsInfo = function(layer) {
												var wms = {};
												wms.url = layer.url;
												var pbounds = thisMap
														.getExtent();
												var pLX = pbounds.left;
												var pLY = pbounds.bottom;
												var pRX = pbounds.right;
												var pRY = pbounds.top;
												var width = vworldFunc
														._GetElement(vworldIDs.id2d).style.width;
												var height = vworldFunc
														._GetElement(vworldIDs.id2d).style.height;
												len = width.length;
												width = width.substring(0,
														len - 2);
												len = height.length;
												height = height.substring(0,
														len - 2);
												var destination = {};
												destination.BBOX = pLX + ","
														+ pLY + "," + pRX + ","
														+ pRY;
												destination.WIDTH = width;
												destination.HEIGHT = height;
												destination = OpenLayers.Util
														.extend(destination,
																layer.params);
												var params = OpenLayers.Util
														.getParameterString(destination);
												wms.params = unescape(params);
												wms.position = {};
												wms.position.x = 0;
												wms.position.y = 0;
												wms.options = {};
												wms.options.opacity = layer.layer;
												wms.options.scale = 1;
												if (layer.tileSize.w != null
														&& layer.tileSize.w > 256) {
													wms.options.scale = layer.tileSize.w / 256;
												}
												return wms;
											};
											var vectorInfo = function(layer,
													useAttr) {
												var vector = {};
												vector.features = [];
												for (var i = 0; i < layer.features.length; i++) {
													var geoType = GEOMETRY_TYPE[layer.features[i].geometry.CLASS_NAME];
													var xyArrays = getComponents(
															geoType,
															layer.features[i].geometry);
													if (xyArrays.length > 0) {
														var feature = {};
														feature.geometries = xyArrays;
														feature.type = geoType;
														feature.style = {};
														if (useAttr) {
															feature.style = layer.features[i].attributes;
														} else {
															if (layer.features[i].style)
																feature.style = layer.features[i].style;
														}
														vector.features
																.push(feature);
													}
												}
												return vector;
											};
											var markerInfo = function(layer) {
												var markers = [];
												for (var i = 0; i < layer.markers.length; i++) {
													var curm = layer.markers[i];
													var px = thisMap
															.getLayerPxFromLonLat(curm.lonlat);
													var marker = {};
													marker.url = "";
													marker.position = {};
													marker.size = {};
													marker.url = curm.icon.url;
													marker.size = curm.icon.size;
													marker.position.x = px.x;
													marker.position.y = px.y;
													markers.push(marker);
												}
												return markers;
											};
											var dataFormat = function(type,
													layer, zindex) {
												return {
													type : type,
													layer : layer,
													zindex : zindex
												};
											};
											var Count = -1;
											if ((thisMap.baseLayer != null)
													&& (thisMap.baseLayer
															.getVisibility())) {
												urlPosObj = tmsInfo(
														thisMap.baseLayer, true);
												layerObj = dataFormat("TMS",
														urlPosObj, Count++);
												allLayerObj.push(layerObj);
											}
											if ((thisMap.vworldHybrid != null)
													&& (thisMap.vworldHybrid
															.getVisibility())) {
												urlPosObj = tmsInfo(
														thisMap.vworldHybrid,
														true);
												layerObj = dataFormat("TMS",
														urlPosObj, Count++);
												allLayerObj.push(layerObj);
											}
											var curLayer = null;
											for (var i = 0, len = thisMap.layers.length; i < len; i++) {
												curLayer = thisMap.layers[i];
												if (curLayer.name
														.indexOf("theme_") > -1) {
													if (curLayer
															.getVisibility()) {
														urlPosObj = tmsInfo(
																curLayer, false);
														layerObj = dataFormat(
																"TMS",
																urlPosObj,
																Count++);
														allLayerObj
																.push(layerObj);
													}
												}
											}
											urlPosObj = vectorInfo(
													this.userGraphic, true);
											layerObj = dataFormat("Vector",
													urlPosObj, Count++);
											allLayerObj.push(layerObj);
											urlPosObj = markerInfo(this.userMarkers);
											layerObj = dataFormat("Markers",
													urlPosObj, Count++);
											allLayerObj.push(layerObj);
											var json = new OpenLayers.Format.JSON();
											var allLayerJson = json
													.write(allLayerObj);
											return allLayerJson;
										},
										destroy : function() {
											if (this.displayProjection != null)
												this.displayProjection
														.destroy();
											if (this.projection != null)
												this.projection.destroy();
											if (this.vworldBaseMap != null)
												this.vworldBaseMap.destroy();
											if (this.vworldRaster != null)
												this.vworldRaster.destroy();
											if (this.vworldHybrid != null)
												this.vworldHybrid.destroy();
											if (this.vworldOrthoImg != null)
												this.vworldOrthoImg.destroy();
											for (var i = this.controls.length - 1; i > 0; i--) {
												this
														.removeControl(this.controls[i]);
											}
											OpenLayers.Map.prototype.destroy
													.apply(this);
										},
										CLASS_NAME : "vworld.Maps"
									});
					vworld.InfoPoint = OpenLayers.Class(OpenLayers.Control, {
						defaultHandlerOptions : {
							'single' : true,
							'double' : false,
							'pixelTolerance' : 0,
							'stopSingle' : false,
							'stopDouble' : false
						},
						initialize : function(options) {
							this.handlerOptions = OpenLayers.Util.extend({},
									this.defaultHandlerOptions);
							OpenLayers.Control.prototype.initialize.apply(this,
									arguments);
							this.handler = new OpenLayers.Handler.Click(this, {
								'click' : this.trigger
							}, this.handlerOptions);
						},
						trigger : function(e) {
							lonLatPosition = this.map.getLonLatFromPixel(e.xy);
							this.map._infoPointImplements(null);
						},
						CLASS_NAME : "vworld.InfoPoint"
					});
					vworld.OverviewMap = OpenLayers
							.Class(
									OpenLayers.Control.OverviewMap,
									{
										curRes : null,
										minLevel : 0,
										initialize : function(options) {
											OpenLayers.Control.OverviewMap.prototype.initialize
													.apply(this, [ options ]);
											if (this.mapOptions.minZoomLevel != null)
												this.minLevel = this.mapOptions.minZoomLevel;
										},
										draw : function() {
											OpenLayers.Control.prototype.draw
													.apply(this, arguments);
											if (this.layers.length === 0) {
												if (this.map.baseLayer) {
													var layer = this.map.baseLayer
															.clone();
													this.layers = [ layer ];
												} else {
													this.map.events.register(
															"changebaselayer",
															this,
															this.baseLayerDraw);
													return this.div;
												}
											}
											this.element = document
													.createElement('div');
											this.element.className = this.displayClass
													+ 'Element';
											this.element.style.display = 'none';
											this.mapDiv = document
													.createElement('div');
											this.mapDiv.style.width = this.size.w
													+ 'px';
											this.mapDiv.style.height = this.size.h
													+ 'px';
											this.mapDiv.style.position = 'relative';
											this.mapDiv.style.overflow = 'hidden';
											this.mapDiv.id = OpenLayers.Util
													.createUniqueID('overviewMap');
											this.extentRectangle = document
													.createElement('div');
											this.extentRectangle.style.position = 'absolute';
											this.extentRectangle.style.zIndex = 1000;
											this.extentRectangle.className = this.displayClass
													+ 'ExtentRectangle';
											this.element
													.appendChild(this.mapDiv);
											this.div.appendChild(this.element);
											if (!this.outsideViewport) {
												this.div.className += " "
														+ this.displayClass
														+ 'Container';
												var img = OpenLayers.Util
														.getImageLocation('layer-switcher-maximize.png');
												this.maximizeDiv = OpenLayers.Util
														.createAlphaImageDiv(
																this.displayClass
																		+ 'MaximizeButton',
																null, null,
																img, 'absolute');
												this.maximizeDiv.style.display = 'none';
												this.maximizeDiv.className = this.displayClass
														+ 'MaximizeButton olButton';
												this.div
														.appendChild(this.maximizeDiv);
												var img = OpenLayers.Util
														.getImageLocation('layer-switcher-minimize.png');
												this.minimizeDiv = OpenLayers.Util
														.createAlphaImageDiv(
																'OpenLayers_Control_minimizeDiv',
																null, null,
																img, 'absolute');
												this.minimizeDiv.style.display = 'none';
												this.minimizeDiv.className = this.displayClass
														+ 'MinimizeButton olButton';
												this.div
														.appendChild(this.minimizeDiv);
												this.minimizeControl();
											} else {
												this.element.style.display = '';
											}
											if (this.map.getExtent()) {
												this.update();
											}
											this.map.events
													.on({
														buttonclick : this.onButtonClick,
														moveend : this.update,
														zoomend : this.update,
														scope : this
													});
											if (this.maximized) {
												this.maximizeControl();
											}
											return this.div;
										},
										setSize : function(w, h) {
											var width = parseInt(w, 10);
											var height = parseInt(h, 10);
											width = (width < 100) ? 100 : width;
											height = (height < 90) ? 90
													: height;
											this.size.w = width;
											this.size.h = height;
											this.ovmap.size.w = this.size.w;
											this.ovmap.size.h = this.size.h;
											this.element.style.width = this.size.w
													+ "px";
											this.element.style.height = this.size.h
													+ "px";
											this.mapDiv.style.width = this.size.w
													+ "px";
											this.mapDiv.style.height = this.size.h
													+ "px";
											this.ovmap.baseLayer.redraw();
											this.update();
										},
										destroy : function() {
											if (!this.mapDiv) {
												return;
											}
											if (this.handlers.click) {
												this.handlers.click.destroy();
											}
											if (this.handlers.drag) {
												this.handlers.drag.destroy();
											}
											this.mapDiv
													.removeChild(this.extentRectangle);
											this.extentRectangle = null;
											if (this.rectEvents) {
												this.rectEvents.destroy();
												this.rectEvents = null;
											}
											if (this.ovmap) {
												this.ovmap.destroy();
												this.ovmap = null;
											}
											this.element
													.removeChild(this.mapDiv);
											this.mapDiv = null;
											this.div.removeChild(this.element);
											this.element = null;
											if (this.maximizeDiv) {
												this.div
														.removeChild(this.maximizeDiv);
												this.maximizeDiv = null;
											}
											if (this.minimizeDiv) {
												this.div
														.removeChild(this.minimizeDiv);
												this.minimizeDiv = null;
											}
											this.map.events
													.un({
														buttonclick : this.onButtonClick,
														'zoomend' : this.update,
														'moveend' : this.update,
														'changebaselayer' : this.baseLayerDraw,
														scope : this
													});
											OpenLayers.Control.prototype.destroy
													.apply(this, arguments);
										},
										updateOverview : function() {
											var mapRes = this.map
													.getResolution();
											var targetRes = this.ovmap
													.getResolution();
											var resRatio = targetRes / mapRes;
											if (mapRes != this.curRes) {
												if (resRatio > this.maxRatio) {
													targetRes = this.minRatio
															* mapRes;
												} else if (resRatio <= this.minRatio) {
													targetRes = this.maxRatio
															* mapRes;
												}
											}
											if (mapRes != this.curRes)
												this.curRes = mapRes;
											var center;
											if (this.ovmap.getProjection() != this.map
													.getProjection()) {
												center = this.map.center
														.clone();
												center
														.transform(
																this.map
																		.getProjectionObject(),
																this.ovmap
																		.getProjectionObject());
											} else {
												center = this.map.center;
											}
											var curZoom = this.map.getZoom() - 4;
											if (curZoom < this.minLevel)
												curZoom = this.minLevel;
											this.ovmap.setCenter(center,
													curZoom);
											this.updateRectToMap();
										},
										CLASS_NAME : 'vworld.OverviewMap'
									});
					vworld.PanZoomBar = OpenLayers
							.Class(
									OpenLayers.Control.PanZoom,
									{
										zoomStopWidth : 30,
										zoomStopHeight : 6,
										slider : null,
										sliderEvents : null,
										zoombarDiv : null,
										measureDiv : null,
										measurebuttons : null,
										divEvents : null,
										isSimpleBar : false,
										curPosition : 'right',
										zoomWorldIcon : true,
										forceFixedZoomLevel : false,
										mouseDragStart : null,
										deltaY : null,
										zoomStart : null,
										initialize : function() {
											OpenLayers.Control.PanZoom.prototype.initialize
													.apply(this, arguments);
										},
										destroy : function() {
											this._removeZoomBar();
											this.map.events
													.un({
														'changebaselayer' : this.redraw,
														scope : this
													});
											OpenLayers.Control.PanZoom.prototype.destroy
													.apply(this, arguments);
											delete this.mouseDragStart;
											delete this.zoomStart;
										},
										setMap : function(map) {
											OpenLayers.Control.PanZoom.prototype.setMap
													.apply(this, arguments);
											this.map.events.register(
													'changebaselayer', this,
													this.redraw);
										},
										redraw : function() {
											if (this.div != null) {
												this.removeButtons();
												this._removeZoomBar();
											}
											this.draw();
										},
										draw : function(px) {
											OpenLayers.Control.prototype.draw
													.apply(this, arguments);
											px = this.position.clone();
											var id = this.div.id
													+ "_measureDiv";
											this.measureDiv = OpenLayers.Util
													.createDiv(id, null, null,
															null, "relative");
											this.measureDiv.className = "vworldPanMeasure";
											this.buttons = [];
											this.measurebuttons = [];
											var maxh = 146;
											var sz = new OpenLayers.Size(80, 27);
											var centered = new OpenLayers.Pixel(
													px.x, px.y);
											var wposition = sz.w / 2;
											px.y = centered.y + sz.h;
											this._addButton('panup',
													"pan-up2.png", centered,
													sz, '위로이동');
											this
													._addButton(
															'panleft',
															"pan-left2.png",
															px,
															new OpenLayers.Size(
																	40, 27),
															'좌로이동');
											this
													._addButton(
															'panright',
															"pan-right2.png",
															px
																	.add(
																			wposition,
																			0),
															new OpenLayers.Size(
																	40, 27),
															'우로이동');
											if (this.zoomWorldIcon) {
												this
														._addButton(
																'zoomworld',
																"pan-zoom-world2.png",
																px
																		.add(
																				sz.w / 2 - 11,
																				0),
																new OpenLayers.Size(
																		22, 27),
																'전체보기');
												wposition *= 2;
											}
											this._addButton('pandown',
													"pan-down2.png", centered
															.add(0, sz.h + 27),
													sz, '아래로이동');
											if (this.isSimpleBar != true) {
												this._addButton('zoomin',
														"pan-zoom-plus2.png",
														centered.add(24,
																sz.h * 3 + 5),
														new OpenLayers.Size(30,
																29), '확대');
												centered = this
														._addZoomBar(centered
																.add(
																		24,
																		sz.h * 4 + 5));
												this._addButton('zoomout',
														"pan-zoom-minus2.png",
														centered.add(0, 0),
														new OpenLayers.Size(30,
																29), '축소');
												this.measureDiv.style.top = centered.y
														+ 35 + 'px';
												this.measureDiv.style.left = centered.x
														+ 'px';
												maxh = 266;
											} else {
												this._addButton('zoomin',
														"pan-zoom-plus2.png",
														centered.add(24,
																sz.h * 3 + 5),
														new OpenLayers.Size(30,
																29), '확대');
												this._addButton('zoomout',
														"pan-zoom-minus2.png",
														centered.add(24,
																sz.h * 4 + 5),
														new OpenLayers.Size(30,
																29), '축소');
												this.measureDiv.style.top = centered.y
														+ sz.h * 4 + 35 + 'px';
												this.measureDiv.style.left = centered.x
														+ 24 + 'px';
											}
											this
													._addEtcButton(
															'init',
															"pan_init2.png",
															new OpenLayers.Pixel(
																	0, 0),
															new OpenLayers.Size(
																	30, 30),
															'초기화');
											this
													._addEtcButton(
															'caldist',
															"pan_dist2.png",
															new OpenLayers.Pixel(
																	0, 32),
															new OpenLayers.Size(
																	30, 30),
															'거리측정');
											this
													._addEtcButton(
															'calarea',
															"pan_area2.png",
															new OpenLayers.Pixel(
																	0, 61),
															new OpenLayers.Size(
																	30, 30),
															'면적측정');
											maxh = maxh + 100;
											this.div.style.height = maxh + 'px';
											this.div.style.top = '25px';
											if (this.curPosition == 'left') {
												this.div.style.left = '30px';
												if (vworldFunc
														._GetElement(vworldIDs.idshim) != null) {
													vworldFunc
															._GetElement(vworldIDs.idshim).style.left = vworldFunc
															._GetElement(vworldIDs.idmenu).style.left = '';
													vworldFunc
															._GetElement(vworldIDs.idshim).style.right = vworldFunc
															._GetElement(vworldIDs.idmenu).style.right = 4 + 'px';
												}
											} else {
												this.div.style.right = '30px';
												try {
													this.div.style.clear = 'both';
													this.div.style.float = 'none';
												} catch (e) {
												}
												this.div.style.left = '';
												if (vworldFunc
														._GetElement(vworldIDs.idshim) != null) {
													vworldFunc
															._GetElement(vworldIDs.idshim).style.right = vworldFunc
															._GetElement(vworldIDs.idmenu).style.right = '';
													vworldFunc
															._GetElement(vworldIDs.idshim).style.left = vworldFunc
															._GetElement(vworldIDs.idmenu).style.left = 4 + 'px';
												}
											}
											this.div
													.appendChild(this.measureDiv);
											return this.div;
										},
										_addZoomBar : function(centered) {
											var imgLocation = OpenLayers.Util
													.getImagesLocation();
											var id = this.id + '_'
													+ this.map.id;
											var zoomsToEnd = this.map
													.getNumZoomLevels()
													- 1
													- this.map.getZoom()
													- this.map.getMinLevel();
											var slider = OpenLayers.Util
													.createAlphaImageDiv(
															id,
															centered
																	.add(
																			-1,
																			zoomsToEnd
																					* this.zoomStopHeight),
															new OpenLayers.Size(
																	16, 8),
															imgLocation
																	+ "pan-slider2.png",
															'absolute');
											slider.style.cursor = "move";
											slider.style.paddingLeft = "8px";
											this.slider = slider;
											this.sliderEvents = new OpenLayers.Events(
													this, slider, null, true, {
														includeXY : true
													});
											this.sliderEvents
													.on({
														"touchstart" : this.zoomBarDown,
														"touchmove" : this.zoomBarDrag,
														"touchend" : this.zoomBarUp,
														"mousedown" : this.zoomBarDown,
														"mousemove" : this.zoomBarDrag,
														"mouseup" : this.zoomBarUp
													});
											var sz = new OpenLayers.Size();
											sz.h = this.zoomStopHeight
													* (this.map
															.getNumZoomLevels()
															- this.map
																	.getMinLevel() + 1);
											sz.w = this.zoomStopWidth;
											var div = null;
											if (OpenLayers.Util.alphaHack()) {
												var id = this.id + '_'
														+ this.map.id;
												div = OpenLayers.Util
														.createAlphaImageDiv(
																id,
																centered,
																new OpenLayers.Size(
																		sz.w,
																		this.zoomStopHeight),
																imgLocation
																		+ "pan-zoombar2.png",
																'absolute',
																null, 'crop');
												div.style.height = sz.h + 'px';
											} else {
												div = OpenLayers.Util
														.createDiv(
																'vworld_PanZoomBar_Zoombar'
																		+ this.map.id,
																centered,
																sz,
																imgLocation
																		+ "pan-zoombar2.png");
											}
											div.style.cursor = "pointer";
											div.className = "olButton";
											this.zoombarDiv = div;
											this.div.appendChild(div);
											this.startTop = parseInt(div.style.top);
											this.div.appendChild(slider);
											this.map.events.register('zoomend',
													this, this.moveZoomBar);
											centered = centered
													.add(
															0,
															this.zoomStopHeight
																	* (this.map
																			.getNumZoomLevels() - this.map
																			.getMinLevel()));
											return centered;
										},
										_removeZoomBar : function() {
											if (this.sliderEvents != null) {
												this.sliderEvents
														.un({
															"touchstart" : this.zoomBarDown,
															"touchmove" : this.zoomBarDrag,
															"touchend" : this.zoomBarUp,
															"mousedown" : this.zoomBarDown,
															"mousemove" : this.zoomBarDrag,
															"mouseup" : this.zoomBarUp
														});
												this.sliderEvents.destroy();
												this.sliderEvents = null;
											}
											if (this.divEvents != null) {
												this.divEvents.destroy();
												this.divEvents = null;
											}
											if (this.zoombarDiv != null) {
												this.div
														.removeChild(this.zoombarDiv);
												this.zoombarDiv = null;
											}
											if (this.measureDiv != null) {
												this.div
														.removeChild(this.measureDiv);
												this.measureDiv = null;
											}
											if (this.slider != null) {
												this.div
														.removeChild(this.slider);
												this.slider = null;
											}
											if (this.moveZoomBar != null) {
												this.map.events.unregister(
														'zoomend', this,
														this.moveZoomBar);
											}
										},
										onButtonClick : function(evt) {
											var btn = evt.buttonElement;
											switch (btn.action) {
											case "panup":
												this.map.pan(0, -this
														.getSlideFactor("h"));
												break;
											case "pandown":
												this.map.pan(0, this
														.getSlideFactor("h"));
												break;
											case "panleft":
												this.map
														.pan(
																-this
																		.getSlideFactor("w"),
																0);
												break;
											case "panright":
												this.map
														.pan(
																this
																		.getSlideFactor("w"),
																0);
												break;
											case "zoomin":
												this.map.zoomIn();
												break;
											case "zoomout":
												this.map.zoomOut();
												break;
											case "zoomworld":
												this.map.zoomToMaxExtent();
												break;
											case "info":
												this.map.infoOn();
												break;
											case "caldist":
												this.map.calcDistance();
												break;
											case "calarea":
												this.map.calcArea();
												break;
											case "init":
												this.map.initAll();
												break;
											}
											if (evt.buttonElement === this.zoombarDiv) {
												var levels = evt.buttonXY.y
														/ this.zoomStopHeight;
												if (this.forceFixedZoomLevel
														|| !this.map.fractionalZoom) {
													levels = Math.floor(levels);
												}
												var zoom = (this.map
														.getNumZoomLevels() - 1)
														- levels;
												zoom = Math
														.min(
																Math.max(zoom,
																		0),
																this.map
																		.getNumZoomLevels() - 1);
												this.map.zoomTo(zoom);
											}
										},
										passEventToSlider : function(evt) {
											this.sliderEvents
													.handleBrowserEvent(evt);
										},
										zoomBarDown : function(evt) {
											if (!OpenLayers.Event
													.isLeftClick(evt)
													&& !OpenLayers.Event
															.isSingleTouch(evt)) {
												return;
											}
											this.map.events
													.on({
														"touchmove" : this.passEventToSlider,
														'mousemove' : this.passEventToSlider,
														'mouseup' : this.passEventToSlider,
														scope : this
													});
											this.mouseDragStart = evt.xy
													.clone();
											this.zoomStart = evt.xy.clone();
											this.div.style.cursor = 'move';
											this.zoombarDiv.offsets = null;
											OpenLayers.Event.stop(evt);
										},
										zoomBarDrag : function(evt) {
											if (this.mouseDragStart != null) {
												var deltaY = this.mouseDragStart.y
														- evt.xy.y;
												var offsets = OpenLayers.Util
														.pagePosition(this.zoombarDiv);
												if ((evt.clientY - offsets[1]) > 0
														&& (evt.clientY - offsets[1]) < parseInt(this.zoombarDiv.style.height) - 2) {
													var newTop = parseInt(this.slider.style.top)
															- deltaY;
													this.slider.style.top = newTop
															+ 'px';
													this.mouseDragStart = evt.xy
															.clone();
												}
												this.deltaY = this.zoomStart.y
														- evt.xy.y;
												OpenLayers.Event.stop(evt);
											}
										},
										zoomBarUp : function(evt) {
											if (!OpenLayers.Event
													.isLeftClick(evt)
													&& evt.type !== "touchend") {
												return;
											}
											if (this.mouseDragStart) {
												this.div.style.cursor = '';
												this.map.events
														.un({
															"touchmove" : this.passEventToSlider,
															'mouseup' : this.passEventToSlider,
															'mousemove' : this.passEventToSlider,
															scope : this
														});
												var deltaY = this.zoomStart.y
														- evt.xy.y;
												var zoomLevel = this.map.zoom;
												if (!this.forceFixedZoomLevel
														&& this.map.fractionalZoom) {
													zoomLevel += deltaY
															/ this.zoomStopHeight;
													zoomLevel = Math
															.min(
																	Math
																			.max(
																					zoomLevel,
																					0),
																	this.map
																			.getNumZoomLevels() - 1);
												} else {
													zoomLevel += Math
															.round(deltaY
																	/ this.zoomStopHeight);
												}
												this.map.zoomTo(zoomLevel);
												this.mouseDragStart = null;
												this.zoomStart = null;
												this.deltaY = 0;
												OpenLayers.Event.stop(evt);
											}
										},
										moveZoomBar : function() {
											var newTop = ((this.map
													.getNumZoomLevels() - 1) - this.map
													.getZoom())
													* this.zoomStopHeight
													+ this.startTop + 1;
											this.slider.style.top = newTop
													+ 'px';
										},
										_addButton : function(id, img, xy, sz,
												tooltip) {
											var imgLocation = OpenLayers.Util
													.getImagesLocation()
													+ img;
											var btn = OpenLayers.Util
													.createAlphaImageDiv(
															this.id + "_" + id,
															xy, sz,
															imgLocation,
															"absolute");
											btn.style.cursor = "pointer";
											btn.alt = tooltip;
											btn.title = tooltip;
											this.div.appendChild(btn);
											btn.action = id;
											btn.className = "olButton";
											btn.map = this.map;
											if (!this.slideRatio) {
												var slideFactorPixels = this.slideFactor;
												var getSlideFactor = function() {
													return slideFactorPixels;
												};
											} else {
												var slideRatio = this.slideRatio;
												var getSlideFactor = function(
														dim) {
													return this.map.getSize()[dim]
															* slideRatio;
												};
											}
											btn.getSlideFactor = getSlideFactor;
											this.buttons.push(btn);
											return btn;
										},
										_addEtcButton : function(id, img, xy,
												sz, tooltip) {
											var imgLocation = OpenLayers.Util
													.getImagesLocation()
													+ img;
											var btn = OpenLayers.Util
													.createAlphaImageDiv(
															this.id + "_" + id,
															xy, sz,
															imgLocation,
															"absolute");
											btn.style.cursor = "pointer";
											btn.alt = tooltip;
											btn.title = tooltip;
											this.measureDiv.appendChild(btn);
											btn.action = id;
											btn.className = "olButton";
											btn.map = this.map
											this.measurebuttons.push(btn);
											return btn;
										},
										CLASS_NAME : "vworld.PanZoomBar"
									});
					vworld.ClosePopup = OpenLayers
							.Class({
								id : "",
								lonlat : null,
								div : null,
								size : null,
								displayClass : "olVClosePopup",
								divEvents : null,
								closeCallback : null,
								map : null,
								initialize : function(lonlat, callback) {
									this.id = OpenLayers.Util
											.createUniqueID(this.CLASS_NAME
													+ "_");
									this.lonlat = lonlat;
									this.size = new OpenLayers.Size(12, 12);
									this.closeCallback = callback;
									this.div = OpenLayers.Util.createDiv(
											this.id, null, null, null, null,
											null, "hidden");
									this.div.className = this.displayClass;
									this.div.style.width = this.size.w + "px";
									this.div.style.height = this.size.h + "px";
									this.divEvents = new OpenLayers.Events(
											this, this.div, null, true, {
												includeXY : true
											});
									this.divEvents.on({
										"mousedown" : this.divClick,
										"touchend" : this.divClick
									});
								},
								divClick : function(evt) {
									OpenLayers.Event.stop(evt);
									this.closeCallback();
									this.destroy();
								},
								draw : function(px) {
									if (px == null) {
										if ((this.lonlat != null)
												&& (this.map != null)) {
											px = this.map
													.getLayerPxFromLonLat(this.lonlat);
										}
									}
									if (px) {
										px.y = px.y + 6;
										px.x = px.x - 4;
										this.moveTo(px);
									}
									return this.div;
								},
								moveTo : function(px) {
									if ((px != null) && (this.div != null)) {
										this.div.style.left = px.x + "px";
										this.div.style.top = px.y + "px";
									}
								},
								updatePosition : function() {
									if ((this.lonlat) && (this.map)) {
										var px = this.map
												.getLayerPxFromLonLat(this.lonlat);
										if (px) {
											px.y = px.y + 6;
											px.x = px.x - 4;
											this.moveTo(px);
										}
									}
								},
								destroy : function() {
									this.id = null;
									this.lonlat = null;
									this.size = null;
									if (this.divEvents != null) {
										this.divEvents.un({
											"mousedown" : this.divClick
										});
										this.divEvents.destroy();
									}
									this.divEvents = null;
									this.closeCallback = null;
									if (this.map != null) {
										this.map.removePopup(this);
									}
									this.map = null;
									this.div = null;
								},
								CLASS_NAME : "vworld.ClosePopup"
							});
					vworld.AnchoredPopup = OpenLayers
							.Class(
									OpenLayers.Popup.Anchored,
									{
										autoSize : true,
										moveTo : function(px) {
											var oldRelativePosition = this.relativePosition;
											this.relativePosition = this
													.calculateRelativePosition(px);
											if (this.relativePosition.charAt(1) == 'l') {
												px.x -= 4;
											} else {
												px.x += 4;
											}
											var newPx = this.calculateNewPx(px);
											var newArguments = new Array(newPx);
											OpenLayers.Popup.prototype.moveTo
													.apply(this, newArguments);
										},
										CLASS_NAME : "vworld.AnchoredPopup"
									});
					vworld.FramedCloud = OpenLayers
							.Class(
									OpenLayers.Popup.Framed,
									{
										contentDisplayClass : "olFramedCloudPopupContent",
										autoSize : true,
										panMapIfOutOfView : true,
										imageSize : new OpenLayers.Size(676,
												736),
										isAlphaImage : false,
										fixedRelativePosition : false,
										closeOnMove : false,
										positionBlocks : {
											"tl" : {
												'offset' : new OpenLayers.Pixel(
														44, 0),
												'padding' : new OpenLayers.Bounds(
														8, 40, 8, 9),
												'blocks' : [
														{
															size : new OpenLayers.Size(
																	'auto',
																	'auto'),
															anchor : new OpenLayers.Bounds(
																	0, 53, 40,
																	0),
															position : new OpenLayers.Pixel(
																	0, 0)
														},
														{
															size : new OpenLayers.Size(
																	40, 'auto'),
															anchor : new OpenLayers.Bounds(
																	null, 53,
																	0, 0),
															position : new OpenLayers.Pixel(
																	-620, 0)
														},
														{
															size : new OpenLayers.Size(
																	'auto', 40),
															anchor : new OpenLayers.Bounds(
																	0, 13, 40,
																	null),
															position : new OpenLayers.Pixel(
																	0, -611)
														},
														{
															size : new OpenLayers.Size(
																	40, 40),
															anchor : new OpenLayers.Bounds(
																	null, 13,
																	0, null),
															position : new OpenLayers.Pixel(
																	-620, -611)
														},
														{
															size : new OpenLayers.Size(
																	91, 50),
															anchor : new OpenLayers.Bounds(
																	null, -18,
																	0, null),
															position : new OpenLayers.Pixel(
																	0, -690)
														} ]
											},
											"tr" : {
												'offset' : new OpenLayers.Pixel(
														-45, 0),
												'padding' : new OpenLayers.Bounds(
														8, 40, 8, 9),
												'blocks' : [
														{
															size : new OpenLayers.Size(
																	'auto',
																	'auto'),
															anchor : new OpenLayers.Bounds(
																	0, 53, 40,
																	0),
															position : new OpenLayers.Pixel(
																	0, 0)
														},
														{
															size : new OpenLayers.Size(
																	40, 'auto'),
															anchor : new OpenLayers.Bounds(
																	null, 53,
																	0, 0),
															position : new OpenLayers.Pixel(
																	-620, 0)
														},
														{
															size : new OpenLayers.Size(
																	'auto', 40),
															anchor : new OpenLayers.Bounds(
																	0, 13, 40,
																	null),
															position : new OpenLayers.Pixel(
																	0, -611)
														},
														{
															size : new OpenLayers.Size(
																	40, 40),
															anchor : new OpenLayers.Bounds(
																	null, 13,
																	0, null),
															position : new OpenLayers.Pixel(
																	-620, -611)
														},
														{
															size : new OpenLayers.Size(
																	91, 50),
															anchor : new OpenLayers.Bounds(
																	0, -18,
																	null, null),
															position : new OpenLayers.Pixel(
																	-215, -690)
														} ]
											},
											"bl" : {
												'offset' : new OpenLayers.Pixel(
														45, 0),
												'padding' : new OpenLayers.Bounds(
														8, 9, 8, 40),
												'blocks' : [
														{
															size : new OpenLayers.Size(
																	'auto',
																	'auto'),
															anchor : new OpenLayers.Bounds(
																	0, 40, 40,
																	32),
															position : new OpenLayers.Pixel(
																	0, 0)
														},
														{
															size : new OpenLayers.Size(
																	40, 'auto'),
															anchor : new OpenLayers.Bounds(
																	null, 40,
																	0, 32),
															position : new OpenLayers.Pixel(
																	-620, 0)
														},
														{
															size : new OpenLayers.Size(
																	'auto', 40),
															anchor : new OpenLayers.Bounds(
																	0, 0, 40,
																	null),
															position : new OpenLayers.Pixel(
																	0, -601)
														},
														{
															size : new OpenLayers.Size(
																	40, 40),
															anchor : new OpenLayers.Bounds(
																	null, 0, 0,
																	null),
															position : new OpenLayers.Pixel(
																	-620, -601)
														},
														{
															size : new OpenLayers.Size(
																	91, 35),
															anchor : new OpenLayers.Bounds(
																	null, null,
																	0, 0),
															position : new OpenLayers.Pixel(
																	-101, -674)
														} ]
											},
											"br" : {
												'offset' : new OpenLayers.Pixel(
														-44, 0),
												'padding' : new OpenLayers.Bounds(
														8, 9, 8, 40),
												'blocks' : [
														{
															size : new OpenLayers.Size(
																	'auto',
																	'auto'),
															anchor : new OpenLayers.Bounds(
																	0, 40, 40,
																	32),
															position : new OpenLayers.Pixel(
																	0, 0)
														},
														{
															size : new OpenLayers.Size(
																	40, 'auto'),
															anchor : new OpenLayers.Bounds(
																	null, 40,
																	0, 32),
															position : new OpenLayers.Pixel(
																	-620, 0)
														},
														{
															size : new OpenLayers.Size(
																	'auto', 40),
															anchor : new OpenLayers.Bounds(
																	0, 0, 40,
																	null),
															position : new OpenLayers.Pixel(
																	0, -601)
														},
														{
															size : new OpenLayers.Size(
																	40, 40),
															anchor : new OpenLayers.Bounds(
																	null, 0, 0,
																	null),
															position : new OpenLayers.Pixel(
																	-620, -601)
														},
														{
															size : new OpenLayers.Size(
																	91, 35),
															anchor : new OpenLayers.Bounds(
																	0, null,
																	null, 0),
															position : new OpenLayers.Pixel(
																	-311, -674)
														} ]
											}
										},
										minSize : new OpenLayers.Size(200, 120),
										maxSize : new OpenLayers.Size(1200, 660),
										initialize : function(id, lonlat,
												contentSize, contentHTML,
												anchor, closeBox,
												closeBoxCallback, autoSize) {
											this.imageSrc = OpenLayers.Util
													.getImagesLocation()
													+ 'cloud-popup-relative-shadowed-b.png';
											this.autoSize = (autoSize != null) ? autoSize
													: true;
											OpenLayers.Popup.Framed.prototype.initialize
													.apply(this, arguments);
											this.contentDiv.className = this.contentDisplayClass;
											this.closeDiv.title = "닫기";
										},
										destroy : function() {
											OpenLayers.Popup.Framed.prototype.destroy
													.apply(this, arguments);
										},
										CLASS_NAME : "vworld.FramedCloud"
									});
					vworld.FramedBox = OpenLayers
							.Class(
									OpenLayers.Popup.Framed,
									{
										contentDisplayClass : "olFramedBoxPopupContent",
										closeDisplayClass : "olFramedBoxClose",
										imageSrc : OpenLayers.Util
												.getImagesLocation()
												+ 'box-popup-gray.png',
										closeBoxSize : {
											w : 20,
											h : 20
										},
										autoSize : true,
										panMapIfOutOfView : true,
										imageSize : new OpenLayers.Size(676,
												736),
										isAlphaImage : false,
										fixedRelativePosition : false,
										closeOnMove : false,
										relativePosition : "tm",
										positionBlocks : {
											"tm" : {
												'offset' : {
													x : 0,
													y : -20
												},
												'padding' : {
													left : 8,
													bottom : 30,
													right : 8,
													top : 10
												},
												'blocks' : [ {
													size : {
														w : 'auto',
														h : 'auto'
													},
													anchor : {
														left : 0,
														bottom : 38,
														right : 15,
														top : 0
													},
													position : {
														x : 0,
														y : 0
													}
												}, {
													size : {
														w : 25,
														h : 'auto'
													},
													anchor : {
														left : null,
														bottom : 38,
														right : 0,
														top : 0
													},
													position : {
														x : -618,
														y : 0
													}
												}, {
													size : {
														w : 'auto',
														h : 26
													},
													anchor : {
														left : 0,
														bottom : 12,
														right : 15,
														top : null
													},
													position : {
														x : 0,
														y : -611
													}
												}, {
													size : {
														w : 25,
														h : 26
													},
													anchor : {
														left : null,
														bottom : 12,
														right : 0,
														top : null
													},
													position : {
														x : -618,
														y : -611
													}
												}, {
													size : {
														w : 20,
														h : 15
													},
													anchor : {
														left : "middle",
														bottom : 0,
														right : 0,
														top : null
													},
													position : {
														x : -24,
														y : -697
													}
												} ]
											},
											"bm" : {
												'offset' : {
													x : 0,
													y : 0
												},
												'padding' : {
													left : 8,
													bottom : 15,
													right : 8,
													top : 20
												},
												'blocks' : [ {
													size : {
														w : 'auto',
														h : 'auto'
													},
													anchor : {
														left : 0,
														bottom : 40,
														right : 15,
														top : 13
													},
													position : {
														x : 0,
														y : 0
													}
												}, {
													size : {
														w : 25,
														h : 'auto'
													},
													anchor : {
														left : null,
														bottom : 15,
														right : 0,
														top : 13
													},
													position : {
														x : -618,
														y : 0
													}
												}, {
													size : {
														w : 'auto',
														h : 40
													},
													anchor : {
														left : 0,
														bottom : 0,
														right : 15,
														top : null
													},
													position : {
														x : 0,
														y : -597
													}
												}, {
													size : {
														w : 25,
														h : 40
													},
													anchor : {
														left : null,
														bottom : 0,
														right : 0,
														top : null
													},
													position : {
														x : -618,
														y : -597
													}
												}, {
													size : {
														w : 20,
														h : 16
													},
													anchor : {
														left : "middle",
														bottom : null,
														right : 0,
														top : 0
													},
													position : {
														x : -54,
														y : -690
													}
												} ]
											}
										},
										minSize : new OpenLayers.Size(200, 70),
										maxSize : new OpenLayers.Size(1200, 660),
										initialize : function(id, lonlat,
												contentSize, contentHTML,
												anchor, closeBox,
												closeBoxCallback, autoSize) {
											this.autoSize = (autoSize != null) ? autoSize
													: true;
											OpenLayers.Popup.Framed.prototype.initialize
													.apply(this, arguments);
											this.contentDiv.className = this.contentDisplayClass;
											if (this.closeDiv != null) {
												this.closeDiv.className = this.closeDisplayClass;
												this.closeDiv.title = "닫기";
											}
										},
										addCloseBox : function(callback) {
											this.closeDiv = OpenLayers.Util
													.createDiv(this.id
															+ "_close", null,
															this.closeBoxSize);
											this.closeDiv.className = this.closeDisplayClass;
											var contentDivPadding = this
													.getContentDivPadding();
											this.closeDiv.style.right = contentDivPadding.right
													+ "px";
											this.closeDiv.style.top = contentDivPadding.top
													+ "px";
											this.groupDiv
													.appendChild(this.closeDiv);
											var closePopup = callback
													|| function(e) {
														this.hide();
														OpenLayers.Event
																.stop(e);
													};
											OpenLayers.Event
													.observe(
															this.closeDiv,
															"touchend",
															OpenLayers.Function
																	.bindAsEventListener(
																			closePopup,
																			this));
											OpenLayers.Event
													.observe(
															this.closeDiv,
															"click",
															OpenLayers.Function
																	.bindAsEventListener(
																			closePopup,
																			this));
										},
										calculateNewPx : function(px) {
											var curPosition = this.relativePosition;
											if (curPosition.charAt(1) != 'm') {
												this.relativePosition = this.relativePosition
														.charAt(0)
														+ 'm';
											}
											var newPx = OpenLayers.Popup.Anchored.prototype.calculateNewPx
													.apply(this, arguments);
											newPx = newPx
													.offset(this.positionBlocks[this.relativePosition].offset);
											var size = this.size
													|| this.contentSize;
											if (this.relativePosition.charAt(1) == 'l') {
												newPx.x += -size.w;
											} else if (this.relativePosition
													.charAt(1) == 'm') {
												newPx.x += -(size.w / 2);
											} else {
												newPx.x += this.anchor.size.w;
											}
											return newPx;
										},
										updateBlocks : function() {
											if (!this.blocks) {
												this.createBlocks();
											}
											if (this.size
													&& this.relativePosition) {
												var position = this.positionBlocks[this.relativePosition];
												var ml = Math
														.round((this.size.w / 2) - 10);
												for (var i = 0; i < position.blocks.length; i++) {
													var positionBlock = position.blocks[i];
													var block = this.blocks[i];
													var l = positionBlock.anchor.left;
													var b = positionBlock.anchor.bottom;
													var r = positionBlock.anchor.right;
													var t = positionBlock.anchor.top;
													var w = (isNaN(positionBlock.size.w)) ? this.size.w
															- (r + l)
															: positionBlock.size.w;
													var h = (isNaN(positionBlock.size.h)) ? this.size.h
															- (b + t)
															: positionBlock.size.h;
													block.div.style.width = (w < 0 ? 0
															: w)
															+ 'px';
													block.div.style.height = (h < 0 ? 0
															: h)
															+ 'px';
													block.div.style.left = (l != null) ? ((l
															.toString().match(
																	'%') != null) ? l
															: ((l
																	.toString()
																	.match(
																			'middle') != null) ? ml
																	+ 'px'
																	: l + 'px'))
															: '';
													block.div.style.bottom = (b != null) ? ((b
															.toString().match(
																	'%') != null) ? b
															: b + 'px')
															: '';
													block.div.style.right = (r != null) ? ((r
															.toString().match(
																	'%') != null) ? r
															: r + 'px')
															: '';
													block.div.style.top = (t != null) ? ((t
															.toString().match(
																	'%') != null) ? t
															: t + 'px')
															: '';
													block.image.style.left = positionBlock.position.x
															+ 'px';
													block.image.style.top = positionBlock.position.y
															+ 'px';
												}
												this.contentDiv.style.left = this.padding.left
														+ "px";
												this.contentDiv.style.top = this.padding.top
														+ "px";
											}
										},
										destroy : function() {
											OpenLayers.Popup.Framed.prototype.destroy
													.apply(this, arguments);
										},
										CLASS_NAME : "vworld.FramedBox"
									});
					vworld.Size = OpenLayers.Class(OpenLayers.Size, {
						set : function(width, height) {
							this.w = width;
							this.h = height;
						},
						setWidth : function(width) {
							this.w = width;
						},
						getWidth : function() {
							return this.w;
						},
						setHeight : function(height) {
							this.h = height;
						},
						getHeight : function() {
							return this.h;
						},
						copy : function() {
							return this.clone();
						},
						CLASS_NAME : "vworld.Size"
					});
					vworld.Point = OpenLayers
							.Class(
									OpenLayers.Feature.Vector,
									{
										initialize : function(x, y, style) {
											this.id = OpenLayers.Util
													.createUniqueID(this.CLASS_NAME
															+ "_");
											var geometry = new OpenLayers.Geometry.Point(
													x, y);
											OpenLayers.Feature.prototype.initialize
													.apply(this, [ null, null,
															null ]);
											this.lonlat = null;
											this.geometry = geometry ? geometry
													: null;
											this.state = null;
											this.attributes = {};
											this.style = style ? style : null;
										},
										set : function(mx, my) {
											this.geometry.x = mx;
											this.geometry.y = my;
											this.redraw();
										},
										setX : function(mx) {
											this.geometry.x = mx;
											this.redraw();
										},
										getX : function() {
											return this.geometry.x;
										},
										setY : function(my) {
											this.geometry.y = my;
											this.redraw();
										},
										getY : function() {
											return this.geometry.y;
										},
										setNote : function(note) {
											this.attributes.label = note;
										},
										getNote : function() {
											return this.attributes.label;
										},
										getDistance : function(pt) {
											var p1 = new OpenLayers.Geometry.Point(
													this.getX(), this.getY());
											var p2 = new OpenLayers.Geometry.Point(
													pt.getX(), pt.getY());
											var segment = new OpenLayers.Geometry.LineString(
													[ p1, p2 ]);
											var tmpdist = segment
													.getGeodesicLength(new OpenLayers.Projection(
															originalProj));
											return tmpdist;
										},
										copy : function() {
											return this.clone();
										},
										redraw : function() {
											if (this.layer != null)
												this.layer.drawFeature(this);
										},
										CLASS_NAME : "vworld.Point"
									});
					vworld.Polyline = OpenLayers
							.Class(
									OpenLayers.Feature.Vector,
									{
										initialize : function(ptlist, style) {
											this.id = OpenLayers.Util
													.createUniqueID(this.CLASS_NAME
															+ "_");
											var geometry = new OpenLayers.Geometry.LineString(
													ptlist);
											OpenLayers.Feature.prototype.initialize
													.apply(this, [ null, null,
															null ]);
											this.lonlat = null;
											this.geometry = geometry ? geometry
													: null;
											this.state = null;
											this.attributes = {};
											this.style = style ? style : null;
										},
										setStyle : function(style) {
											this.style.strokeDashstyle = style;
											this.redraw();
										},
										getStyle : function() {
											return this.style.strokeDashstyle
													|| "solid";
										},
										setWeight : function(weight) {
											this.style.strokeWidth = weight;
											this.redraw();
										},
										getWeight : function() {
											return this.style.strokeWidth;
										},
										setColor : function(color) {
											this.style.strokeColor = color;
											this.redraw();
										},
										getColor : function() {
											return this.style.strokeColor;
										},
										setOpacity : function(opacity) {
											this.style.strokeOpacity = opacity;
											this.redraw();
										},
										getOpacity : function() {
											return this.style.strokeOpacity;
										},
										addNewPoint : function(pt) {
											this.geometry.addPoint(pt);
											this.redraw();
											return this;
										},
										getPolyBounds : function() {
											return this.getBounds();
										},
										redraw : function() {
											this.layer.drawFeature(this);
										},
										CLASS_NAME : "vworld.Polyline"
									});
					vworld.Polyline2 = OpenLayers
							.Class(
									OpenLayers.Feature.Vector,
									{
										initialize : function(ptlist, style) {
											this.id = OpenLayers.Util
													.createUniqueID(this.CLASS_NAME
															+ "_");
											var geometry = new OpenLayers.Geometry.Collection(
													[ new OpenLayers.Geometry.LineString(
															ptlist) ]);
											OpenLayers.Feature.prototype.initialize
													.apply(this, [ null, null,
															null ]);
											this.lonlat = null;
											this.geometry = geometry ? geometry
													: null;
											this.state = null;
											this.attributes = {};
											this.style = style ? style : null;
											this.start = null;
											this.end = null;
										},
										setStyle : function(style) {
											this.style.strokeDashstyle = style;
											this.redraw();
										},
										getStyle : function() {
											return this.style.strokeDashstyle
													|| "solid";
										},
										setWeight : function(weight) {
											this.style.strokeWidth = weight;
											this.redraw();
										},
										getWeight : function() {
											return this.style.strokeWidth;
										},
										setColor : function(color) {
											this.style.strokeColor = color;
											this.redraw();
										},
										getColor : function() {
											return this.style.strokeColor;
										},
										setOpacity : function(opacity) {
											this.style.strokeOpacity = opacity;
											this.redraw();
										},
										getOpacity : function() {
											return this.style.strokeOpacity;
										},
										addNewPoint : function(pt) {
											this.geometry.components[0]
													.addPoint(pt);
											if (this.end) {
												this.end.x = pt.x;
												this.end.y = pt.y;
											}
											this.redraw();
											return this;
										},
										getPolyBounds : function() {
											return this.getBounds();
										},
										redraw : function() {
											if (this.end) {
												var d0 = this.geometry.components[0].components[this.geometry.components[0].components.length - 1];
												var d1 = this.geometry.components[0].components[this.geometry.components[0].components.length - 2];
												var a0 = (Math.atan2(d0.y
														- d1.y, d0.x - d1.x))
														* (180 / Math.PI);
												this.style.rotation = (a0 - 90)
														* -1;
											}
											this.layer.drawFeature(this);
										},
										showDirection : function() {
											if (!this.end) {
												this.end = this.geometry.components[0].components[this.geometry.components[0].components.length - 1]
														.clone();
												this.geometry
														.addComponent(this.end);
											}
											this.redraw();
										},
										CLASS_NAME : "vworld.Polyline2"
									});
					vworld.WmsBoundaryLayer = OpenLayers
							.Class(
									OpenLayers.Layer.WMS,
									{
										name : "Boundary Layer",
										layers : "LT_C_ADSIDO_2012",
										styles : "LT_C_ADSIDO",
										year : "2012",
										crs : "EPSG:900913",
										minlevel : 5,
										defaultOption : {
											singleTile : false,
											buffer : 0,
											isBaseLayer : false,
											tileSize : new OpenLayers.Size(256,
													256),
											visibility : true
										},
										initialize : function(name, layer,
												year, type) {
											this.name = name !== undefined ? name
													: this.name;
											if (layer != undefined
													&& year != undefined) {
												this.layers = layer + "_"
														+ year;
												this.styles = layer;
											} else if (layer != undefined
													&& year == undefined) {
												this.layers = layer + "_"
														+ this.year;
												this.styles = layer;
											}
											var params;
											if (type != undefined
													&& type == "3D") {
												if (layer == "LT_C_ADSIGG") {
													this.minlevel = 9
												} else if (layer == "LT_C_ADEMD"
														|| layer == "LT_C_ADRI") {
													this.minlevel = 12
												} else {
													this.minlevel = 5
												}
												params = {
													layers : this.layers,
													styles : this.styles
															+ "_3D",
													imgType : 'image/png',
													typename : this.layers,
													minlevel : this.minlevel,
													maxlevel : 18,
													setvisible : true
												}
												var returnLayer = this
														.show3DThemeLayer(name,
																params);
												return returnLayer;
											} else {
												params = {
													layers : this.layers,
													styles : this.styles,
													format : 'image/png',
													version : '1.3.0',
													crs : "EPSG:900913",
													exceptions : 'text/xml',
													transparent : 'true'
												}
												var newArguments = [];
												newArguments.push(this.name,
														this.url, params,
														this.defaultOption);
												OpenLayers.Layer.Grid.prototype.initialize
														.apply(this,
																newArguments);
												this.url = vworldUrls.wms;
											}
										},
										show3DThemeLayer : function(title,
												params) {
											if (!vworld.is3D()) {
												vworld.setMode(2);
												alert("3D 플러그인이 필요한 기능입니다.\n3D 모드로 전환합니다.");
												return;
											}
											if (typeof params !== 'object')
												return null;
											var layerIds = (params.layers != null) ? params.layers
													: null;
											var styles = (params.styles != null) ? params.styles
													: layerIds;
											var imgType = (params.imgType != null) ? params.imgType
													: 'image/png';
											var wfsName = (params.typename != null) ? params.typename
													: layerIds;
											var minlevel = (params.minlevel != null) ? params.minlevel
													: 5;
											var maxlevel = (params.maxlevel != null) ? params.maxlevel
													: 18;
											var setvisible = (params.setvisible != null) ? params.setvisible
													: false;
											var layerList = vearth
													.getLayerList();
											var layers;
											var tempLayer;
											var isNew = true;
											for (var i = 0; i <= layerList
													.count() - 1; i++) {
												tempLayer = layerList
														.indexAtLayer(i);
												if (title == tempLayer
														.getName()) {
													layers = tempLayer;
													isNew = false;
												}
											}
											if (layers == null
													|| layers == undefined) {
												layers = vearth.getLayerList()
														.createWMSLayer(title);
											}
											var con = vworldFunc
													._parseURL(vworldUrls.wms);
											if (vearth != null) {
												if (isNew) {
													state = sop.cons.enums.SOPVISIBLE_ON;
													layers.setConnectionWMS(
															con.host, con.port,
															con.path + "?");
													layers
															.setLayersWMS(layerIds);
													layers.setStylesWMS(styles);
													layers.setTileSizeWMS(256);
													layers.setLevelWMS(
															minlevel, maxlevel);
												} else {
													var isOn;
													if (layers.getVisible() == 257) {
														isOn = "레이어 OFF 상태 입니다.";
													} else {
														isOn = "레이어 ON 상태 입니다.";
													}
													alert("같은 이름의 주제도가 생성되어있습니다. \n레이어명 : "
															+ layers.getName()
															+ "\n" + isOn);
												}
											}
											return layers;
										},
										getYear : function(mapName) {
											var layerName = vmap
													.getLayerByName(mapName).params.layers;
											return layerName.substr(
													layerName.length - 4, 4);
										},
										wms2DMapRemove : function(mapName) {
											for (var i = 0, len = vmap.layers.length; i < len; i++) {
												var layer = vmap.layers[i];
												if (layer.name == mapName) {
													vmap.removeLayer(layer);
													break;
												}
											}
										},
										CLASS_NAME : "vworld.WmsBoundaryLayer"
									});
					vworld.Marker = OpenLayers
							.Class(
									OpenLayers.Marker,
									{
										id : "",
										title : null,
										desc : null,
										lonlat : null,
										thumbImage : null,
										popup : null,
										initialize : function(mx, my, title,
												desc, imgUrl, proj, inSize) {
											var size = (inSize) ? inSize
													: new OpenLayers.Size(20,
															20);
											var offset = new OpenLayers.Pixel(
													-(size.w / 2), -(size.h));
											var micon = null;
											if (typeof (imgUrl) != 'undefined') {
												this.thumbImage = imgUrl;
												micon = new OpenLayers.Icon(
														imgUrl, size, offset);
											} else {
												micon = new OpenLayers.Icon(
														vworldUrlsExt.marker
																+ vworldUrlsExt.markerimage,
														size, offset);
											}
											if (typeof (proj) == 'undefined')
												proj = originalProj;
											this.lonlat = new OpenLayers.LonLat(
													mx, my).transform(
													new OpenLayers.Projection(
															proj),
													new OpenLayers.Projection(
															originalProj));
											this.title = title;
											this.desc = desc;
											OpenLayers.Marker.prototype.initialize
													.apply(this, [ this.lonlat,
															micon ]);
											this.events = new OpenLayers.Events(
													this, this.icon.imageDiv,
													null, true, {
														includeXY : true
													});
											this.events
													.on({
														"click" : this.clickEventHandler,
														"touchend" : this.clickEventHandler
													});
										},
										clickEventHandler : function(evt) {
											if (this.popup != null) {
												this.popup.toggle();
												return;
											}
											var sImage = '';
											var tBody = '';
											tBody = (this.title != null) ? this.title
													: '';
											if (this.desc != '')
												tBody = tBody + "<br/>"
														+ this.desc;
											if (tBody != '') {
												var popup = new vworld.FramedCloud(
														'vm_pop', this.lonlat,
														new OpenLayers.Size(
																150, 150),
														tBody, null, true,
														this.onPopupClose);
												this.popup = popup;
												this.map.addPopup(this.popup);
											}
											if (evt != null)
												OpenLayers.Event
														.stop(evt, true);
										},
										setIconImage : function(imageName) {
											this.icon.url = imageName;
										},
										setZindex : function(zi) {
											this.icon.imageDiv.style.zIndex = zi;
										},
										setPosition : function(loc) {
											if (isNaN(loc.x)) {
												this.lonlat = new OpenLayers.LonLat(
														loc.lon, loc.lat);
											} else {
												this.lonlat = new OpenLayers.LonLat(
														loc.x, loc.y);
											}
											if (this.popup != null) {
												this.popup.lonlat = new OpenLayers.LonLat(
														this.lonlat.lon,
														this.lonlat.lat);
												this.popup.updatePosition()
											}
											this.map.userMarkers.redraw();
										},
										show : function() {
											this.display(true);
										},
										hide : function() {
											this.display(false);
										},
										erase : function() {
											if (this.popup != null) {
												this.map
														.removePopup(this.popup);
												this.popup.destroy();
												delete this.popup;
											}
											this.map = null;
											if (this.events != null) {
												this.events.destroy();
												this.events = null;
											}
											if (this.icon != null) {
												this.icon.destroy();
												this.icon = null;
											}
										},
										setFixedRelativePosition : function(
												fixed) {
											if (this.fixedRelativePosition
													&& this.popup) {
												this.popup.relativePosition = this.relativePosition;
												this.popup
														.updateRelativePosition();
												this.popup.calculateRelativePosition = function(
														px) {
													return this.relativePosition;
												};
											}
										},
										CLASS_NAME : "vworld.Marker"
									});
					vworld.MarkerA = OpenLayers
							.Class(
									vworld.Marker,
									{
										popupClass : vworld.FramedBox,
										closeDisplayClass : null,
										overflow : "auto",
										popupContentHTML : null,
										popupSize : null,
										fixedRelativePosition : false,
										relativePosition : "tm",
										closeBox : true,
										autoSize : true,
										initDisplay : false,
										initialize : function(mx, my, contents,
												imgUrl, proj, inSize) {
											var size = (inSize) ? inSize
													: new OpenLayers.Size(20,
															20);
											var offset = new OpenLayers.Pixel(
													-(size.w / 2), -(size.h));
											var micon = null;
											if (typeof (imgUrl) != 'undefined') {
												this.thumbImage = imgUrl;
												micon = new OpenLayers.Icon(
														imgUrl, size, offset);
											} else {
												micon = new OpenLayers.Icon(
														vworldUrlsExt.marker
																+ vworldUrlsExt.markerimage,
														size, offset);
											}
											if (typeof (proj) == 'undefined')
												proj = originalProj;
											this.lonlat = new OpenLayers.LonLat(
													mx, my).transform(
													new OpenLayers.Projection(
															proj),
													new OpenLayers.Projection(
															originalProj));
											this.popupContentHTML = contents;
											OpenLayers.Marker.prototype.initialize
													.apply(this, [ this.lonlat,
															micon ]);
											this.events = new OpenLayers.Events(
													this, this.icon.imageDiv,
													'click');
											this.events.register('click', null,
													this.clickEventHandler);
										},
										clickEventHandler : function(evt) {
											if (this.popup != null) {
												if (this.popup.map != null) {
													this.popup.toggle();
													return;
												} else {
													this.popup.destroy();
													delete this.popup;
												}
											}
											if (this.popupContentHTML != '') {
												if (this.lonlat != null) {
													if (!this.popup) {
														var anchor = null;
														var popupClass = this.popupClass ? this.popupClass
																: OpenLayers.Popup.Anchored;
														this.popup = new popupClass(
																this.id
																		+ "_popup",
																this.lonlat,
																this.popupSize,
																this.popupContentHTML,
																anchor,
																this.closeBox,
																null,
																this.autoSize);
													}
													if (this.overflow != null) {
														this.popup.contentDiv.style.overflow = this.overflow;
													}
													if (this.closeDisplayClass != null
															&& this.popup != null
															&& this.popup.closeDiv != null) {
														this.popup.closeDisplayClass = this.closeDisplayClass;
														this.popup.closeDiv.className = this.popup.closeDisplayClass;
													}
													this
															.setFixedRelativePosition(this.fixedRelativePosition);
												}
												this.map.addPopup(this.popup,
														this.initDisplay);
											}
											OpenLayers.Event.stop(evt, true);
										},
										CLASS_NAME : "vworld.MarkerA"
									});
					vworld.InfoWindow = OpenLayers
							.Class(
									OpenLayers.Popup,
									{
										initialize : function(id, x, y, size,
												contents) {
											var newArguments = [
													id,
													new OpenLayers.LonLat(x, y),
													size, contents, true ];
											OpenLayers.Popup.prototype.initialize
													.apply(this, newArguments);
											this.setBorder("1px dotted");
											this.closeDiv.className = "olInfoWindowCloseBox";
											this.closeDiv.style.height = this.closeDiv.style.width = '10px';
										},
										setPosition : function(x, y) {
											var px = this.map
													.getLayerPxFromLonLat(new OpenLayers.LonLat(
															x, y));
											this.div.style.left = px.x + 'px';
											this.div.style.top = px.y + 'px';
										},
										getPosition : function() {
											return {
												left : this.div.style.left,
												top : this.div.style.top
											};
										},
										isVisible : function() {
											return (this.div.style.display != 'none');
										},
										CLASS_NAME : "vworld.InfoWindow"
									});
					vworld.TileCache = OpenLayers
							.Class(
									OpenLayers.Layer.Grid,
									{
										tileOrigin : null,
										min_level : 9,
										max_level : 18,
										initialize : function(name, url,
												options) {
											var newArguments = [];
											newArguments.push(name, url, {},
													options);
											this.min_level = (options.min_level) ? options.min_level
													: 9;
											this.max_level = (options.max_level) ? options.max_level
													: 18;
											OpenLayers.Layer.Grid.prototype.initialize
													.apply(this, newArguments);
										},
										destroy : function() {
											OpenLayers.Layer.Grid.prototype.destroy
													.apply(this, arguments);
										},
										clone : function(obj) {
											if (obj == null) {
												obj = new vworld.TileCache(
														this.name, this.url,
														this.getOptions());
											}
											obj = OpenLayers.Layer.Grid.prototype.clone
													.apply(this, [ obj ]);
											return obj;
										},
										getURL : function(bounds) {
											bounds = this.adjustBounds(bounds);
											var res = this.map.getResolution();
											var x = Math
													.round((bounds.left - this.maxExtent.left)
															/ (res * this.tileSize.w));
											var y = Math
													.round((this.maxExtent.top - bounds.top)
															/ (res * this.tileSize.h));
											var z = this.map.getZoom();
											if (z >= this.min_level
													&& z <= this.max_level) {
												var path = "/" + this.layername
														+ "/" + z + "/" + x
														+ "/" + y + "."
														+ this.type;
											} else {
												return vworldUrlsExt.emptyimage;
											}
											var url = this.url;
											if (url instanceof Array) {
												url = this.selectUrl(path, url);
											}
											return url + path;
										},
										addTile : function(bounds, position) {
											return new OpenLayers.Tile.Image(
													this, position, bounds,
													null, this.tileSize);
										},
										setMap : function(map) {
											OpenLayers.Layer.Grid.prototype.setMap
													.apply(this, arguments);
											if (!this.tileOrigin) {
												this.tileOrigin = new OpenLayers.LonLat(
														this.map.maxExtent.left,
														this.map.maxExtent.top);
											}
										},
										CLASS_NAME : "vworld.TileCache"
									});
					vworld.TimeCache = OpenLayers.Class(vworld.TileCache, {
						changeTime : function(time) {
							if (time == null)
								return false;
							var idx = vworldTimes.times.indexOf(time);
							if (idx < 0)
								return false;
							this.layername = time;
							this.url = vworldUrls.times;
							this.type = vworldTimes.types[idx];
							this.initProperties();
							this.clearGrid();
							this.redraw();
							return true;
						},
						CLASS_NAME : "vworld.TimeCache"
					});
					OpenLayers.Feature.Vector.prototype.setColor = function(
							color) {
						this.style.strokeColor = color;
					};
					OpenLayers.Feature.Vector.prototype.getColor = function() {
						return this.style.strokeColor;
					};
					OpenLayers.Feature.Vector.prototype.getBounds = function() {
						return this.geometry.bounds;
					};
				}
			} catch (e) {
				var errMsg = "VWORLD Map을 초기화 할 수 없습니다.\n관리자에게 문의하십시오.\n\n[오류 내용]\n"
						+ e.description;
				(vworld.vmap != null) ? vworld.vmap.alarmInit(errMsg)
						: alert(errMsg);
			}
		},
		setupEarth : function(panelDiv, initCall, failCall) {
			var conDiv = vworldFunc._GetElement(panelDiv);
			if (conDiv == null)
				return false;
			var emap = vworldFunc._CreateElement('div');
			vworldIDs.id3d = OpenLayers.Util.createUniqueID('map3d');
			emap.setAttribute('id', vworldIDs.id3d);
			emap.style.cssText = "display:inline-block;position:relative;width:100%;height:100%;border:0px;z-index:-1";
			conDiv.appendChild(emap);
			vworld._makeinvisible(vworldIDs.id3d, true);
			sop.earth
					.createInstance(
							vworldIDs.id3d,
							function(obj) {
								if (initCall != null)
									initCall(obj);
								vearth = obj;
								if (vworldVar.maptype == "map-first") {
									vworldFunc._GetElement(vworldIDs.id2d).style.display = "none";
									vworld.setMode(2);
								} else {
									vworld.setMode(-1);
								}
								if (vworld.showMode == true) {
									var curshim = vworldFunc
											._GetElement(vworldIDs.idshim);
									sop.earth
											.addEventListener(
													vearth,
													"click",
													function(event) {
														if (curshim != null
																&& vworld.isLocked == false) {
															curshim.style.display = "none";
															curshim.style.display = "inline-block";
														}
													});
								}
								sop.earth
										.addEventListener(
												vearth,
												"lmousedown",
												function(event) {
													if (vearth.getView()
															.getWorkMode() != 1)
														return;
													vworldInfo.prevpixel.x = event.x;
													vworldInfo.prevpixel.y = event.y;
												});
								sop.earth
										.addEventListener(
												vearth,
												"lmouseup",
												function(event) {
													if (vearth.getView()
															.getWorkMode() != 1)
														return;
													if ((typeof _queryFields == 'undefined')
															|| (_queryFields.length < 1))
														return;
													var selObj = vearth
															.getView()
															.getSelectObject();
													if (selObj != null) {
														return;
													}
													if (vworldInfo.prevpixel.x != event.x
															|| vworldInfo.prevpixel.y != event.y) {
														return;
													}
													var cod = event
															.getMapCoordinate();
													if (event.getTarget() != null) {
														if (event.getTarget()
																.getType() == "SOPPoint"
																|| event
																		.getTarget()
																		.getType() == "SOPLineString"
																|| event
																		.getTarget()
																		.getType() == "SOPPolygon") {
															return;
														}
													}
													var searchlist = "";
													thisMap
															._setInfoLayerState();
													searchlist = vworldUtil
															.validSearchList(true);
													var zoom = vearth
															.getViewCamera()
															.getMapZoomLevel();
													if (searchlist
															.indexOf(vworldVar.bldglayer) == 0
															&& zoom < 13) {
														return;
													}
													dist = vearth
															.getViewCamera()
															.getDistance();
													buffer = Math
															.round(dist / 200);
													vworldUtil.requestSearch(
															cod.Longitude,
															cod.Latitude,
															event.x, event.y,
															'EPSG:4326',
															searchlist, null,
															null, buffer);
												});
								vearth.setPluginFocus();
								return true;
							},
							function(msg) {
								if (failCall != null)
									failCall(msg);
								vearth = null;
								if (vworldVar.maptype == "earth-first") {
									vworld.setMode(0);
								}
								vworldFunc._GetElement(vworldIDs.idmenu).style.display = vworldFunc
										._GetElement(vworldIDs.idshim).style.display = 'none';
								return false;
							});
		},
		setLockCallback : function(lockcallback, unlockcallback) {
			if (typeof (lockcallback) == 'function') {
				_lockCallBack = lockcallback;
			}
			if (typeof (unlockcallback) == 'function') {
				_unlockCallBack = unlockcallback;
			}
		},
		setModeCallback : function(callback) {
			if (typeof (callback) == 'undefined')
				return false;
			_modeCallBack = callback;
		},
		setLayerShowField : function(fieldlist) {
			if (typeof (fieldlist) == 'undefined')
				return false;
			_queryFields = [];
			for (var i = 0; i < fieldlist.length; i++) {
				var layer = fieldlist[i].layer;
				var fields = fieldlist[i].fields;
				var titles = fieldlist[i].titles;
				_queryFields.push({
					layer : layer,
					fields : fields,
					titles : titles
				});
			}
			_queryFields.getList = function(layername) {
				for (var i = 0; i < this.length; i++) {
					if (this[i].layer.toUpperCase() == layername.toUpperCase()) {
						this[i].getTitle = function(fieldname) {
							for (var j = 0; j < this.fields.length; j++) {
								if (this.fields[j].toUpperCase() == fieldname
										.toUpperCase()) {
									return this.titles[j];
								}
							}
							return null;
						};
						return this[i];
					}
				}
				return null;
			};
		},
		setLayerCallbackURL : function(callbackUrls) {
			if (typeof (callbackUrls) == 'undefined')
				return false;
			_queryCallBacks = [];
			for (var i = 0; i < callbackUrls.length; i++) {
				var layer = callbackUrls[i].layer;
				var key = callbackUrls[i].key;
				var urls = callbackUrls[i].urls;
				var wfs = callbackUrls[i].wfs;
				_queryCallBacks.push({
					layer : layer,
					key : key,
					urls : urls,
					wfs : wfs
				});
			}
			_queryCallBacks.getList = function(layername) {
				for (var i = 0; i < this.length; i++) {
					if (this[i].layer.toUpperCase() == layername.toUpperCase()) {
						return this[i];
					}
				}
				return null;
			};
		},
		_makeinvisible : function(divid, visible) {
			var visdiv = vworldFunc._GetElement(divid);
			if (visdiv == null)
				return;
			if (vworldFunc._isIE()) {
				visdiv.style.height = '100%';
				if (visible == true) {
					visdiv.style.display = 'inline-block';
					visdiv.style.visibility = 'visible';
				} else {
					visdiv.style.display = 'none';
					visdiv.style.visibility = 'hidden';
				}
			} else {
				if (visible == true) {
					visdiv.style.height = '100%';
					visdiv.style.visibility = 'visible';
					visdiv.style.display = 'inline-block';
				} else {
					visdiv.style.height = '0px';
					visdiv.style.visibility = 'hidden';
				}
			}
		},
		setMode : function(type) {
			var setModeControl = function(tmpmode) {
				vworldFunc._GetElement(vworldIDs.idmenu).style.display = vworldFunc
						._GetElement(vworldIDs.idshim).style.display = vworld.showMode ? 'inline-block'
						: 'none';
				vworldFunc._GetElement(vworldIDs.idmode[0]).style.display = (tmpmode != 0) ? 'block'
						: 'none';
				vworldFunc._GetElement(vworldIDs.idmode[1]).style.display = (vmap.vworldRaster != null && tmpmode != 1) ? 'block'
						: 'none';
				vworldFunc._GetElement(vworldIDs.idmode[2]).style.display = (vworldFunc
						._isSupport() && tmpmode != 2) ? 'block' : 'none';
				if (tmpmode == -1)
					return false;
				try {
					if (vworldFunc._GetElement(vworldIDs.idmode[tmpmode]) != null)
						vworldFunc._GetElement(vworldIDs.idmode[tmpmode]).style.display = 'none';
				} catch (e) {
				}
				vworld.viewMode = tmpmode;
				if (typeof (_modeCallBack) != "undefined") {
					try {
						_modeCallBack();
					} catch (e) {
					}
				}
			};
			var syncMode = function(type) {
				if (type == 2) {
					var bounds = vmap.getExtent();
					if ((bounds == null) || (vearth == null))
						return false;
					var mbounds = vmap.getExtent();
					var dist = m = Math.abs(mbounds.bottom - mbounds.top);
					var center2d = bounds.transform(vmap.projection,
							vmap.displayProjection).getCenterLonLat();
					vworldFunc._GetElement(vworldIDs.idmenu).style.display = vworldFunc
							._GetElement(vworldIDs.idshim).style.display = 'none';
					var vec3 = vearth.createVec3();
					vec3.Longitude = center2d.lon;
					vec3.Latitude = center2d.lat;
					vearth.getViewCamera().viewNorth();
					vearth.getViewCamera().moveDist(vec3, 88.9, 0, dist, 0);
					vworld._makeinvisible(vworldIDs.id3d, true);
					vworld._makeinvisible(vworldIDs.id2d, false);
					if (!vworldFunc._isIE()) {
						vearth.setPluginFocus();
					}
					return true;
				} else {
					if ((vearth == null)
							|| (vworldFunc._GetElement(vworldIDs.id3d).style.display == 'none' || vworldFunc
									._GetElement(vworldIDs.id3d).style.visibility == 'hidden'))
						return false;
					if (vearth.getAnalysis().getBuildLandscapeMode()) {
						vearth.getAnalysis().setBuildLandscapeMode(false);
					}
					if (vearth.getAnalysis().getGroundLandScapeMode()) {
						vearth.getAnalysis().setGroundLandScapeMode(false);
					}
					vearth.getView().setWorkMode(1);
					var tilt = parseInt(vearth.getViewCamera().getTilt());
					var bSleep = !(tilt >= 88.0 && tilt < 91);
					vearth.getViewCamera().stopCamNavigation();
					vearth.getViewCamera().viewNorth();
					vearth.getViewCamera().setTilt(88.9);
					if (bSleep)
						vworldFunc._sleep(1000);
					var dist = vearth.getViewCamera().getDistance();
					var zoom = vearth.getViewCamera().getMapZoomLevel();
					var center = vearth.getViewCamera().getCenterPoint();
					if (center == null)
						return false;
					var view_w = parseInt(vworldFunc
							._GetElement(vworldIDs.id3d).offsetWidth);
					var view_h = parseInt(vworldFunc
							._GetElement(vworldIDs.id3d).offsetHeight);
					var r = (view_h / view_w);
					var lonlat = new OpenLayers.LonLat(center.Longitude,
							center.Latitude).transform(vmap.displayProjection,
							vmap.projection);
					var m = dist;
					var h = m * 0.5;
					var extent = new OpenLayers.Bounds(lonlat.lon - m,
							lonlat.lat - h, lonlat.lon + m, lonlat.lat + h);
					var idealResolution = extent.getWidth() / view_w;
					zoom = vmap.baseLayer.getZoomForResolution(idealResolution,
							true);
					if (r > 1) {
						if (zoom < 19)
							zoom = zoom + 1;
					}
					var res = vmap.getResolutionForZoom(zoom);
					dist = res * view_h;
					vearth.getViewCamera().setDistance(dist);
					vearth.getViewCamera().moveLonLat(center.Longitude,
							center.Latitude);
					vworldFunc._sleep(1000);
					vworld._makeinvisible(vworldIDs.id2d, true);
					vworld._makeinvisible(vworldIDs.id3d, false);
					vmap.setCenterAndZoom(lonlat.lon, lonlat.lat, zoom);
					vmap.updateSize();
					return true;
				}
			};
			vworldUtil._initInfos();
			if (!vworldFunc._isSupport() && type == 2 && vworld.viewMode != 2)
				type = vworld.viewMode;
			if (vmap == null)
				return false;
			if (type == 2) {
				if (vearth == null) {
					vworld._makeinvisible(vworldIDs.id2d, false);
					vworldFunc._GetElement(vworldIDs.idmenu).style.display = vworldFunc
							._GetElement(vworldIDs.idshim).style.display = 'none';
					vworld.setupEarth(vworldIDs.idpanel, _initCallBack,
							_failCallBack);
					return false;
				}
			}
			if (type == -1) {
				setModeControl(vworld.viewMode);
				return false;
			}
			if (syncMode(type) == false && vworld.viewMode == 2) {
				setModeControl(vworld.viewMode);
				return false;
			}
			if (type == 0) {
				vmap.serverMaxlevel = 19;
				vmap.setBaseLayer(vmap.vworldBaseMap);
			} else if (type == 1) {
				vmap.serverMaxlevel = 19;
				vmap.setBaseLayer(vmap.vworldRaster);
				if (vmap.vworldHybrid != null && vmap.HybridVisibility)
					vmap.vworldHybrid.setVisibility(true);
			} else if (type == 3) {
				vmap.serverMaxlevel = vworldVers.ServerMaxLevel;
				vmap.setBaseLayer(vmap.vworldGrayMap);
			} else if (type == 4) {
				vmap.serverMaxlevel = vworldVers.ServerMaxLevel;
				vmap.setBaseLayer(vmap.vworldMidnightMap);
			}
			if (type != 2 && vworld._2dCalled == false) {
				var js = vworldFunc._CreateElement('script');
				js.setAttribute('type', "text/javascript");
				js.setAttribute('src', vworldUrls.apiCheck);
				js.setAttribute('async', false);
				document.getElementsByTagName('head')[0].appendChild(js);
				document.getElementsByTagName('head')[0].removeChild(js);
				vworld._2dCalled = true;
			}
			setModeControl(type);
			setModeControl = null;
			syncMode = null;
		},
		getMode : function() {
			return vworld.viewMode;
		},
		Lock : function() {
			vworld.isLocked = true;
			if (vworldFunc._GetElement(vworldIDs.idmenu) != null
					&& vworldFunc._GetElement(vworldIDs.idshim)) {
				vworldFunc._GetElement(vworldIDs.idmenu).style.display = vworldFunc
						._GetElement(vworldIDs.idshim).style.display = 'none';
			}
			if (typeof (_lockCallBack) == "function") {
				try {
					_lockCallBack();
				} catch (e) {
				}
			}
		},
		unLock : function() {
			vworld.isLocked = false;
			if (vworldFunc._GetElement(vworldIDs.idmenu) != null
					&& vworldFunc._GetElement(vworldIDs.idshim)) {
				vworldFunc._GetElement(vworldIDs.idmenu).style.display = vworldFunc
						._GetElement(vworldIDs.idshim).style.display = vworld.showMode ? 'inline-block'
						: 'none';
			}
			if (typeof (_unlockCallBack) == "function") {
				try {
					_unlockCallBack();
				} catch (e) {
				}
			}
		},
		is3D : function() {
			return vworld.viewMode == 2 ? true : false;
		},
		isLoaded3D : function() {
			return vearth != null ? true : false;
		},
		init : function(rootDiv, mapType, mapFunc, initCall, failCall) {
			(function() {
				var setupModeControl = function(div) {
					var conDiv = vworldFunc._GetElement(div);
					var iframeshim = vworldFunc._CreateElement('iframe');
					iframeshim.frameBorder = '0';
					iframeshim.scrolling = 'no';
					vworldIDs.idshim = OpenLayers.Util
							.createUniqueID('iframeshim');
					iframeshim.id = vworldIDs.idshim;
					iframeshim.style.position = 'absolute';
					iframeshim.style.display = 'none';
					iframeshim.style.overflow = 'hidden';
					iframeshim.style.opacity = 0;
					iframeshim.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';
					iframeshim.style.zIndex = 1000;
					iframeshim.title = '지도화면전환';
					iframeshim.src = (navigator.userAgent.indexOf('MSIE 6') >= 0) ? ''
							: '';
					vworldIDs.idmenu = OpenLayers.Util
							.createUniqueID('menu-panel');
					vworldIDs.idmode[0] = OpenLayers.Util
							.createUniqueID('menu-mode1');
					vworldIDs.idmode[1] = OpenLayers.Util
							.createUniqueID('menu-mode2');
					vworldIDs.idmode[2] = OpenLayers.Util
							.createUniqueID('menu-mode3');
					var optionsMenu = vworldFunc._CreateElement('div');
					optionsMenu.id = vworldIDs.idmenu;
					optionsMenu.style.display = 'none';
					optionsMenu.style.position = iframeshim.style.position = 'absolute';
					optionsMenu.style.left = iframeshim.style.left = 4 + 'px';
					optionsMenu.style.top = iframeshim.style.top = 4 + 'px';
					optionsMenu.style.width = iframeshim.style.width = 67 + 'px';
					optionsMenu.style.height = iframeshim.style.height = 132 + 'px';
					optionsMenu.style.overflow = 'hidden';
					optionsMenu.onmouseout = function() {
						vworldFunc._ShimResize('off');
					};
					optionsMenu.onmouseover = function() {
						vworldFunc._ShimResize('on');
					};
					optionsMenu.style.zIndex = 1001;
					optionsMenu.innerHTML += '<div class="mapmenu" id="'
							+ vworldIDs.idmode[0]
							+ '" style="display:block;"><img class="menu" src="'
							+ vworldUrl
							+ '/images/maps/view_base_wt.gif" alt="" title="2D\지도" onClick="vworld.setMode(0);"></div>';
					optionsMenu.innerHTML += '<div class="mapmenu" id="'
							+ vworldIDs.idmode[1]
							+ '" style="display:block;"><img class="menu" src="'
							+ vworldUrl
							+ '/images/maps/view_raster_wt.gif" alt="" title="2D\영상" onClick="vworld.setMode(1);"></div>';
					optionsMenu.innerHTML += '<div class="mapmenu" id="'
							+ vworldIDs.idmode[2]
							+ '" style="display:none;"><img class="menu" src="'
							+ vworldUrl
							+ '/images/maps/view_earth_wt.gif" alt="" title="3D\영상" onClick="vworld.setMode(2);"></div>';
					conDiv.appendChild(optionsMenu);
					conDiv.appendChild(iframeshim);
					vworldFunc._ShimResize('off');
				};
				if (this.isLoaded) {
					if (this.vmap != null) {
						this.vmap = null;
					}
					if (vworldIsValid != 'true') {
						var err = "[인증실패] " + vworldErrMsg + "\n";
						err += "=======================================\n";
						err += "지도서비스 사용에 제약이 있을 수 있습니다.\n";
						err += "인증키 재발급 후 다시 시도하여 주십시오.\n";
						alert(err);
					}
					if (vworld.useChart) {
						vworldFunc._loadExtLibs(vworldChartfiles, function() {
						});
					}
					vworld.isMobile = vworldFunc._isMobile();
					if (vworld.hideNotice || vworld.isMobile) {
						vworld.enums.COMMON_NOTICE = "";
						vworld.enums.COMMON_NOTICE_R = "";
					}
					vworldFunc._loadExtLibs(include2DApi, function() {
					});
					var type = 0;
					var conDiv = vworldFunc._GetElement(rootDiv);
					if (conDiv == null) {
						return;
					}
					vworldVar.maptype = mapType;
					var mapPanel = vworldFunc._CreateElement('div');
					vworldIDs.idpanel = OpenLayers.Util
							.createUniqueID('map-panel');
					mapPanel.setAttribute('id', vworldIDs.idpanel);
					mapPanel.style.cssText = "width:100%;height:100%;z-index:0;";
					var rmap = vworldFunc._CreateElement('div');
					vworldIDs.id2d = OpenLayers.Util.createUniqueID('map2d');
					rmap.setAttribute('id', vworldIDs.id2d);
					rmap.style.cssText = "display:inline-block;position:relative;width:100%;height:100%;border:0px;z-index:1;";
					mapPanel.appendChild(rmap);
					vworld._makeinvisible(vworldIDs.id2d, true);
					var loadingPanel = vworldFunc._CreateElement('div');
					vworldIDs.idloading = OpenLayers.Util
							.createUniqueID('map-load');
					loadingPanel.setAttribute('id', vworldIDs.idloading);
					loadingPanel.setAttribute('class', "olMapProgress");
					loadingPanel.style.cssText = "display:none;position:absolute;width:200px;height:40px;z-index:2;top:45%;left:35%;";
					mapPanel.appendChild(loadingPanel);
					conDiv.appendChild(mapPanel);
					this.vmap = new vworld.Maps(vworldIDs.id2d, null);
					setupModeControl(rootDiv);
					if (!vworldFunc._isSupport()) {
						if (vworldVar.maptype.indexOf('earth') == 0) {
							alert(vworld.enums.NOT_SUPPORT_NOTICE);
							vworld.viewMode = type = 0;
							vworldVar.maptype = 'map-first';
						}
					}
					mapFunc();
					_initCallBack = null;
					_failCallBack = null;
					if (vworldVar.maptype.indexOf('raster') == 0) {
						if (vmap.vworldRaster == null) {
							vworld.viewMode = type = 0;
						} else {
							vworld.viewMode = type = 1;
							vmap.vworldHybrid.setVisibility(true);
						}
					} else if (vworldVar.maptype.indexOf('gray') == 0) {
						vworld.viewMode = type = 3;
						vworld.showMode = false;
					} else if (vworldVar.maptype.indexOf('midnight') == 0) {
						vworld.viewMode = type = 4;
						vworld.showMode = false;
					}
					if (vworldVar.maptype == 'earth-base') {
						vworldVar.maptype = 'earth-only';
					}
					if ((vworldVar.maptype.slice(-5) == 'first')
							|| (vworldVar.maptype.indexOf('earth') == 0)) {
						_initCallBack = initCall;
						_failCallBack = failCall;
						if (vworldVar.maptype.indexOf('earth') == 0)
							vworld.viewMode = type = 2;
						if (vworld.viewMode == 2)
							vworld._makeinvisible(vworldIDs.id2d, false);
					}
					if (vworldVar.maptype.slice(-4) == 'only') {
						vworld.showMode = false;
					}
					vworld.setMode(type);
				} else {
					setTimeout(arguments.callee, 50);
				}
				setupModeControl = null;
			})();
		},
		CLASS_NAME : 'vworld'
	};
	vworld.enums = {
		COMMON_NOTICE : "<img src='" + vworldUrl
				+ "/images/maps/notice_aboutmap.png'>",
		COMMON_NOTICE_R : "<img src='" + vworldUrl
				+ "/images/maps/notice_aboutmap_r.png'>",
		JIJUK_VISIBLE_NOTICE : '',
		JIJUK_INVISIBLE_NOTICE : "<img src='" + vworldUrl
				+ "/images/maps/notice_aboutjijuk.png'>",
		JIJUK_INVISIBLE_NOTICE_R : "<img src='" + vworldUrl
				+ "/images/maps/notice_aboutjijuk_r.png'>",
		NOT_SUPPORT_NOTICE : '3D 플러그인은 사용하시는 브라우저를 지원하지 않습니다.\n지원일정은  브이월드 홈페이지를 참조하여 주십시오.\n사용에 불편을 드려 죄송합니다.',
		NOT_SUPPORT_MOBILE : '공간정보오픈플랫폼 지도는 모바일 브라우저에 최적화 되지 않았습니다.',
		POP_FRAME_ID : 'mappop_info',
		POP_CALLBACK_FRAME_ID : 'mappop',
		POP_CONTENT_ID : 'mappop_html'
	};
	vworld.pops = [ vworld.enums.POP_FRAME_ID,
			vworld.enums.POP_CALLBACK_FRAME_ID, vworld.enums.POP_CONTENT_ID ];
	vworldFunc._linkExtStyle(vworldUrlsExt.css);
	vworldFunc._loadExtLibs(vworldDefaultfiles, vworld.setupMap);
})();