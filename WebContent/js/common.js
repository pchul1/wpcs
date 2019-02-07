var newbrowser = (function() {
	if(window.console == undefined){
		window.console = {log:function(){}};
	}
  var s = navigator.userAgent.toLowerCase();
  var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
              /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
              /(msie) ([\w.]+)/.exec(s) ||               
              /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
             [];
  return { name: match[1] || "", version: match[2] || "0" };
}());
 


var ROOT_PATH = '/';

function pageLoding(){
	
	/*shows the loading div every time we have an Ajax call*/
	$("#loadingDiv").bind("ajaxSend",function(){
		showLoading();
		}).bind("ajaxComplete", function(){ 
		closeLoading();
	});
}

function showLoading(){
	$("#loadingDiv").dialog({
		modal:true,
		open:function() 
		{
			$("#loadingDiv").css("visibility","visible");
			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
			$(this).parents(".ui-dialog:first").css("width", "85px");
			$(this).parents(".ui-dialog:first").css("height", "75px");
			$(this).parents(".ui-dialog:first").css("overflow", "hidden");
			$("#loadingDiv").css("float", "left");
		},
		width:0,
		height:0,
		showCaption:false,
		resizable:false
	}); 
	$("#loadingDiv").dialog("open");
}

function closeLoading(){
	$("#loadingDiv").dialog("close");
}

// 페이지 네비게이션 만들기
function makePaginationInfo(result){
	var str = "";
	/*
	<li><a href="">이전...</a></li>
	<li><em>1</em></li>
	<li><a href="">2</a></li>
	<li><a href="">...다음</a></li>
	*/
	if (result.currentPageNo > result.pageSize) {
		str += "<li><a style='cursor:pointer' onclick=\"linkPage('"+result.firstPageNo+"')\">[처음]</a></li>";
		str += "<li><a style='cursor:pointer' onclick=\"linkPage('"+(result.firstPageNoOnPageList-1)+"')\">[이전]</a></li>";
	}
	
	var idx = 0;
	for(var i=result.firstPageNoOnPageList; i <= result.lastPageNoOnPageList; i++) {
		if (result.currentPageNo == i) {
			str += "<li><em>"+i+"</em></li>";
		} else {
			str += "<li><a style='cursor:pointer' onclick=\"linkPage('"+i+"')\">"+i+"</a></li>";
		}
		idx++;
	}
	
	if (result.currentPageNo < result.lastPageNo && idx == result.pageSize && result.pageSize < result.lastPageNo) {
		str += "<li><a style='cursor:pointer' onclick=\"linkPage('"+(result.lastPageNoOnPageList+1)+"')\">[다음]</a></li>";
		str += "<li><a style='cursor:pointer' onclick=\"linkPage('"+result.lastPageNo+"')\">[마지막]</a></li>";
	}
	
	return str;
}

//숫자만 입력 가능 (onKeyDown 이벤트) 
function onlyNumberInput(){
	var code = window.event.keyCode;
	
	if( !event.ctrlKey && !event.shiftKey){
		if ((code > 47 && code < 58) || (code > 95 && code < 106) || code == 8 || code == 9 || code == 13 || code == 46) {
			window.event.returnValue = true;
			return;
		}
	}
	
	window.event.returnValue = false;
}

function onlyAlNumberInput(){
	var code = window.event.keyCode;
	
	if( !event.ctrlKey && (64 < code && code < 91) || (140 < code && code < 173) || (35 < code && code < 40) || code == 8 || code == 9 || code == 13 || code == 46 ){
		window.event.returnValue = true;
		return; 
	}else if(!event.shiftKey){
		if( 47 < code && code < 58 ){
			window.event.returnValue = true;
			return;
		}
	}
	
	window.event.returnValue = false;
}

