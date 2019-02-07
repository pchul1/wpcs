<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /** 
  * @Class Name :  itemGroupRegistPopup.jsp
  * @Description : 분류등록 팝업
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 201211.19  윤일권                  최초 생성
  *
  *  @author  윤일권
  *  @since   201211.19
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 

<link href="<c:url value='/css/site.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css">	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
<script>
	var ROOT_PATH = '<c:url value="/"/>';
</script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>	
<title>분류등록</title>
<script type="text/javaScript" language="javascript">



//대/중 분류에 따른 화면 처리
$(function () {
	isUpper = $('#isUpper', opener.document).val();
	
	
	/*
	if(isUpper=='upperGroupCode'){
		var pop  = document.getElementById('hiddenRow');
		var pop2 = document.getElementById('hiddenRowText');
		pop.style.display = "none";
		pop2.style.display = "block";
		$('#popupUpperGroupCodeText').val('');
		$('#popupInsertGroupName').val('');		
	}else if(isUpper=='groupCode'){
		var pop = document.getElementById('hiddenRow');
		var pop2 = document.getElementById('hiddenRowText');
		pop.style.display = "block";
		pop2.style.display = "none";
		$('#popupInsertGroupName').val('');
		getUpperGroupCode();	
	}
	*/
	
	

	if(isUpper=='upperGroupCode'){
		displayPage(0);
	}else if(isUpper=='groupCode'){
		displayPage(1);
			
	}
	
	$('#regType').change(function(){
        //alert( $("#regType option:selected").val() );
        if($("#regType option:selected").val() == "MGroup")
        	displayPage(1);
        else
        	displayPage(0);
    });
	//popupUpperGroupCode
	
	$('#popupUpperGroupCode').change(function(){
		
		if($("#popupUpperGroupCode option:selected").text() != "선택"){
// 			getGroupCode();
		}
 
    });
	
	//영문자 만
});

function displayPage(ntype){
	
	$('#popupUpperGroupCodeText').val('');
	$('#txtGroupCodeText').val('');
	$('#popupInsertGroupName').val('');
	$('#popupInsertGroupName').val('');
	
	if(ntype == 0){
		//대분류
		
		$("#regType").val("LGroup");
		$('.MiddleOnly01').hide();
		$('#GroupCode').text("대분류 코드");
		$('#hiddenRowText').show();
		$('#hiddenRow').hide();
		$('#GroupTitle').text("대분류 명칭");
		$('#isUpper', opener.document).val('upperGroupCode');
	}
	else{
		//중분류
		
		$("#regType").val("MGroup");
		$('.MiddleOnly01').show();
		$('#GroupCode').text("중분류 코드");
		$('#hiddenRowText').hide();
		$('#hiddenRow').show();
		$('#GroupTitle').text("중분류 명칭");
		$('#isUpper', opener.document).val('groupCode');

		getUpperGroupCode();
	}
	
	
}

//대분류 코드 불러오기
function getUpperGroupCode(){
	$.ajax({
		type:"POST",
		url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
		data:{},
		dataType:"json",
		beforeSend:function(){				
			//$('#popupUpperGroupCode').attr("disabled", true);
		},
		success:function(result){
           	var dropDownSet = $('#popupUpperGroupCode');			
			dropDownSet.loadSelectWareHouse(result.codes, '선택', "VALUE", 'CAPTION');	
					
			$('#popupUpperGroupCode').attr("disabled", false);										
		}
	});
}

