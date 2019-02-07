<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>
	var sys;
	var river;
	var step;
	var itemCnt;
	var itemArray;
	var itemCode;
	
	$(function(){

		$("#loadingDiv").dialog({
			modal:true,
			open:function() 
			{
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
			width:85,
			height:75,
		    showCaption:false,
		    resizable:false
		});
		
		sys = '${param.sys}';
		river = '${param.river}';

		$("#river > option[value="+river+"]").attr("selected", "true");
		$("#sys > option[value="+sys+"]").attr("selected", "true");
		
		if($("#sys").val() == "T")
		{
			$("#R01").text("수도권");	
			$("#R02").text("충청/강원");
			$("#R03").text("영남");
			$("#R04").text("호남");
		}
		else
		{
			$("#R01").text("한강");	
			$("#R02").text("낙동강");
			$("#R03").text("금강");
			$("#R04").text("영산강");
		};
					 
		dataLoad();
		//reloadData();

		$('#sys')
			.change(function(){
				if($("#sys").val() == "T")
				{
					$("#R01").text("수도권");	
					$("#R02").text("충청/강원");
					$("#R03").text("영남");
					$("#R04").text("호남");
				}
				else
				{
					$("#R01").text("한강");	
					$("#R02").text("낙동강");
					$("#R03").text("금강");
					$("#R04").text("영산강");
				};;
				dataLoad();
			})
		
		$('#river')
			.change(function(){
				dataLoad();
		})			
	});

	function loadingClose()
	{
			$("#loadingDiv").dialog("close");
	}
	
	
	//데이터 불러오기
	function dataLoad()
	{
		sys = $("#sys").val();
		river = $("#river").val();
		
		

		$("#dataList").html("<tr><td colspan='9'>데이터를 불러오고 있습니다.</td></tr>");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getTotalMntNorecv.do'/>",
			data:{sys:sys,
					river:river,
					step:step},
			dataType:"json",
			success:dataLoad_success,
	        error:function(result){
					$("#dataList").html("<tr><td colspan='9'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
		
		loadingClose();
	}


	
	function dataLoad_success(result)
	{
        var tot = result['refreshData'].length;
		var trClass;
		
        $("#dataList").html("");

        if( tot <= "0" ){
			$("#dataList").html("<tr><td colspan='9'>조회 결과가 없습니다</td></tr>");

			//for(var i=0; i<1000; i++){
			//	$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(2 + itemCnt)+"'>"+i+"조회 결과가 없습니다</td></tr>");
		   //}	
        }
        else{
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];

                    var item;

					if(i==0){
						item="<strong>[ 최종수신시간: "+obj.min_time+" ]</strong>";
						$("#currDate").html(item);
					}

					//TR 색 변경                
					if(i%2!=0){ 
						trClass = "add";
					}else{
						trClass = "";
					}
	                var branchName = obj.branch_name;
	
	                
	 				var factNum;
	               	
	    			if(river=="R01")
	        			factNum = obj.fact_name.replace("한강", "");
	    			else if(river == "R02")
	        			factNum = obj.fact_name.replace("낙동강", "");
	    			else if(river == "R03")
	        			factNum = obj.fact_name.replace("금강","");
	    			else if(river == "R04")
	        			factNum = obj.fact_name.replace("영산강","");
	    			
	    			if(sys == "T")
    				{
	    				item = "<tr class='"+trClass+"'><td>"+factNum+"</td>"
						+"<td>"+branchName+"</td>"
						+"<td id='rem"+i+"'>"+obj.sys_kind+"</td>"
						+"<td id='rem"+i+"'>"+obj.river_name+"</td>"
						+"<td id='rem"+i+"'>"+(obj.min_time == "" ? "-" : obj.min_time)+"</td>"
						+"<td id='rem"+i+"'>"+obj.fact_manager+"</td>"
						+"<td id='rem"+i+"'>"+obj.fact_tele+"</td>"
						+"<td id='rem"+i+"'>"+obj.fact_addr+"</td>"							
						+"<td> - </td>";
						+"</tr>";
    				}
	    			else
    				{
	    				item = "<tr class='"+trClass+"'><td>"+factNum+"</td>"
						+"<td>"+branchName+"</td>"
						+"<td id='rem"+i+"'>"+obj.sys_kind+"</td>"
						+"<td id='rem"+i+"'>"+obj.river_name+"</td>"
						+"<td id='rem"+i+"'>"+(obj.min_time == "" ? "-" : obj.min_time)+"</td>"
						+"<td id='rem"+i+"'>"+obj.fact_manager+"</td>"
						+"<td id='rem"+i+"'>"+obj.fact_tele+"</td>"
						+"<td id='rem"+i+"'>"+obj.fact_addr+"</td>"							
						+"<td style='cursor:pointer;'" + 
						"onclick=\"javascript:branchAdminInfoPopup('"+obj.fact_code_real+"', '" + obj.branch_no + "', '"+ obj.branch_name+"')\"><img src=\"<c:url value='/images/popup/icon_view.gif'/>\" alt='측정소상황전파자정보' /></td>";
						+"</tr>";
    				}
					$("#dataList").append(item);
	
				}

			loadingClose();
            }
	}


	function reloadData(){
		setTimeout(dataLoad, 10000);
	}

	function branchAdminInfoPopup(fact_code, branch_no, branch_name) {
		var sw=screen.width;var sh=screen.height;
		var winHeight = 480;
		var winWidth = 800;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;

		var src = "<c:url value='/waterpolmnt/situationctl/goAlertTargetList.do'/>?fact_code="+fact_code+"&branch_no=" + branch_no + "&branch_name=" + encodeURI(branch_name);

		window.open(src,   
				'goAlertTargetList','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	</script>		
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div id='loadingDiv'>
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />	
</div>
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1>미수신 측정소 상세정보</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
<div class="totalmntPop1" style="padding-top:20px">
	<div class="content">
		<form action="">
			<ul class="selectList">
				<li><span class="buArrow_tit">시스템</span> 
					<select id="sys">
 						<option value="A">국가수질자동측정망</option>
						<option value="U">이동형측정기기</option>						
						<option value="T">수질TMS</option> 
					</select>
				</li>
				<li><span class="buArrow_tit">수계</span>
					<select id="river">					
						<option id = "R01" value="R01">한강</option>
						<option id = "R02" value="R02">낙동강</option>
						<option id = "R03" value="R03">금강</option>
						<option id = "R04" value="R04">영산강</option>
					</select>
				</li>
			</ul>
		</form>	
	
							<table class="dataTable">
									<colgroup>
										<col width="65px" />
										<col width="75px" />
										<col width="50px" />
										<col width="60px" />
										<col width="110px" />
										<col width="60px" />
										<col width="90px" />
										<col width="180px" />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">지역</th>
											<th scope="col">측정소</th>
											<th scope="col">시스템</th>
											<th scope="col">수계</th>
											<th scope="col">마지막 수신시간</th>
											<th scope="col">관리자</th>
											<th scope="col">연락처</th>
											<th scope="col">주소</th>
											<th scope="col">상황</th>
										</tr>
									</thead>
								</table>
		<div class="overBox overBoxOther" style="border-top:solid 0px white">
								<table class="dataTable">
								<colgroup>
										<col width="65px" />
										<col width="75px" />
										<col width="50px" />
										<col width="60px" />
										<col width="110px" />
										<col width="60px" />
										<col width="90px" />
										<col width="180px"/>
										<col  />
									</colgroup>
								<tbody id="dataList">
									<tr>
										<td colspan="9">데이터를 불러옵니다...</td>
									</tr>
								</tbody>								
								</table>
		</div>
	</div>
</div>
</div><!-- 추가 및 수정 -->
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>

