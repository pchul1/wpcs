<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : itemConditionRegist.jsp
  * @Description : 방제물품 입,출고  화면
  * @Modification Information
  * @
  * @  수정일             수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2012.11.12   윤일권              최초 생성
  *
  *  @author 윤일권
  *  @since 2012.11.12
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>방제물품 입,출고 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css' />" />
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
<!--
function init(){
	getWareHouseCode();
	getUpperGroupCode();
}


//목록
function fnGoListPage(){
	var frm = document.
	location.href = "<c:url value='/warehouse/itemConditionManageList.do'/>";
}

//물품 입고
function fnGoInsert(){

	var returnValue = 'true';

	if( $('#whCode').val() == ''  ){
		alert('창고는 필수항목입니다')
		$('#whCode').focus()
		returnValue = 'false';
	}else{
		if( $('#upperGroupCode').val() == ''  ){
			alert('대분류는 필수항목입니다')
			$('#upperGroupCode').focus()
			returnValue = 'false';
		}else{
			if( $('#groupCode').val() == ''  ){
				alert('중분류는 필수항목입니다')
				$('#groupCode').focus()
				returnValue = 'false';
			}else{
				if( $('#itemCode').val() == ''  ){
					alert('물품은 필수항목입니다')
					$('#itemCode').focus()
					returnValue = 'false';
				}else{
					if( $('#amt').val() == ''  ){
						alert('입고수량은 필수항목입니다')
						$('#amt').focus()
						returnValue = 'false';
					}else{
						
					}
				}
			}
		}
	}

	if(returnValue == 'true'){
		var frm    = document.insertForm;
		frm.action = "<c:url value='/warehouse/itemConditionStorRegist.do'/>";
		frm.submit();
	}else{
		return false;
	}
}

//창고 코드 불러오기
function getWareHouseCode(){
	$.ajax({
		type:"POST",
		url:"<c:url value='/warehouse/getWareHouseCode.do'/>",
		data:{},
		dataType:"json",
		beforeSend:function(){
			$('#whCode').attr("disabled", true);	
		},
		success:function(result){
			var dropDownSet = $('#whCode');
			dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
			$('#whCode').attr("disabled", false);						
		}
	});
}

//대분류 코드 불러오기
function getUpperGroupCode(){
	$.ajax({
		type:"POST",
		url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
		data:{},
		dataType:"json",
		beforeSend:function(){
			$('#upperGroupCode').attr("disabled", true);	
		},
		success:function(result){
			var dropDownSet = $('#upperGroupCode');
			dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
			$('#upperGroupCode').attr("disabled", false);						
			getGroupCode();	
		}
	});
}

//중분류 코드 불러오기
function getGroupCode(){
	var upperGroupCode = $('#upperGroupCode').val();

	if(upperGroupCode == ''){
		$('#groupCode').html("<option value=''>선택없음</option>");
		$('#itemCode').html("<option value=''>선택없음</option>");
	}else{
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemManageGroupCode.do'/>",
			data:{
				upperGroupCode : upperGroupCode
				},
			dataType:"json",
			beforeSend:function(){
				$('#groupCode').attr("disabled", true);	
			},
			success:function(result){
				var dropDownSet = $('#groupCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#groupCode').attr("disabled", false);
				getItemCode();
			}
		});
	}
}

//물품 코드 불러오기
function getItemCode(){	

	var groupCode = $('#groupCode').val();

	if(groupCode == ''){
		$('#itemCode').html("<option value=''>선택없음</option>");
		$('#itemUnit').val('');
		$('#itemStan').val('');
	}else{
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemConditionCode.do'/>",
			data:{
				groupCode : groupCode
				},
			dataType:"json",
			beforeSend:function(){
				$('#itemCode').attr("disabled", true);	
			},
			success:function(result){
				var dropDownSet = $('#itemCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'VALUE', 'CAPTION');
				$('#itemCode').attr("disabled", false);	
			}
		});
	}
}