//문자열 길이제한 
function ChkByte(objname,maxlength) {
	var objstr = objname.value; // 입력된 문자열을 담을 변수 
	var objstrlen = objstr.length; // 전체길이 
	
	// 변수초기화 
	var maxlen = maxlength; // 제한할 글자수 최대크기 
	var i = 0; // for문에 사용 
	var bytesize = 0; // 바이트크기 
	var strlen = 0; // 입력된 문자열의 크기
	var onechar = ""; // char단위로 추출시 필요한 변수 
	var objstr2 = ""; // 허용된 글자수까지만 포함한 최종문자열
	
	// 입력된 문자열의 총바이트수 구하기
	for(i=0; i< objstrlen; i++) { 
		// 한글자추출 
		onechar = objstr.charAt(i); 
		
		if (escape(onechar).length > 4) { 
			bytesize += 2;	 // 한글이면 2를 더한다. 
		} else {
			bytesize++;	// 그밗의 경우는 1을 더한다.
		} 
		
		if(bytesize <= maxlen) {	// 전체 크기가 maxlen를 넘지않으면 
			strlen = i + 1;	 // 1씩 증가
		}
	}
	
	// 총바이트수가 허용된 문자열의 최대값을 초과하면 
	if(bytesize > maxlen) { 
		objstr2 = objstr.substr(0, strlen); 
		objname.value = objstr2; 
	}
	
}

function nextTab(obj, nextObj)
{
	str = obj.value;
	
	if(obj.maxLength == str.length)
	{
		nextObj.focus();
	}
}

//공구 목록 가져오기
function adjustGongkuDropDown2(all, init)
{
	var system = "";
	if($('#system').val() == undefined) {
		system = "all";
	} else {
		system = $('#system').val();
	}
	
	var sugyeCd = $('#sugye').val();
	var dropDownSet = $('#factCode');
	
	dropDownSet.attr("style", "background:#ffffff;");
	
	if( sugyeCd == 'all' ){
		dropDownSet.attr("disabled", true);
		dropDownSet.emptySelect();
	}else{
		dropDownSet.attr("disabled", false);
		$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
			if(status == 'success'){
				//locId 객체에 SELECT 옵션내용 추가.
				if(all == true){
					dropDownSet.loadSelect_all(data.gongku);
				}
				else {
					dropDownSet.loadSelect(data.gongku);
//					console.log("data.gongku : ",data.gongku);
//					console.log("data.gongku.length : ",data.gongku.length);
					if (data.gongku.length == 1) {
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
						//2014-10-29 mypark 검색 개선
						dropDownSet.hide();
					}
				}
				
				if(init != null && init == true)
				{
					if(typeof(init) == "function") {
						init();
					}
				}
				else
				{
					if(typeof(adjustBranchDropDown) == "function") {
						adjustBranchDropDown();
					} else if(typeof(init) == "function") {
						init();
					}
				}
			} else {
				 alert("공구 목록 가져오기 실패");
				return;
			}
		});
	}
}

//비교 공구 목록 가져오기
function adjustGongkuDropDown2_2(all, init)
{		
	var system = "";
	if($('#system').val() == undefined) {
		system = "all";
	} else {
		system = $('#system').val();
	}
	
	var sugyeCd = $('#sugye2').val();
	var dropDownSet = $('#factCode2');
	
	if( sugyeCd == 'all' ){
		dropDownSet.attr("disabled", true);
		dropDownSet.emptySelect();
	}else{
		dropDownSet.attr("disabled", false);
		$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
			if(status == 'success'){	 
				//locId 객체에 SELECT 옵션내용 추가.
				if(all == true){
					dropDownSet.loadSelect_all(data.gongku);
				}else{
					dropDownSet.loadSelect(data.gongku);
				}
				
				if(init != null && init == true)
				{
					init();
				}
				else
				{
					if(typeof(adjustBranchDropDown) == "function") {
						adjustBranchDropDown_2();
					} else if(typeof(init) == "function") {
						init();
					}
				}
			} else { 
				 alert("공구 목록 가져오기 실패");
				return;
			}
		});
	}
}