//코드분류 항목 등록
function fnGoSave(){		
	var upperGroupCodeText = $('#popupUpperGroupCodeText').val();
	var upperGroupCode 	   = $('#popupUpperGroupCode').val();
	var groupName          = $('#popupInsertGroupName').val();
	var useFlag            = $('#popupInsertUseFlag').val();		
	var isUpper            = $('#isUpper', opener.document).val();
	//alert(isUpper);
	
	if(isUpper == 'upperGroupCode'){
	
		var returnValue = 'true';
		//alert(ntype);
		if( $('#popupUpperGroupCodeText').val() == '' ){
			alert('대분류코드는 필수값입니다');
			returnValue = 'false';
		}else{
			var resultValue;				

			//대분류코드 중복 비교. 
			$.ajax({			
				type: "POST",
				url: "<c:url value='/warehouse/itemUpperGroupCodeDup.do'/>",
				data: {
						groupCode : upperGroupCodeText							
					},	
				dataType:"json",
				beforeSend : function(){},				
				success : function(result){	

					var obj = result['list'][0];
											
					var dupCnt = obj.dupCnt;				

					if( dupCnt != '0' ){
						alert('대분류코드가 중복되었습니다');
						$('#popupUpperGroupCodeText').val('');
						$('#popupUpperGroupCodeText').focus();
						returnValue = 'false';
					}else{
						if($('#popupUpperGroupCodeText').val().length != 8){
							alert('대분류코드는 8자리(숫자)만 등록이 가능합니다');
							$('#popupUpperGroupCodeText').val('');
							$('#popupUpperGroupCodeText').focus();
							returnValue = 'false';
						}else{
							if( groupName == ''){
								alert('분류명칭은 필수값입니다');
								returnValue = 'false';
							}
						}
					}	
					

					if(returnValue == 'true'){
						$.ajax({			
							type: "POST",
							url: "<c:url value='/warehouse/itemUpperGroupInsert.do'/>",
							data: {
									groupCode : upperGroupCodeText,
									groupName : groupName,
									useFlag   : useFlag
								},
							dataType:"json",
							beforeSend : function(){},
							success : function(result){
								opener.location.reload();
								self.close();
							}
						});
					}
				}
			});
		}
		
		
	}else if(isUpper == 'groupCode'){

		var returnValue = 'true';
		
		if( $('#popupUpperGroupCode').val() == '' ){
			alert('대분류코드는 필수값입니다');
			returnValue = 'false';
		}else{
			if( groupName == ''){
				alert('분류명칭은 필수값입니다');
				returnValue = 'false';
			}
		}

		if(returnValue == 'true'){
			$.ajax({			
				type: "POST",
				url: "<c:url value='/warehouse/itemGroupInsert.do'/>",
				data: { 
						upperGroupCode : upperGroupCode,
						groupName      : groupName,
						useFlag        : useFlag
					},	
				dataType:"json",
				beforeSend : function(){},				
				success : function(result){
					opener.location.reload();
					self.close();
				}
			});
		}			
	}
}

function fnClosePopup(){
	self.close();
}

//중분류 코드 생성 불러오기 
function getGroupCode(){
	
	var upperGroupCode 	   = $('#popupUpperGroupCode').val();
	//getItemGroupNextCode
	$.ajax({			
		type: "POST",
		url:"<c:url value='/warehouse/getItemGroupNextCode.do'/>",
		data: { 
				upperGroupCode : upperGroupCode
			},	
		dataType:"json",
		beforeSend : function(){},				
		success : function(result){
			
			var code = result["code"];
			if (code == null){
				$('#txtGroupCodeText').val(upperGroupCode + "01");
			}
			else{
				$('#txtGroupCodeText').val(upperGroupCode + code);
			}
			

		}
	});
}


</script>
</head>

<body class="subPop"><!-- 추가 및 수정 -->
	<br>	
	<input type="hidden" name="regType" id="regType" value="">
	<table class="dataTable" style="width:439px !important;">
		<colgroup>
			<col width="30%" />
			<col width="*" />
		</colgroup>
<!-- 		<tr> -->
<!-- 			<th scope="col">등록유형</th> -->
<!-- 			<td> -->
<!-- 				<select name="regType" id="regType" style="width:270px"> -->
<!-- 					<option value="LGroup">대분류 등록</option> -->
<!-- 					<option value="MGroup">중분류 등록</option> -->
<!-- 				</select> -->
<!-- 			</td> -->
<!-- 		</tr> -->
		
		<tr class="MiddleOnly01">
		  	
				<th scope="col" >대분류</th>
			   		<td style="text-align:left;padding-left:17px;"> 
		  		
						<select name="popupUpperGroupCode" id="popupUpperGroupCode" style="width:270px"></select>

			   		</td>
			  
			  
		</tr>

		<tr>
			<th scope="col" id = "GroupCode">대분류코드</th>
			   <td style="text-align:left;padding-left:15px;"> 
				
				<div id="hiddenRow">
				
					<input type="text" id ="txtGroupCodeText" value=" "/>
					<!--  <select name="popupUpperGroupCode" id="popupUpperGroupCode" style="width:270px"></select> -->
				</div>
				<div  id="hiddenRowText">
					<input type="text" id="popupUpperGroupCodeText" name="popupUpperGroupCodeText" style="width:150px;ime-mode:inactive;text-transform:uppercase;"/>
				</div>
				  
			</td>
		</tr>
		
		<tr>
			<th scope="col" id = "GroupTitle">분류명칭</th>
			<td>
				<input type="text" id="popupInsertGroupName" name="popupInsertGroupName" style="width:270px;ime-mode:active;"/>
				<input type="hidden" id="isUpper" name="isUpper"/>
			</td>
		</tr>
		
		<tr>
			<th scope="col">사용여부</th>
			<td>
				<select name="popupInsertUseFlag" id="popupInsertUseFlag" style="width:270px">
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:right;">
				<input type="button" id="btnInsert" name="btnInsert" value="저장" class="btn btn_basic" onclick="javascript:fnGoSave();" alt="저장"/>
			</td>
		</tr>
	</table> 
</body> 
</html> 