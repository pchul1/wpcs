function getAlertText(minOr){
	var txt = "";
	switch(minOr)
	{
		case "0":	//정상
			txt="정상";
			break;
		case "1" :	//관심
			txt="관심";
			break;
		case "2" :	//주의
			txt="주의";
			break;
		case "3" :	//경계
			txt="경계";
			break; 
		case "4" :	//심각
			txt="심각";
			break;
		default :
			txt="정상";
			break;
    }	
	return txt;
}

function getXmlResult(data){
	var result = {code:"", msg:""};
	var xmlData = $(data);
	node_length = xmlData.get(0).children.length;
	for ( var i = 0; i < node_length; i++) {
		node = xmlData.get(0).children.item(i);
		if(node.tagName == 'RESULT'){
			result.code = node.childNodes(0).firstChild.nodeValue;
			result.msg = node.childNodes(1).firstChild.nodeValue;
			/*
			for(var j = 0; i < node.childNodes.length; j++){
				if(node.childeNode)
			}
			*/
			break;
		}
	}
	return result;
}

function getCodeSelectBox(elm, code_gbn, emptyText, selectedOption){
	$.ajax({
		type: "POST",
		url: "../jsp/xml/code.jsp",
		data: "code_gbn="+code_gbn,	
		beforeSend : function(){
					 },				
		success : function(data){
			var result = getXmlResult(data);
			if(result.code == 'S'){
				$('#'+elm).loadSelect(data, emptyText, selectedOption);
			}else if(result.code == 'F'){
				alert(result.msg);
				return false;
			}
		},
		 error: function(data) {
			alert('에러! 상태 = ' + data.status);
		 }
	});
}

function setloadSelect(elm,data,emptyText,emptyVal,selectedOption){
	var obj = $("#"+elm);
	obj.find("option").remove();
	
	if (emptyText.toString() != "") {
		obj.append("<OPTION value='"+emptyVal+"'>" + emptyText +"</OPTION>");
	}
	
	//옵션을 위한 데이터
	for ( var i = 0; i < data.length; i++) {
		value = data[i].value;
		name = data[i].name;

		if (value != "") {
			obj.append("<OPTION value='" + value +"'>" + name +"</OPTION>");  
		}
	}
}

function CommonSelectBox(code_name, elm, code_gbn, sys, emptyText, emptyVal, selectedOption){
	var _url;
	var _data = "code_gbn="+code_gbn+"&sys="+sys;
	switch(code_name){
		case "sys":
			_url = "/mobile/common/system.do";
			break;
		case "branch":
			_url = "/mobile/common/branch.do";
			break;
		case "sugye":
			_url = "/mobile/common/sugye.do";
			break;
		case "codelist":
			_url = "/mobile/common/codelist.do";
			break;
		case "sido":
			_url = "/mobile/common/getSido.do";
			break;	
		case "sigungu":
			_url = "/mobile/common/getSigungu.do";
			break;	
		case "Warehouse":
			_url = "/mobile/common/getWarehouse.do";
			break;	
	}

	$.ajax({
		type: "POST",
		url: _url,
		data: _data,
		dataType: 'json',  
		beforeSend : function(){
					 },				
		success : function(data){
			var result = data["Result"];
			if(result[0] == 'S'){
				setloadSelect(elm,data["List"],emptyText,emptyVal, selectedOption);
			}else if(result.code == 'F'){
				alert(result[1]);
				return false;
			}
		},
		 error: function(data) {
			alert('에러! 상태 = ' + data.status);
		 }
	});
}

function vailidation(obj,message){
	if($(obj).val() =="")
	{
		alert(message);
		$(obj).focus();
		return false;
	}
		
	return true;
}


var browser = (function() {
	  var s = navigator.userAgent.toLowerCase();
	  var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
	              /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
	              /(msie) ([\w.]+)/.exec(s) ||               
	              /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
	             [];
	  return { name: match[1] || "", version: match[2] || "0" };
	}());

