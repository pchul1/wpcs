//var apiKey= "3728760A-A99F-39F6-96C8-74746BA4A738";  //서버
var apiKey= "4EA77A23-29BC-37C9-A4EE-D3BCABCD9846";  //210.99.81.159:9090
var apiKey= "C4246B58-A669-3643-A7FD-F545A61ECE20";  //waterkorea 


var map = null;  


function vworldInit(id){
	vworld.showMode = false;
	// 통합지도 초기화
	vworld.init(
		id	// rootDiv
		, "map-first" // mapType
		,function() {         
			map = this.vmap; 
			map.setBaseLayer(map.vworldBaseMap); 
			map.setControlsType({"simpleMap":true});	//간단한 화면	
			try{
				map_start_function();
			}catch(err){}
		}
		,function (obj){SOPPlugin = obj; }//initCallback
		,function (msg){alert('vworld init fail');}//failCallback
	);
};

//화면클릭 이벤트 등록 및 마커찍기
var markerControl;

//좌표받아 마커찍기
function addMarker(lon, lat, message, imgurl){
	marker = new vworld.Marker(lon, lat,message,"");

	// 강제로 initialize 하여 제주도로 마커를 찍는 예제. 아래 줄을 주석처리하면 클릭한 위치에 마커가 찍힌다.
	//marker.initialize("14105383.450839", "3950184.1545913", "title", "description", "http://localhost/images/map2/bul_lc02_con.gif", "EPSG:900913");
	
	// 마커 아이콘 이미지 파일명 설정합니다.
	if (typeof imgurl == 'string') {marker.setIconImage(imgurl);}
	
	// 마커의 z-Index 설정
	marker.setZindex(3);
	
	map.addMarker(marker);
	return marker; 
}

function createMarker(width,height,markerName){
	//화면중심점과 레벨로 이동
	setCenterAndZoom(width, height);  	
	addMarker(width, height, markerName);
}

function setCenterAndZoom(width, height){
	map.setCenterAndZoom(width, height, 13);
}


function createMarkerNotCenter(width,height,markerName){
	//화면중심점과 레벨로 이동
	addMarker(width, height, markerName);
}


//Google -> VWorld 좌표로 변환
function GoogleToVworld(X,Y)
{
	//변환시 구글 지도와 VWORLD 지도의 위도 경도는 거꾸로
	var point = map.getTransformXY(Y,X,"EPSG:4326","EPSG:900913");
	return point;
}

//VWORLD -> GOOGLE 좌표로 변환
function VworldToGoogle(X,Y)
{
	var point = map.getTransformXY(X,Y,"EPSG:900913","EPSG:4326");
	var return_point = {};
	return_point.y = point.x;
	return_point.x = point.y;
	return return_point;
}

var operator = "-";
var operatorXY = "X";
var operator_val = 0.001;

//좌표 주소 변환
function PointToAddr(X,Y,Q,T){
	if(T == undefined) T=3;

	var _url = "";
	var _data = "";
	
	var domain = "http://210.99.81.159";
	var epsg = "EPSG:4326";
	if(T==1){
		Q = encodeURIComponent(Q);
		_url = "https://apis.vworld.kr/jibun2coord.do";
		_data = "?k=1&q="+Q+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}else if(T==2){
		Q = encodeURIComponent(Q);
		_url = "https://apis.vworld.kr/new2coord.do";
		_data = "?k=1&q="+Q+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}else if(T==3){
		_url = "https://apis.vworld.kr/coord2jibun.do";
		_data = "?k=1&x="+Y+"&y="+X+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}else if(T==4){
		_url = "https://apis.vworld.kr/coord2new.do";
		_data = "?k=1&x="+Y+"&y="+X+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}
	/**브이월드 GEOCODDING
	 * 
	 * 측정소 위치가 주로 강가에 있는데
	 * 브이월드에서 주소를 구하려 할시 데이터가 전혀 안떨어짐
	 * 그런이유로 구글api이용하여 주소값을 구함.
	 *  
	 */
	var cnt = 0;
	var mapapp = [];
	var return_method = true;
	
	$.getJSON(_url + _data +"&callback=?", function(d){
		
		$.each(d, function(k, v){
			if(v != "검색결과가 없습니다."){
				mapapp[cnt++] = v;
			}else{
				return_method = false;
			}
		});
		
		if(return_method){
			if(T == 1 || T == 2)
			{
				Pointmessage(mapapp[2],mapapp[0],mapapp[1]);
				return;
			}else{
				if(mapapp[0] != undefined) 
				{
					Pointmessage(mapapp[0]);
					return;
				}
			}
		}
		alert("주소를 직접 입력해 주세요");
		Pointmessage("");
	});
}


function PointToAddr_Onetouch(X,Y,Q,T){
	if(T == undefined) T=3;

	var _url = "";
	var _data = "";
	
	var domain = "http://210.99.81.159";
	var epsg = "EPSG:4326";
	if(T==1){
		Q = encodeURIComponent(Q);
		_url = "https://apis.vworld.kr/jibun2coord.do";
		_data = "?k=1&q="+Q+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}else if(T==2){
		Q = encodeURIComponent(Q);
		_url = "https://apis.vworld.kr/new2coord.do";
		_data = "?k=1&q="+Q+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}else if(T==3){
		_url = "https://apis.vworld.kr/coord2jibun.do";
		_data = "?k=1&x="+Y+"&y="+X+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}else if(T==4){
		_url = "https://apis.vworld.kr/coord2new.do";
		_data = "?k=1&x="+Y+"&y="+X+"&apiKey="+apiKey+"&domain="+domain+"&output=json&epsg="+epsg;
	}
	/**브이월드 GEOCODDING
	 * 
	 * 측정소 위치가 주로 강가에 있는데
	 * 브이월드에서 주소를 구하려 할시 데이터가 전혀 안떨어짐
	 * 그런이유로 구글api이용하여 주소값을 구함.
	 *  
	 */
	var cnt = 0;
	var mapapp = [];
	var return_method = true;
	
	$.getJSON(_url + _data +"&callback=?", function(d){
		
		$.each(d, function(k, v){
			if(v != "검색결과가 없습니다."){
				mapapp[cnt++] = v;
			}else{
				return_method = false;
			}
		});
		
		if(return_method){
			if(T == 1 || T == 2)
			{
				Pointmessage(mapapp[2],mapapp[0],mapapp[1]);
				return;
			}else{
				if(mapapp[0] != undefined) 
				{
					Pointmessage(mapapp[0]);
					return;
				}
			}
		}
		Pointmessage("");
	});
}