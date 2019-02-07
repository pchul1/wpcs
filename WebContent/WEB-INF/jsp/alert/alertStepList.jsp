<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertStepList.jsp
	 * Description : Alert Step List 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.19	khanian		최초 생성
	 * 
	 * author khany
	 * since 2010.05.17
	 *  
	 * Copyright (C) 2010 by khany  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
<script type='text/javascript'>
	$(function () {

		/*shows the loading div every time we have an Ajax call*/  
		pageLoding();

		// 달력 스크립트
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',	
			buttonImage: ROOT_PATH+'images/common/ico_calendar.gif',
			buttonImageOnly: true
		});
		
		$("#toDate").datepicker({
			buttonText: '조회일자'
		});
		$("#fromDate").datepicker({
			buttonText: '조회일자'
		});
		
		var today = new Date(); 
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" +addzero(today.getDate());
		
		//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		$("#toDate").val(today);
		$("#fromDate").val(today);
		
		
		$("#itemType").change(function() {
			changeType();
		});
		
		$('#print').click(function () {
			report();
		});
		
		loadAlertStepList();
		
		set_User_deptNo(user_dept_no, "riverId");
	});
	
	function changeType()
	{
		var value = $("#itemType").val();
		var searchType = $("#searchType1");
		var searchSystem = $("#searchSystem");
		
		if(value == "AUTO")
		{
			searchSystem.show();
			searchType.hide();
			
			$("#receiptType > option[value=All]").attr("selected","selected");
		}
		else if(value == "TYPE2")
		{
			searchSystem.hide();
			searchType.hide();
			
			$("#system > option[value=All]").attr("selected","selected");
			$("#receiptType > option[value=All]").attr("selected","selected");
		}
		else if(value == "TYPE1")
		{
			searchSystem.hide();
			searchType.show();
			
			$("#system > option[value=All]").attr("selected","selected");
		}
	}
	
	function report() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 900;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var mrdFile = "statsStep";
		var param = "/rp ["+$('#toDate').val()+"] [<%=request.getRequestURL().toString().replaceAll(request.getRequestURI(), "")%><c:url value='/' />]";		
		
		document.report.mrdpath.value = mrdFile;
		document.report.param.value = param;
		
		window.open("", 
				'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
		
		document.report.target = "reportView";
		document.report.submit();
	}
	
	function loadAlertStepList(pageNo){
		
		if(validation() == false) return false;
		
		var system = $("#system").val();
		var itemType = $("#itemType").val();
		if(itemType != 'AUTO')
			system = "All";
		var testval =$("#receiptType").val();
		//alert("receiptType : "+testval);
		//alert("itemType : "+itemType);
		//alert("system : "+system);
		
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/alertStepListView.do'/>",
			data:{
				receiptType:$("#receiptType").val(),
				riverId:$("#riverId").val(), 
				toDate:$("#toDate").val2(), 
				fromDate:$("#fromDate").val2(), 
				system:system,
				itemType:$("#itemType").val(),
				pageIndex:pageNo},
			dataType:"json",
			success:function(result){
				//alert("test6");
				var tot = result['dataList'].length;
				var item;
				var branch;
				var branchName;
				$("#dataList").html("");
				//alert("test5");
				if( tot <= "0" ){
					//alert("test4");
					$("#dataList").html("<tr><td colspan='12'>조회 결과가 없습니다</td></td>");
					
				}else{
					//alert("test3");
					for(var i=0; i < tot; i++){
						var obj = result['dataList'][i]; 
						//alert(parseint(obj.branchNo));
						branch = obj.branchNo;
						//alert("test2");
						if(branch ==0){
							branchName="사고지점";
						}else{
							branchName=branch+" 측정소";
						} 
						//alert("test1");
						//TR 색 변경
						if(i%2!=0){ 
							trClass = "add";
						}else{
							trClass = "";
						}
						//alert("obj.riverId : "+obj.riverId);
						
						if(obj.factCode == '50A0001')
						{
							obj.system = "-";
							obj.factName = obj.riverId + "(임의지점)";
							obj.branchNo = "";
							obj.minVl = "-";
						}
						else
						{
							obj.branchNo = "-" + obj.branchNo;
						}
						
						var itemName = obj.itemName;
						
						if(obj.itemName2 != null && obj.itemName2 != '')
							itemName += ', ' + obj.itemName2;
						
						if(obj.itemName3 != null && obj.itemName3 != '')
							itemName += ', ' + obj.itemName3;

						var minValue = obj.minVl;

						if(obj.itemName2 != null && obj.itemName2 != '')
						{
							obj.minVl2 = new Number(obj.minVl2).toFixed(2) + "";
							minValue += ' / ' + obj.minVl2;
						}
						
						if(obj.itemName3 != null && obj.itemName3 != '')
						{
							obj.minVl3 = new Number(obj.minVl3).toFixed(2) + "";
							minValue += ' / ' + obj.minVl3;
						}
						
						 if(obj.itemTypeCode != "")
								minValue = "-";
						
						item = "<tr class='"+trClass+"' style='cursor:pointer'>"
							 +"<a style='cursor:pointer'>" 
							 +"<td id='rem"+i+"' onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\")'>"+obj.alertTime+"</td>"
							 +"<td id='rem"+i+"' onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\")'>"+obj.system+"</td>"
							 +"<td id='rem"+i+"' onclick=\"detailPopup('"+obj.factCode+"', '"+obj.branchNo+"', '"+obj.system+"', '" + obj.branchName + "-" + obj.branchNo + "')\">"+obj.branchName+obj.branchNo + "</td>"
							 +"<td id='rem"+i+"' onclick=\"detailPopup('"+obj.factCode+"', '"+obj.branchNo+"', '"+obj.system+"', '" + obj.branchName + "-" + obj.branchNo + "')\">"+itemName+"</td>"
							 +"<td id='rem"+i+"' onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\")'>"+minValue+"</td>"
							 +"<td id='rem"+i+"' onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\")'>"+obj.minOr+"</td>";
							
						var onclick1 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"1\", \"" + obj.itemTypeCode + "\")'";
						var onclick2 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"2\", \"" + obj.itemTypeCode + "\")'";
						var onclick3 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"3\", \"" + obj.itemTypeCode + "\")'";
						var onclick4 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"4\", \"" + obj.itemTypeCode + "\")'";
						var onclick5 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"5\", \"" + obj.itemTypeCode + "\")'";
						var onclick6 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"6\", \"" + obj.itemTypeCode + "\")'";
						var onclick7 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"7\", \"" + obj.itemTypeCode + "\")'";
						var onclick8 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"8\", \"" + obj.itemTypeCode + "\")'";
						var onclick9 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"9\", \"" + obj.itemTypeCode + "\")'";
						var onclick10 = "onclick='javascript:viewSub("+obj.asId+", \"" + obj.alertStep + "\", \"10\", \"" + obj.itemTypeCode + "\")'";
						
						/*
						var backImg_start = "style='text-align:center;background-image:url(\"<c:url value='/images/alert/bar_1.gif'/>\");background-repeat:no-repeat;background-position:center;border-right:solid 0px white;border-left:solid 0px white;color:white'";
						var backImg_middle = "style='text-align:center;background-image:url(\"<c:url value='/images/alert/bar_1_1.gif'/>\");background-repeat:no-repeat;background-position:center;border-right:solid 0px white;border-left:solid 0px white;color:white'";
						var backImg_end = "style='text-align:center;background-image:url(\"<c:url value='/images/alert/bar_1_2.gif'/>\");background-repeat:no-repeat;background-position:center;border-right:solid 0px white;border-left:solid 0px white;color:white'";
						var backImg = "style='text-align:center;background-image:url(\"<c:url value='/images/alert/bar_1_3.gif'/>\");background-repeat:no-repeat;background-position:center;border-right:solid 0px white;border-left:solid 0px white;color:white'";
						*/
						
						var backImg_start = "style='text-align:center;background:#2f8bc0;background-repeat:no-repeat;background-position:center;border-right:solid 0px white;border-left:solid 0px white;color:white'";
						var backImg_middle = "style='text-align:center;background:#2f8bc0;background-repeat:no-repeat;background-position:center;border-right:solid 0px white;border-left:solid 0px white;color:white'";
						var backImg_end = "style='text-align:center;background:#2f8bc0;background-repeat:no-repeat;background-position:center;border-right:solid 1px #CCC;border-left:solid 0px white;color:white'";
						var backImg = "style='text-align:center;background:#2f8bc0;background-repeat:no-repeat;background-position:center;border-right:solid 1px #CCC;border-left:solid 0px white;color:white'";
						
						if(obj.alertStep == "1" || obj.alertStep == "9") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='5' "+onclick1+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";
						} else if(obj.alertStep == "2") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">" + obj.step1 + "</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick2+" " + backImg_end +">조치중</td>";
							item += "<td class='step' id='rem"+i+"' colspan='4' "+onclick2+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";
						} else if(obj.alertStep == "3") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick2+" " + backImg_middle +">"+obj.step2+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick3+" " + backImg_end +">조치중</td>";
							item += "<td class='step' id='rem"+i+"' colspan='3' "+onclick3+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";
						} else if(obj.alertStep == "4") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick2+" " + backImg_middle +">"+obj.step2+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick3+" " + backImg_middle +">"+obj.step3+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick4+" " + backImg_end +">조치중</td>";
							item += "<td class='step' id='rem"+i+"' colspan='2' "+onclick4+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";
						} else if(obj.alertStep == "5") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick2+" " + backImg_middle +">"+ obj.step2 +"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick3+" " + backImg_middle +">"+ obj.step3 +"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick4+" " + backImg_middle +">"+ obj.step4 +"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick5+" " + backImg_end +">조치중</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick5+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";
						} else if(obj.alertStep == "6") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+ obj.step1 +"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick6+" " + backImg_middle +">" + obj.step2 + "</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick6+" " + backImg_end +">장비이상</td>";
							item += "<td class='step' id='rem"+i+"' colspan='3' "+onclick6+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";																																													
						} else if(obj.alertStep == "7") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick7+" " + backImg_end +">이상 데이터</td>";
							item += "<td class='step' id='rem"+i+"' colspan='4' "+onclick7+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";
						} else if(obj.alertStep == "8") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick2+" " + backImg_middle +">"+obj.step2+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick3+" " + backImg_middle +">"+obj.step3+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick4+" " + backImg_middle +">"+obj.step4+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick5+" " + backImg_middle +">"+obj.step5+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick8+" " + backImg_end +">"+obj.step8+"</td>";
						} else if(obj.alertStep == "10") {
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick1+" " + backImg_start +">"+obj.step1+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick2+" " + backImg_middle +">"+obj.step2+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick10+" " + backImg_middle +">"+obj.step3+"</td>";
							item += "<td class='step' id='rem"+i+"' colspan='1' "+onclick10+" " + backImg_end +">시료채수</td>";
							item += "<td class='step' id='rem"+i+"' colspan='2' "+onclick10+" style='border-right:solid 0px white;border-left:solid 0px white'>&nbsp</td>";																																											
						} else {
							item += "<td class='step' id='rem"+i+"' colspan='6' "+onclick+"></td>";
						}
						
						item = item +"</a></tr>";
						$("#dataList").append(item);
					}
				}
				 // 페이징 정보
					var pageStr = makePaginationInfo(result['paginationInfo']);
					$("#pagination").empty();
					$("#pagination").append(pageStr);	 
			},
			error:function(result){alert("error");}
		});
	}

	function fncSms() {

		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 900;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		window.open("<c:url value='/alert/alertSms.do'/>?", 
				'DetailView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}	

	function viewSub(asId, alertStep, clickStep, itemType) {

		if(clickStep == null || clickStep == '')
			clickStep = alertStep;

		//alert("asId="+asId);
		var sw=screen.width;var sh=screen.height;var winHeight = 840;var winWidth = 1064;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		var param = "asId=" + asId + "&step=" + alertStep +"&cStep=" + clickStep + "&itemType=" + itemType;
		
		//alert(param);
		window.open("<c:url value='/alert/alertStepSub.do'/>?"+param, 
				'AlertSub','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	} 
	// 페이지 번호 클릭	
	function linkPage(pageno){
		loadAlertStepList(pageno);
	}

	//공구상제정보
	function detailPopup(fact_code, branch_no, sys_kind, branchName) {
		var sw=screen.width;var sh=screen.height;
		var winHeight = 890;
		var winWidth = 1260;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		
		var src = "<c:url value='/waterpolmnt/situationctl/goTotalMntMainDetailTS.do'/>?fact_code="+fact_code+"&branch_no="+branch_no + "&sys_kind=" + sys_kind + "&branchName=" + encodeURI(branchName);
		
		window.open(src, 
				'TotalMntMainDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}


	function validation(){
		if( $('#toDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#fromDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
	}
	function commonWork() {
		var stdt = document.getElementById("toDate");
		var endt = document.getElementById("fromDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "toDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}
		
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				
				var returnValue = commonWork2(endt.value, "fromDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					endt.value = "";
					endt.focus;
					return false;
				}
			}
		}
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
	}
	
	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum	= "true";
			}else{
				returnValue = "false";
				checkNum	= "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}						
				}				
			}	
		}
		return returnValue;
	}

</script>
	
</head>
<body>
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
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
		<div id="content" class="sub_waterpolmnt">
			<div class="content_wrap page_alarmmng">
				<div class="inner_accdntact">
					<!-- 사고 조치 관리 조회 -->
					<div class="search_all_wrap">
						<form action=""  onsubmit="return false">
						<div class="btnInBox">
							<dl>
<%--								<dt><img src="<c:url value='/images/content/tit_search_branch.gif'/>" alt="측정소" /></dt> --%>
								<dd>
									<select class="fixWidth7"  id="riverId">
										<option value="All">전체</option>
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
								</dd>
<%--								<dt><img src="<c:url value='/images/content/tit_search_date.gif'/>" alt="조회기간" /></dt> --%>
								<dd class="time">
									<input type="text" class="inputText"  id="toDate" name="toDate" size="15" onchange="commonWork()"/>
									<span>~</span>
									<input type="text" class="inputText" id="fromDate" name="fromDate" size="15" onchange="commonWork()"/>
								</dd>
<%--								<dt><img src="<c:url value='/images/content/tit_search_div.gif'/>" alt="구분" /></dt> --%>
								<dd>
									<select style="width:80px;" id="itemType" name="itemType">
									<option value="AUTO" selected="selected">자동측정</option> 
									<option value="TYPE2">현장측정</option>
									<option value="TYPE1">육안관찰</option> 
									<option value="All">전체</option> 
									</select>
								</dd>
							</dl>
							<p class="btn_search"><input type="image" src="<c:url value='/images/common/btn_search.gif'/>" alt="조회" onclick="javascript:loadAlertStepList();"/></p>
						</div>
							<div id="searchType1" style="display:none">
								<dl>
									<dt><img src="<c:url value='/images/content/tit_search_receiptType.png'/>" alt="유형" /></dt>
									<dd> 
										<select style="width:110px;" id="receiptType" name="receiptType">
											<option value="All">전체</option>
											<c:forEach items="${codes}" var="codes">
												<option value="${codes.VALUE}">${codes.CAPTION}</option>
											</c:forEach>
										</select>
									</dd>
								</dl>
								
							</div> 
							<div id="searchSystem_tmp" style="display:none">
								<dl>
									<dt><img src="<c:url value='/images/content/tit_search_system.gif'/>" alt="시스템" /></dt>
									<dd>
										<select class="fixWidth13" id="system" name="system">
												<option value="U" selected="selected">이동형측정기기</option>
										</select>
									</dd>
								</dl>
							</div>
						
						</form>
					</div>
					<!-- //사고 조치 관리 조회 -->
					<!-- 사고 조치 관리 현황 -->
					<div class="data_wrap">
						<div class="overBox">
							<table class="dataTable" >
								<colgroup>
									<col width="105px" />
									<col width="80px" />
									<col width="110px" />
									<col width="100px" />
									<col width="55px" />
									<col width="55px" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" rowspan="2">접수일시</th>
										<th scope="col" rowspan="2">시스템</th> 
										<th scope="col" rowspan="2">측정소</th>
										<th scope="col" rowspan="2">항목</th>
										<th scope="col" rowspan="2">측정치</th>
										<th scope="col" rowspan="2">상태</th>
										<th scope="col" colspan="6">상황처리단계</th>
									</tr>
									<tr>
										<th scope="col">경보발생</th>
										<th scope="col">현장확인</th>
										<th scope="col">시료분석</th>
										<th scope="col">경보발령</th>
										<th scope="col">상황조치</th>
										<th scope="col">상황종료</th>
									</tr>
								</thead>
								<tbody id="dataList">
									<tr>
										<td colspan="12">데이터를 불러오는 중 입니다...</td>
									</tr>
								</tbody>
							</table>
						</div>
						<ul class="paginate" id="pagination"></ul>
					 
					</div>
					<!-- //사고 조치 관리 현황 -->
				</div>
			</div>
		</div><!-- //content -->
		
	</div><!-- //container -->
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
	<input type="hidden" name="mrdpath" />
	<input type="hidden" name="param" />
</form>
</body>
</html>