// 공구 목록 가져오기
function adjustGongkuDropDown(all)
{		
	var system = "";
	if($('input[name=system]:checked').val() == undefined) {
		system = "all";
	} else {
		system = $('input[name=system]:checked').val();
	}
	
	var sugyeCd = $('#sugye').val();
	var dropDownSet = $('#factCode');
	
	if( sugyeCd == 'all' ){
		dropDownSet.attr("disabled", true);
		dropDownSet.emptySelect();
	}else{
		dropDownSet.attr("disabled", false);
		$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getGongkuList.do", {system:system, sugye:sugyeCd}, function (data, status){
			if(status == 'success'){	 
				//locId 객체에 SELECT 옵션내용 추가.
				if(all == true)
					dropDownSet.loadSelect_all(data.gongku);
				else
					dropDownSet.loadSelect(data.gongku);
				
				if(typeof(adjustBranchDropDown) == "function") {
					adjustBranchDropDown();
				} else if(typeof(init) == "function") {
					init();
				}
			} else { 
				 alert("공구 목록 가져오기 실패");
				return;
			}
		});
	}
}

//측정소 목록 가져오기
function adjustBranchDropDown(all)
{
	var factCode = $('#factCode').val();
	var dropDownSet = $('#branchNo');
	
	dropDownSet.attr("style", "background:#ffffff;");
	
	if( factCode == 'all' ){
		dropDownSet.attr("style", "background:#e9e9e9;");
		dropDownSet.attr("disabled", true);
		dropDownSet.emptySelect();
		$("#branchNo").append("<option value='all'>전체</option>");
	}else{
		dropDownSet.attr("disabled", false);
		$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
			if(status == 'success'){
				//locId 객체에 SELECT 옵션내용 추가.
				if(all == true)
					dropDownSet.loadSelect_all(data.branch);
				else
					dropDownSet.loadSelect(data.branch);
				
				if(typeof(adjustItemList) == "function") {
					adjustItemList();
				} else if(typeof(init) == "function") {
					init();
				}
			} else {
				alert("공구 목록 가져오기 실패");
				return;
			}
			
			//2014-10-28 mypark 검색 개선
			if($('#system').val() == 'all' || $('#system').val() == 'U') {
				$('#factCode').hide();
				$('#branchNo').show();
			} else {
				$('#factCode').show();
				$('#branchNo').hide();
			}
		});
	}
}


//비교 측정소 목록 가져오기
function adjustBranchDropDown_2(all)
{
	var factCode = $('#factCode2').val();
	var dropDownSet = $('#branchNo2');
	
	if( factCode == 'all' ){
		dropDownSet.attr("disabled", true);
		dropDownSet.emptySelect();
	}else{
		dropDownSet.attr("disabled", false);
		$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/getBranchList.do", {factCode:factCode}, function (data, status){
			if(status == 'success'){
				//locId 객체에 SELECT 옵션내용 추가.
				
				if(all == true){
					dropDownSet.loadSelect_all(data.branch);
				}else{
					dropDownSet.loadSelect(data.branch);
					dropDownSet.find('option:eq(1)').attr('selected','selected');
				}
				
				if(typeof(adjustItemList) == "function") {
					adjustItemList();
				} else if(typeof(init) == "function") {
					init();
				}
			} else {
				 alert("공구 목록 가져오기 실패");
				return;
			}
		});
	}
}

