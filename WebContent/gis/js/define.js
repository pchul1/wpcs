var $define = {};

//서버 반영시 
$define.ARC_SERVER_IP   = '210.99.81.159';
$define.ARC_SERVER_PORT = '8090/gis';

$define.ARC_SERVER_URL = 'http://'+$define.ARC_SERVER_IP+':'+$define.ARC_SERVER_PORT;


$define.ARC_SERVER_IMG_AUTO = 'eccf241e63440a4288f9f857e376f96c';
$define.ARC_SERVER_IMG_AUTO1 = 'eccf241e63440a4288f9f857e376f96c';
$define.ARC_SERVER_IMG_AUTO2 = '83e17ccb430601af2c90a6b4d6247065';
$define.ARC_SERVER_IMG_AUTO3 = '976783a2b3b260a40c0ef51e699c15f8';
$define.ARC_SERVER_IMG_AUTO4 = 'bdb91bca48f497ec8fff94f64d4475ce';
$define.ARC_SERVER_IMG_AUTO5 = '74061fd89fea3fd460a524989f96ae48';
$define.ARC_SERVER_IMG_AUTO6 = '86f1e1cf33c6d3f07906d513f7efa6c0';
$define.ARC_SERVER_IMG_AUTO7 = '4e1900d8086737cefefa04116e8a085c';

$define.ARC_SERVER_IMG_USN = 'c6a989dbbd7932557ab8a6fb665e19bf';
$define.ARC_SERVER_IMG_USN1 = 'c6a989dbbd7932557ab8a6fb665e19bf';
$define.ARC_SERVER_IMG_USN2 = 'c2d412c1a2adffb0c1ca755421da1769';
$define.ARC_SERVER_IMG_USN3 = 'f14a8d631c7935b63b57ff3947f96139';
$define.ARC_SERVER_IMG_USN4 = '6c7e4d8605c44b5ccda2e7dca1dc23ae';
$define.ARC_SERVER_IMG_USN5 = '4ae695b1f1486d7966e2af9945a8a801';
$define.ARC_SERVER_IMG_USN6 = '60c7f6f1addd55f7c862bbaa64d9baf9';
$define.ARC_SERVER_IMG_USN7 = '9dc7a1afc2fa04bfdf90b961a9a9ff9f';

$define.ARC_SERVER_IMG_TMS = '4b2374c53424183fd49dad031630b42c';
$define.ARC_SERVER_IMG_WH = '911a0e91ad91a4f557632adb91b66829';
$define.ARC_SERVER_IMG_TMPB = '6748b79e563ac69371243379ecc7e513';

//$define.API_SERVER_IP = 'localhost';
//$define.API_SERVER_PORT = '8080';
//$define.API_SERVER_URL = 'http://'+$define.API_SERVER_IP+':'+$define.API_SERVER_PORT;

//Changes XML to JSON
JSON.xmlToJson = function(xml) {
	
	// Create the return object
	var obj = {};
	
	if (xml.nodeType == 1) { // element
		// do attributes
		if (xml.attributes.length > 0) {
		obj["@attributes"] = {};
			for (var j = 0; j < xml.attributes.length; j++) {
				var attribute = xml.attributes.item(j);
				obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
			}
		}
	} else if (xml.nodeType == 3) { // text
		obj = xml.nodeValue;
	}
		
	// do children
	if (xml.hasChildNodes()) {
		for(var i = 0; i < xml.childNodes.length; i++) {
			var item = xml.childNodes.item(i);
			var nodeName = item.nodeName;
			if (typeof(obj[nodeName]) == "undefined") {
				obj[nodeName] = JSON.xmlToJson(item);
			} else {
				if (typeof(obj[nodeName].push) == "undefined") {
					var old = obj[nodeName];
					obj[nodeName] = [];
					obj[nodeName].push(old);
				}
				obj[nodeName].push(JSON.xmlToJson(item));
			}
		}
	}
	return obj;
};