//규격, 단위 불러오기
function getItemDetailValue(){	
	var itemCode = $('#itemCode').val();

	if(itemCode == ''){
		
	}else{
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/getItemDetailValue.do'/>",
			data:{
				itemCode : itemCode
				},
			dataType:"json",
			beforeSend:function(){
				
			},
			success:function(result){	
				$('#itemUnit').val(result['codes'][0].itemUnit);
				$('#itemStan').val(result['codes'][0].itemStan);
			}
		});
	}
}

//숫자체크
function checkNum(inputValue){
	var checkCode = inputValue.value.charCodeAt(inputValue.value.length-1); 
	
	var str; 
	
	if(checkCode >= 33 && checkCode <= 47 || checkCode >= 58 && checkCode <= 125) 
	{
	 alert("숫자만 입력가능합니다.");
	
	 str = inputValue.value.substring(0,inputValue.value.length-1);
	
	 inputValue.value = str;  
	
	 inputValue.focus();
	
	}else if( checkCode >= 48 && checkCode <= 57 ){  
	
	 inputValue.focus(); 
	
	} 
}

-->
</script>
</head>
<body onload="init()">
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
		<div id="content">
			<div id="managePage">
		        <table>
		        	<tr>
		        		<td width="1000px"></td>		        		
		        		<td align="right">
		        		<input id="goListBtn" onclick="javascript:fnGoListPage()" type="image" src="<c:url value='/images/common/btn_list2.gif'/>" alt="목록" />		        				        		
		        		</td>
		        	</tr>
		        </table>
				<form name="insertForm" method="post">
					<input type="hidden" name="mode" id="mode" value="insertStor"/>
					<table class="dataTable">
						<colgroup>
							<col width="15%">
							<col>
						</colgroup>						
						<tr>
							<th>창고<span class="asterisk">*</span></th>
							<td>
								<select class="fixWidth20" name="whCode" id="whCode">
									<option value="">선택</option> 
								</select>
							</td>
						</tr>
						<tr>
							<th>분류<span class="asterisk">*</span></th>
							<td>																					
								<select class="fixWidth20" name="upperGroupCode" id="upperGroupCode" onchange="javascript:getGroupCode();">
									<option value="">선택</option> 
								</select>
								<select class="fixWidth20" name="groupCode" id="groupCode" onchange="javascript:getItemCode();">
									<option value="">선택</option> 
								</select>
									
							</td>
						</tr>
						<tr>
							<th>물품<span class="asterisk">*</span></th>
							<td>
								<select class="fixWidth20" name="itemCode" id="itemCode" onchange="javascript:getItemDetailValue();" >
									<option value="">선택</option> 
								</select>
							</td>
						</tr>
						<tr>
							<th>규격</th>
							<td>
								<input style="width:240px; background-color:#D5D5D5;" type="text" name="itemUnit" id="itemUnit" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th>단위</th>
							<td><input style="width:240px; background-color:#D5D5D5;" type="text" name="itemStan" id="itemStan" readonly="readonly"/></td>
						</tr>
						<tr>
							<th>입고수량<span class="asterisk">*</span></th>
							<td>
							    <input style="width:240px; ime-mode:disabled;" type="text" name="amt" id="amt" onkeyup="checkNum(this)"/>
							    <font color="red">(숫자만 입력가능)</font>
							</td>
						</tr>
						<tr>
							<th>설명</th>
							<td>
								<textarea name="storDesc" id="storDesc" ></textarea>
							</td>
						</tr>						
					</table>
				</form>
				<table>
		        	<tr>
		        		<td width="950px"></td>		        		
		        		<td align="right">	
		        		<input id="goModifyBtn" onclick="javascript:fnGoInsert()" type="image" src="<c:url value='/images/common/btn_save.gif'/>" alt="저장" />		        		
		        		</td>
		        	</tr>
		        </table>
			</div><!-- //managePage -->
		</div><!-- //content -->
	</div><!-- //container -->
	
	<div id="footer">
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div><!-- //footer -->
</div>
</body>
</html>	