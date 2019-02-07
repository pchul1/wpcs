<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="SMS 전송" name="title"/>
</jsp:include>
<script type="text/javascript">
//<![CDATA[
	$(function () {
		
		$("#dept").change(function(){
			setPerson(); //직원셋팅
		});
		
		setDept();		//부서셋팅
		
		window.onbeforeunload = function(e) {
			return ' ';
		};
		
		$('#smsContent').keyup(function(){
			var bytes = ChkByte1(registform.smsContent,80);
			
			$('#byteSpan').html(bytes);
			
		});
	});
	
	//저장 
	function fnSave(){
		if(!fnvalidation()){
			return false;
		}else{
			if(confirm("전송 하시겠습니까?")){
				window.onbeforeunload = null; 
				document.registform.action = "/mobile/sub/sms/smsRegProc.do";
				document.registform.submit();
			}
		}
	}
	
	function fnvalidation(){
		var reportDate	= $('#reportDate').val();
		var reportHour	= $('#reportHour').val();
		var reportMin	= $('#reportMin').val();
		
		var reporterName  = $('#reporterName').val();
		var reporterTelNo = $('#reporterTelNo').val();
		var reporterDept  = $('#reporterDept').val();
		
		var receiveDate	= $('#receiveDate').val();
		var receiveHour	= $('#receiveHour').val();
		var receiveMin	= $('#receiveMin').val();
		
		var wpKind		= $('#wpKind').val();
		var riverDiv	= $('#riverDiv').val();
		var address		= $('#address').val();
		var wpContent	= $('#wpContent').val();
		var smsContent	= $('#smsContent').val();
		var sPerson		= $('#sPerson').val();
		
		//전파대상자
		var member = new Array;	
		var cnt = 0;
		
		$("input[name='personval']").each(function() {
			member.push($(this).val());
			cnt++;
		});
		$("#memberId").val(member);
		
		if(cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return false;
		}
		
		if(smsContent == "") {
			alert("SMS내용을 입력해 주십시요.");
			$("#smsContent").focus();
			return false;
		}
		
		return true;
	}
	
	//부서별 직원생성
	function setPerson(){
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
		if(value == undefined)
			return;
		
		$.getJSON("<c:url value='/alert/getSmsMemberList.do'/>",
				{
					orderType:"2",
					value:value
				},
				//, system:sys_kind},
				function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					//adjustBranchList();
				
				} else {
					return;
				}
		});
	}
	
	//부서생성
	function setDept(){
		var dropDownSet = $("#dept");
		
		$("#sPerson").emptySelect();
		
		$.getJSON("<c:url value='/alert/getSmsGroupList.do'/>",
			{
				orderType:"1"
			},
			//, system:sys_kind},
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					
					setPerson();
					//adjustBranchList();
					
				} else {
					return;
				}
		});
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	//SMS 보낼 직원 추가
	function add(){
		//var selValue = $("#person option:selected").val();
		var value = $("#person").val();
		var strValue = new String(value).replace(/,/g, "_");
		
		if($("div[id='"+strValue+"']").length < 1){
			var smspersonshtml = $("#smspersons").html();
			var inputbox = "<input type='hidden' name='personval' value='" + value + "' />";
			var contenthtml = "";
			
			contenthtml += "<div id='" + strValue + "' style='padding:5px 0;clear:both;'>" + inputbox;
			contenthtml += 		"<div style='float:left'>" + $("#dept option:selected").text() + " > ";
			var loop = 1;
			$("#person option:selected").each(function () {
				if($("#person option:selected").size()==loop) {
					contenthtml += $(this).text(); 
				} else {
					contenthtml += $(this).text() + ", "; 
				}
				loop++;
			});
			contenthtml +=      "</div>";
			contenthtml += 		"<div style='float:right'><a href='#' onclick=\"del('" + strValue + "'); return false;\">X</a></div>";
			contenthtml += "</div>";
			$("#smspersons").html(smspersonshtml + contenthtml);
		}
	}
	
	//SMS 보낼 직원 삭제
	function del(n){
		$("#"+n).remove();
	}
	
	function SelCheck(sel){
		var add = "<input type='text' id='selAdd' style='width:300px;'/>";
		if(sel==35){
			$('#SelAdd').html(add);
			$('#selAdd').focus();
		}else{
			$('#SelAdd').html("");
		}
	}
	
	function ChkByte1(objname, maxlength) {
		var objstr = objname.value;			// 입력된 문자열을 담을 변수
		var objstrlen = objstr.length;		// 전체길이
		
		// 변수초기화 
		var maxlen = maxlength;		// 제한할 글자수 최대크기 
		var i = 0;					// for문에 사용 
		var bytesize = 0;			// 바이트크기 
		var strlen = 0;				// 입력된 문자열의 크기
		var onechar = "";			// char단위로 추출시 필요한 변수 
		var objstr2 = "";			// 허용된 글자수까지만 포함한 최종문자열
		
		var cutLength = 0;
		
		// 입력된 문자열의 총바이트수 구하기
		for(i=0; i< objstrlen; i++) {
			// 한글자추출 
			onechar = objstr.charAt(i);
			
			if (escape(onechar).length > 4) {
				bytesize += 2;		// 한글이면 2를 더한다.
			} else {
				bytesize++;			// 그밗의 경우는 1을 더한다.
			}
			
			if(bytesize <= maxlen){		// 전체 크기가 maxlen를 넘지않으면 
				strlen = i + 1;			// 1씩 증가
			}
		}
		
		// 총바이트수가 허용된 문자열의 최대값을 초과하면	
		if(bytesize > maxlen) {
			
			var bytesize2 = 0;
			
			alert('80byte 이상 입력할 수 없습니다');
			
			for(i=0; i< objstrlen; i++) {
				// 한글자추출 
				onechar = objstr.charAt(i);
				
				if (escape(onechar).length > 4) {
					bytesize2 += 2;		// 한글이면 2를 더한다.
				} else {
					bytesize2++;		// 그밗의 경우는 1을 더한다.
				} 
				
				if(bytesize2 > 80){
					cutLength = i-1;
					break;
				}
			}
			
			objstr2 = objstr.substr(0, cutLength);
			objname.value = objstr2;
			
			var bytesize3 = 0;
			
			for(i=0; i< objstr2.length; i++) {
				// 한글자추출
				//onechar = objstr2.charAt(i); 
				onechar = objstr2.charCodeAt(i);
				
				//if (escape(objstr2).length > 4) {
				if( onechar > 0x3130 && onechar < 0x318F){
					bytesize3 += 2;		// 한글이면 2를 더한다.
				} else {
					bytesize3++;		// 그밗의 경우는 1을 더한다.
				}
			}
			bytesize = bytesize3;
		}
		return bytesize;
	}