///동적 SELECTBOX 구현을 위한 사용자 함수
(function($) {
	
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
					
					if (newbrowser.name=="msie") {
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
				
				if (newbrowser.name=="msie") 
					selectElement.add(first);
				else
					selectElement.add(first);
				
				$.each(optionsDataArray,function(idx, optionData){
					var option = new Option(optionData.CAPTION, optionData.VALUE);
					
					if (newbrowser.name=="msie") {
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
				if (newbrowser.name=="msie") { 
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
				if (newbrowser.name=="msie") {
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
					if (newbrowser.name=="msie") {
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
					if (newbrowser.name=="msie") {
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
				
				if (newbrowser.name=="msie") {
					selectElement.add(first);
				}
				else {
					selectElement.add(first);
				}
			} else {
				$.each(optionsDataArray,function(idx, optionData){
					var option = new Option(optionData.CAPTION, optionData.VALUE);
					
					var first = new Option('전체', 'all');
					
					if (newbrowser.name=="msie") {
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
					if (newbrowser.name=="msie") {
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

//조직 목록 가져오기
function getGroupList()
{	
	var system = $('input[name=system]:checked').val();
	var sugye = $('#sugye').val();
	var factCode = $('#factCode').val();
	var branchNo = $('#branchNo').val();
	
	var dropDownSet = $('#group');
	
	var html = "";
	$('#groupDiv').html("");
	
	dropDownSet.attr("disabled", false);
	$.getJSON(ROOT_PATH+"alert/getGroupList.do", {system:system, sugye:sugye, factCode:factCode, branchNo:branchNo}, function (data, status){
		if(status == 'success'){
			html += "<div id='sidetreecontrol'><a href='?#'>전체닫기</a> | <a href='?#'>전체열기</a></div>";									
			html += "<ul id='test' class='filetree'><li><p class='folder'><input type='checkbox' id='checkA' onclick='checkAll()' value='전체' /><label for=''>전체</label></p><ul>";
			
			var groupList = data.groupList;
			
			var preType = "";
			var brChk = 0;
			var checkId = "";
			
			for(var i=0; i<groupList.length; i++) {
				if(i == 0 ) {
					html += "<li>";
				}
				if(groupList[i].ORDER_TYPE == "1") {
					if(preType == "2") {
						html += "</ul></li><li>";
					}
					
					html += "<p class='folder'><input type='checkbox' name='groupId' class='inputCheck' value='A"+groupList[i].KEY+"' onclick='chkMember(this, \"A"+groupList[i].KEY+"\")' /> <label for=''>"+groupList[i].CAPTION+"</label></p>";
					checkId = "A"+groupList[i].KEY;
					brChk++;
				} else {
					if(preType == "1") {
						html += "<ul id='"+checkId+"' class='person'>";
					}
					
					html += "<li><input type='checkbox' name='memberId' class='inputCheck' value='"+groupList[i].KEY+"' /> <label for=''>"+groupList[i].CAPTION+"</label></li>";
				}
				
				preType = groupList[i].ORDER_TYPE;
/*
				<li>
				<div class="list">
					<p><input type="checkbox" id="" class="inputCheck" /> <label for="">한국환경공단 &gt; 상황팀</label></p>
					<ul class="person">
					<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈공명</label></li>
					<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈공</label></li>
					<li><input type="checkbox" id="" class="inputCheck" /> <label for="">제갈명</label></li>
					</ul>
				</div>
				<div class="list">
					<p><input type="checkbox" id="" class="inputCheck" /> <label for="">한국환경공단 &gt; 상황팀</label></p>
				</div>
			</li>	 

*/
				//$('#groupDiv').append("<li><input type='checkbox' name='group' value='"+groupList[i].VALUE+"' /><label for=''>"+groupList[i].CAPTION+"</label></li>")
			}
			
			html += "</ul></li></ul></li></ul>";
			$('#groupDiv').append(html);
			
			$("#groupDiv").treeview({
				collapsed: true,
				animated: "medium",
				control:"#sidetreecontrol",
				persist: "location"
			});
			
			//alert($('#groupDiv').html());
		} else { 
			 alert("공구 목록 가져오기 실패");
			return;
		}
	});		
}

function replaceAll(ostr, str1, str2)
{
	return ostr.split(str1).join(str2);
}

// 날짜 2자리 채우기 스크립트.
function addzero(n) {
	 return n < 10 ? "0" + n : n + "";
}

// 달력 스크립트
try{
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		dateFormat: 'yymmdd',
		showOn: 'both',
		buttonImage: ROOT_PATH+'images/common/ico_calendar.gif',
		buttonImageOnly: true
	});
}catch(err){}

//달력에서 선택된 일에서 "/"를 제외하고 리턴합니다.
$.fn.val2 = function()
{
	var ostr = this.val();
	
	return replaceAll(ostr, "/" , "");
};

//undefined 를 공백으로 치환한다.
function nullToString(str) {
	if(str == undefined)
		return '';
	else 
		return str;
}

// 해당 폼을 클리어한다.
$.fn.clearForm = function() {
	return this.each(function() {
		var type = this.type, tag = this.tagName.toLowerCase();
		if (tag == 'form')
			return $(':input',this).clearForm();
		if (type == 'text' || type == 'password' || tag == 'textarea' || tag == 'hidden')
			this.value = '';
		else if (type == 'checkbox' || type == 'radio')
			this.checked = false;
		else if (tag == 'select')
			this.selectedIndex = 0;
	});
};

// 날씨관련 이미지 리턴
function getWeatherImg(code) {
	var src = ROOT_PATH+'images/content/';
	switch(code) {
		case "맑음" : 
			src += "NB01.png";
			break;
		case "구름조금" :
			src += "NB02.png";
			break;
		case "소나기 끝":
		case "구름많음" :
			src += "NB03.png";
			break;
		case "진눈개비끝" :
		case "눈 끝남" :
		case "비 끝남" : 
		case "흐림" :
			src += "NB04.png";
			break;
		case "소나기" :
			src += "NB05.png";
			break;
		case "뇌우끝,비" :
		case "약한비단속" :
		case "약한비계속" :
		case "보통비계속" :
		case "보통비단속" :
		case "구름조금 비":
		case "구름많음 비":
		case "약한이슬비":
		case "보통이슬비":
		case "보통소나기":
		case "약한소나기":
		case "이슬비 끝":
		case "흐림 비":
		case "비":
			src += "NB08.png";
			break;
		case "약한눈단속":
		case "약한눈계속":
		case "보통눈계속":
		case "보통눈단속":
		case "구름조금 눈":
		case "구름많음 눈":
		case "흐림 눈":
		case "눈":
			src += "NB11.png";
			break;
		case "약진눈개비":
		case "강진눈개비":
		case "구름조금 비/눈":
		case "구름많음 비/눈":
		case "흐림 비/눈":
		case "비 또는 눈":
			src += "NB12.png";
			break;
		case "눈 또는 비":
			src += "NB13.png";
			break;
		case "뇌우":
		case "천둥번개":
			src += "NB14.png";
			break;
		case "안개강해짐":
		case "안개변화무":
		case "안개 끝":
		case "안개":
			src += "NB15.png";
			break;
		case "박무":
			src += "NB17.png";
			break;
		case "황사":
			src += "NB16.png";
			break;
		case "안개엷어짐":
		case "연무":
			src += "NB18.png";
			break;
		default:
			src += "NB01_N.png";
			break;
		}
	return src;
}

// 날짜형식의 문자열을 리턴
function getDateYYYYMMDDHHMI(ymd) {
	//var yy, mm, dd;
	var y = "";
	var m = "";
	var d = "";
	var h = "";
	var i = "";
	
	y = ymd.substring(0, 4);
	m = ymd.substring(4, 6);
	d = ymd.substring(6, 8);
	h = ymd.substring(8, 10);
	i = ymd.substring(10, 12);
	
	return y+'.'+m+'.'+d+' '+h+':'+i;
}

// inputbox 숫자만 입력가능( [.]입력가능) (onkeypress)
function inputNumCheck() {
	if((event.keyCode < 48 || event.keyCode > 57) && event.keyCode != 46)
		event.returnValue = false;
}

//숫자 3단위 마다 콤마
function comma(str) {
	str = new String(str);
	this.str = str;
	len = str.length;
	str1 = "";

	for(var i=1; i<=len; i++) {
		str1 = str.charAt(len-i)+str1;
	if((i%3 == 0)&&(len-i != 0)) str1 = ","+str1;
	}
	return str1;
}

// 콤마찍기
function trans_Num(){
	var result="";
	str=this.value;
	
	re=/[^0-9]/gi;
	str=str.replace(re,"");
	this.value= str;
	var len=str.length;
	for(i=len-1,j=0;i>=0;i--) {
		result=str.substring(i,i+1)+result;
		j++;
		if(j==3 && i!=0){
			result=","+result;
			j=0;
		}
	}
	this.value = result;
}

//콤마제거
function unNumberFormat(num) {
	return (num.replace(/\,/g,""));
}


var Request = function()
{
	this.getParameter = function( name )
	{
		var rtnval = '';
		var nowAddress = unescape(location.href);
		var parameters = (nowAddress.slice(nowAddress.indexOf('?')+1,nowAddress.length)).split('&');

		for(var i = 0 ; i < parameters.length ; i++)
		{
			var varName = parameters[i].split('=')[0];
			if(varName.toUpperCase() == name.toUpperCase())
			{
				rtnval = parameters[i].split('=')[1];
				break;
			}
		}
		return rtnval;
	}
}

var request = new Request();

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();
	
	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}

//시스템명 확인
function sysKindName(str) {
	switch(str) {
		case "A" : 
			str = "국가수질자동측정망";
			break;
//		case "T" :
//			str = "탁수모니터링";
//			break;
		case "U" :
			str = "IP-USN";
			break;
		case "W" :
			str = "방류수질정보";
			break;
	}
	return str;
}

//입력값에 따른 시스템 확인 
function sysKindIni(str) {
	
	if (str.indexOf("국가수질자동측정망") > -1)
		str = "A";
//	else if (str.indexOf("탁수모니터링") > -1)
//		str = "T";
	else if (str.indexOf("USN") > -1)
		str = "U";
	else if (str.indexOf("IP-USN") > -1)
		str = "U";
	else if (str.indexOf("방류수질정보") > -1)
		str = "W";
	
	return str;
}

function detContentName(str) {
	switch(str) {
		case "100" : 
			str = "데이터미수신";
			break;
		case "200" :
			str = "이상데이터";
			break;
		case "300" :
			str = "위치이탈";
			break;
	}
	return str;
}

//로그인 member 별로 수계 고정 함수
function selectedSugyeInMemberId(userRiverId , sugyeName){
	
	//console.log("user_riverid : ", userRiverId );
	var isNull = false;
	var riverDept = '';
	
	switch(userRiverId)
	{
	case "R01":
		riverDept = "R01";
		break;
	case "R02":
		riverDept = "R02";
		break;
	case "R03":
		riverDept = "R03";
		break;
	case "R04":
		riverDept = "R04";
		break;
	default :
		//Null이거나 속하지않으면 전체 표시
		isNull = true;
	}

	if(!isNull)
	{
		$("#"+sugyeName+" > option[value="+riverDept+"]").attr("selected", "true");
		$("#" +sugyeName).attr("disabled", "disabled");
	}
}

//user deptNo에 따른 수계 고정
function set_User_deptNo(userDeptNo, sugyeName){
	
	var riverDept = "";
	var isNull = false;
	
	switch(userDeptNo)
	{
	case "1002":
		riverDept = "R01";
		break;
	case "1004":
		riverDept = "R02";
		break;
	case "1003":
		riverDept = "R03";
		break;
	case "1005":
		riverDept = "R04";
		break;
	default :
		//Null이거나 속하지않으면 전체 표시
		isNull = true;
	}
	
	if(!isNull)
	{
		$("#"+sugyeName+" > option[value="+riverDept+"]").attr("selected", "true");
		$("#" +sugyeName).attr("disabled", "disabled");
	}
}

//모바일 웹용 보고서 출력
function OpenWindows(nLink, nTarget, nWidth, nHeight, xPos, yPos) {
	if(typeof nLink == "object") url = nLink.href;
	else url = nLink;

	adjX = xPos ? xPos : (window.screen.width/2 - nWidth/2);
	adjY = yPos ? yPos : (window.screen.height/2 - nHeight/2 - 50);
	var qResult = window.open( url, nTarget, "width="+nWidth+", height="+nHeight+",left="+adjX+",top="+adjY+",toolbar=no,status=yes,scrollbars=1,resizable=no");
	//return qResult;
	//http://m.waterkorea.or.kr/mrd/report.jsp?id=121&no=01&ek=36140ce80c8083352238d7f3ec51c735
}

//모바일 웹용 버튼 confirm
function BtnConfirmGo(obj, url) {
	var msg;
	if(typeof obj == "object") msg = obj.value;
	else msg = obj;
	if(confirm(msg + "하시겠습니까?")) {
		location.href = url;
	}
}

//슬릭그리드 사용시 view 사이즈 설정
//$.fn.sGridCmn = function(headerLine, obj, pageLine, rowHeight) {
function sGridCmn(headerLine, obj, pageLine, rowHeight){
	if (obj.length < pageLine){
		if (rowHeight == null || rowHeight == ""){
			return (26 * headerLine) - (1 * headerLine - 1) + (26 * obj.length) + 1;
		}else{
			return (26 * headerLine) - (1 * headerLine - 1) + (26 * obj.length) + 1 + ((rowHeight - 25) * obj.length);
		}
	} else {
		if (rowHeight == null || rowHeight == ""){
			return (26 * headerLine) - (1 * headerLine - 1) + (26 * pageLine) + 1;
		}else{
			return (26 * headerLine) - (1 * headerLine - 1) + (26 * pageLine) + 1 + ((rowHeight - 25) * pageLine);
		}
	}
}

/* 레이어팝업 열기 */
function layerPopOpen(name) {
	layerPopCloseAll();
	
	$("#layerFullBgDiv").show();
	
	var win = $(window);
	var winH = win.scrollTop() + ((win.height() - $('#'+ name).height()) / 2);
	var winW = win.scrollLeft() + ((win.width() - $('#'+ name).width()) / 2);
	$('#'+ name).css('top', winH);
	$('#'+ name).css('left', winW);
	$('#'+ name).show();
	$('#'+ name).focus();
}

/* 레이어 팝업 닫기 */
function layerPopClose(name){
//	var pop = document.getElementById(name);
//	pop.style.display = "none";
	
	$("#"+name).hide();
	
	$("#layerFullBgDiv").hide();
}

/* 테이블 스크롤 */
function scrollAll() {
	document.all.top_display.scrollLeft = document.all.main_display.scrollLeft;
//		document.all.top_display.scrollTop = document.all.main_display.scrollTop;
}

//gnb
function gnbMenu(objNum) {
	var _d = document,
		outEventTime = 3, //본 레이어로 돌아가는 시간
		objID = _d.getElementById('navG'),
		objUl = objID.getElementsByTagName('ul'),
		objUlLength = objUl.length,
		objList = [],
		objImage = [],
		currentNum = 0,
		objSetTime;

	var initialize = function() {
		
		//objUl[0].style.display = 'none';
		objUl[1].style.display = 'none';
		objUl[2].style.display = 'none';
		objUl[3].style.display = 'none';
		objUl[4].style.display = 'none';
		objUl[5].style.display = 'none';
		

		for (var i=0; i<objUlLength; i++) {
			//if (objNum == 'null') objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu.gif)';
			if (i != 0) {
				objList[i] = objUl[i].parentNode;

				objImage[i] = objList[i].getElementsByTagName('img')[0];
				//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu.gif)';
				objEvent(i);
			}
		}

		
		if (objNum >= 0) {
			objNum = objNum + 1;
			objImage[objNum].src = objImage[objNum].src.replace('.gif', '_on.gif');
			objUl[objNum].style.display = 'block';
			
		}
		
	};

	var objEvent = function(num) {
		objList[num].onmouseover = function() {
			currentNum = num;
			clearTimeout(objSetTime);
			for (var i=0; i<objUlLength; i++) {
				if (i != 0) {
					if (i == num) {
						//Do nothing
					} else {
						objImage[i].src = objImage[i].src.replace('_on.gif', '.gif');
						objUl[i].style.display = 'none';
						//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu_on.gif)';
					}
				}
			}

			if (objImage[num].src.indexOf('_on.gif') == -1)
				objImage[num].src = objImage[num].src.replace('.gif', '_on.gif');

				
			objUl[num].style.display = 'block';

		};

//		objList[num].onmouseout = function() {				
//			objUl[num].style.display = 'none';
//		};

		objList[num].onkeyup = objList[num].onmouseover;

		objID.onmouseout = function(e) {
			var evt = e || window.event;
			var relatedNode = evt.relatedTarget || evt.toElement;

			//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu.gif)';

			if (currentNum !=6)
			{
				objUl[num].style.display = 'none';
			}

			searchOutNode(relatedNode, this);

		};
	};

	var outEvent = function() {

		if (currentNum !=0)
		{
			if (!objNum) {
				objImage[currentNum].src = objImage[currentNum].src.replace('_on.gif', '.gif');
				objUl[currentNum].style.display = 'none';

				//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu_on.gif)';
			} else if (objNum && currentNum != objNum) {
				if (objImage[objNum].src.indexOf('_on.gif') == -1)
					objImage[objNum].src = objImage[objNum].src.replace('.gif', '_on.gif');
					objUl[objNum].style.display = 'block';
				

				objImage[currentNum].src = objImage[currentNum].src.replace('_on.gif', '.gif');
				objUl[currentNum].style.display = 'none';
				//objID.style.backgroundImage = 'url(/open_content/images/main/bg_topmenu_on.gif)';
			}
		}
	};

	var searchOutNode = function (obj1, obj2) { //이벤트 버블링현상 제거
		while (obj1 != obj2) {
			if (!obj1) {
				objSetTime = setTimeout(outEvent, (outEventTime * 10));
				return true;
			}
			obj1 = obj1.parentNode;
		}
		return false;
	};

	initialize();
}


//전체메뉴보기

function wholemenu_Show() {
	var obj = document.getElementById("menuOpen");
	if ( !obj.style.display || obj.style.display == "none" ) {
		document.getElementById("all_menu").title = "전체메뉴닫기"
		obj.style.display = "block";
	} else {
		document.getElementById("all_menu").title = "전체메뉴열기"
		obj.style.display = "none";
	}
}

//index 인터뷰, 협력캘린더
function viewList(a){
 for(var i=1;i<3;i++){
 obj = document.getElementById("hlist"+i);
 obj2 = document.getElementById("tab"+i);
	if (i>1)
	{
		 obj3 = document.getElementById("tab"+(i-1));
	}
 if(a==i){
 obj.style.display = "block";
 obj2.setAttribute("src","images/index/h_tab"+i+"_on.gif");
 }else{
 obj.style.display = "none";
 obj2.setAttribute("src","images/index/h_tab"+i+".gif");
 }
 }
}

//로그인 member 별로 수계 고정 함수
function selectedSugyeInMemberIdNew(userId,  system, sugyeName){
	var dropDownSet = $("#" +sugyeName);
	
	$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/goSugyeList.do", {userId:userId, system:system}, function (data, status){
		if(status == 'success'){
//			dropDownSet.emptySelect();
			dropDownSet.loadSelect(data.sugye);
			$("#" +sugyeName).val(data.sugye[0].VALUE).attr("selected", "selected");
			
			adjustGongku();
		} else {
			 alert("수계 목록 가져오기 실패");
			return;
		}
	});
}

function selectedSugyeInMemberIdNew2(userId,  system, sugyeName){
	var dropDownSet = $("#" +sugyeName);
	
	$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/goSugyeList.do", {userId:userId, system:system}, function (data, status){
		if(status == 'success'){
//			dropDownSet.emptySelect();
			dropDownSet.loadSelect(data.sugye);
			$("#" +sugyeName).val(data.sugye[0].VALUE).attr("selected", "selected");
			
			adjustGongku_A();
		} else {
			 alert("수계 목록 가져오기 실패");
			return;
		}
	});
}

function selectedSugyeInMemberIdNew(userId,  system, sugyeName){
	var dropDownSet = $("#" +sugyeName);
	
	$.getJSON(ROOT_PATH+"waterpolmnt/waterinfo/goSugyeList.do", {userId:userId, system:system}, function (data, status){
		if(status == 'success'){
//			dropDownSet.emptySelect();
			dropDownSet.loadSelect(data.sugye);
			$("#" +sugyeName).val(data.sugye[0].VALUE).attr("selected", "selected");
			
			adjustGongku();
		} else {
			 alert("수계 목록 가져오기 실패");
			return;
		}
	});
}

function setCookie( name, value, expiredays ){
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie( name ){
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length ) {
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
			endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
		break;
	}
	return "";
}