(function($) {

	
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		dateFormat: 'yy/mm/dd'
	});
	
	//SELECT OPTION 삭제
	$.fn.emptySelect = function() {
		return this.each(function(){
		if (this.tagName=='SELECT') this.options.length = 0;
		});
	};
	
	//SELECT OPTION 등록
	$.fn.loadSelect = function(optionsDataArray) {
		
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				$.each(optionsDataArray,function(idx, optionData){
					
					var option;
					
					if(optionData.CAPTION != undefined)
						option= new Option(optionData.CAPTION, optionData.VALUE);
					else
						option = new Option(optionData.caption, optionData.value);
					
					if(browser.name == 'msie') {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
				});
			}
		});
	};
	
	//SELECT OPTION 등록 - 전체 포함
	$.fn.loadSelect_all = function(optionsDataArray) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				var first = new Option('전체', 'all');
				
				if(browser.name == 'msie')
					selectElement.add(first);
				else
					selectElement.add(first);
				
				$.each(optionsDataArray,function(idx, optionData){
					var option = new Option(optionData.CAPTION, optionData.VALUE);
					
					if(browser.name == 'msie') {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
				});
			}
		});
	};
	
	//SELECT OPTION 등록 (공통코드용)
	$.fn.loadSelectDepth = function(optionsDataArray) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
			var selectElement = this;
			$.each(optionsDataArray,function(idx, optionData){
				var option = new Option(optionData.codeName, optionData.code);
				var first = new Option('선택', '');
				if(browser.name == 'msie') {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option);
					} else {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option,null);
					}
				});
			
			}
		 });
		};
	
	//SELECT OPTION 등록 (부서용)
	$.fn.loadSelectDepth2 = function(optionsDataArray) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
			var selectElement = this;
			$.each(optionsDataArray,function(idx, optionData){
				var option = new Option(optionData.deptName, optionData.deptNo);
				var first = new Option('선택', '');
				if(browser.name == 'msie') {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option);
					} else {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option,null);
					}
				});
			}
		});
	};
	
	//SELECT OPTION 등록 (창고용)
	$.fn.loadSelectWareHouse = function(optionsDataArray, firstLabel, value, label, value2) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				var option = null;
				$.each(optionsDataArray,function(idx, optionData){
					if (value2 != null) {
						option = new Option(optionData[label], optionData[value]+"_"+optionData[value2]);
					} else {
						option = new Option(optionData[label], optionData[value]);
					}
					var first = new Option(firstLabel, '');
					if(browser.name == 'msie') {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option);
					} else {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option,null);
					}
				});
			}
		});
	};
	
	//SELECT OPTION 등록 (공통용-최초값까지 지정)
	$.fn.loadSelectCmn = function(optionsDataArray, firstLabel, value, label) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				var option = null;
				$.each(optionsDataArray,function(idx, optionData){
					option = new Option(optionData[label], optionData[value]);
					
					var first = new Option(firstLabel, 'all');
					if(browser.name == 'msie') {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option);
					} else {
						if(idx == 0){selectElement.add(first);}
						selectElement.add(option,null);
					}
				});
			}
		});
	};
	
	//SELECT OPTION 삭제 (사전조치 통보용)
	$.fn.emptySelect2 = function() {
		return this.each(function(){
			if (this.tagName=='SELECT') this.options.length = 0;
		});
	};
		
	//SELECT OPTION 등록 (사전조치 통보용)
	$.fn.loadSelect2 = function(optionsDataArray) {
	 return this.emptySelect2().each(function(){
		if (this.tagName=='SELECT') {
			var selectElement = this;
			if(optionsDataArray.length == 0 || optionsDataArray.length == undefined) {
				var first = new Option('전체', 'all');
				
				if(browser.name == 'msie') {
					selectElement.add(first);
				}
				else {
					selectElement.add(first);
				}
			} else {
				$.each(optionsDataArray,function(idx, optionData){
					var option = new Option(optionData.CAPTION, optionData.VALUE);
					
					var first = new Option('전체', 'all');
					
					if(browser.name == 'msie') {
						if(idx == 0) { selectElement.add(first);}
						selectElement.add(option);
					}
					else {
						if(idx == 0) { selectElement.add(first);}
						selectElement.add(option,null);
					}
				});
			}
		}
	});
	};
	
	//SELECT OPTION 등록
	$.fn.loadSelectDepth_factdetail = function(optionsDataArray, sys) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				$.each(optionsDataArray,function(idx, optionData){
					
					if(sys != "A")
						optionData.VALUE = optionData.VALUE + "00";
					
					var option = new Option(optionData.CAPTION, optionData.VALUE);
					//var first = new Option(TITLE, 'all');
					if(browser.name == 'msie') {
						//if(idx == 0){selectElement.add(first);}
					
						selectElement.add(option);
					}
					else {
						//if(idx == 0){selectElement.add(first);}
						selectElement.add(option,null);
					}
				});
			}
		});
	};
	
})(jQuery);