//]]>
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/sms/smsRegist.do" name="link"/>
		<jsp:param value="SMS 전송" name="title"/>
	</jsp:include>
<form name="registform" method="post" action="/mobile/sub/sms/smsRegProc.do">
<input type="hidden" name="searchRiverDiv" value="<c:out value="${param_s.searchRiverDiv}"/>"/>
<input type="hidden" name="searchWpKind" value="<c:out value="${param_s.searchWpKind}"/>"/>
<input type="hidden" name="searchWpsStep" value="<c:out value="${param_s.searchWpsStep}"/>"/>
<input type="hidden" name="startDate" value="<c:out value="${param_s.startDate}"/>"/>
<input type="hidden" name="endDate" value="<c:out value="${param_s.endDate}"/>"/>
<input type="hidden" id="receiverId" name="receiverId">
<input type="hidden" id="memberId" name="memberId"/>
<c:if test="${!empty View.wpCode}">
<input type="hidden" id="wpCode" name="wpCode" value="${View.wpCode}"/>
</c:if>

<div>
	<div class="write">
		<div id="thirdstep">
			<div class="titleBx" style="margin-top:20px">▶ 전파대상</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" /> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<th>대상기관</th>
					<td><select id="dept"></select></td>
				</tr> 
				<tr>
					<th>담당자</th>
					<td><select id="person" multiple="multiple"></select></td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="width:100%">
							<ul class="sbtn" style="width:100%"> 
								<li style="width:90%;">
									<a href="#" onclick="add(); return false;">추가하기</a>
								</li>
							</ul>
						</div> 
					</td>
				</tr> 
				<tr>
					<td colspan="2" style="min-height:60px;border:1px solid #333333" valign="top">
					<div>
						<div id="smspersons" style="min-height:50px;">
						</div>
					</div>				
					</td>
				</tr>
			</table>
		</div>
		
		<div class="titleBx" style="margin-top:20px">▶ SMS (<span id="byteSpan">0</span>/80bytes)</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<td><textarea id="smsContent" name="smsContent" rows="10" cols="19" class="textArea" style="overflow:visible;"></textarea></td>
				</tr>
			</table>
			<div style="text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a href="#" onclick="fnSave(); return false;">전송하기</a></li> 
				</ul>
			</div>
	</div>
</div>
</form>

</body>
</html>