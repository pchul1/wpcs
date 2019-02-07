<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : ipusn.jsp
  * @Description : IP-USN 모니터링  화면
  * @Modification Information
  * @
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.17             최초 생성
  *  2013.10.20             리뉴얼
  *
  *  @author kisspa
  *  @since 2010.07.02
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
function goSubmit(){
	var obj = document.form1;

	if(!obj.files.value){
		alert("파일을 첨부하십시오.");
		obj.files.focus();
		return false;
	}
	
	ban = obj.files.value.substring(obj.files.value.lastIndexOf('.'),obj.files.value.length).toLowerCase();    
	if(ban != ".txt"){
		alert(".txt파일만 첨부 하실수 있습니다.");
		obj.files.focus();
		return false;
	}
	
	obj.action = "/ipusn/ipusn_dump.do";
	obj.submit();
}
function goSample(){
	location.href="/cmmn/Sample.do";
}
</script>
</head>
<body>
	
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="/images/common/ajax-loader2.gif" alt="로딩중.." />
	</div>
	<div id="wrap">
	
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->

				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						<input id="userId"type="hidden" value="<sec:authentication property="principal.userVO.id"/>"/>
						<div class="table_wrapper">
							<form id="form1" action="" name="form1" method="post" enctype="multipart/form-data">
								<div style="clear:both;">
								<table style="text-align:left" summary="관리자정보">
									<colgroup>
										<col width="25%">
										<col>
									</colgroup>									
									<tr>
										<th>이동형측정기기 로그파일 <span class="red">*</span></th>
										<td>
											<input type="file" name="files" id="files" size="50" class="tbox03">
										</td>
									</tr>
								</table>
								</div>
								<div id="btSmallArea" style="text-align:right;padding-top:10px;">
									<div style="float:left;">
										<input type="button" id="btnAddNotice" name="btnAddNotice" value="작성방법보기" class="btn btn_basic" onclick="$('#writemethod').css('display') == 'none' ? $('#writemethod').css('display','') : $('#writemethod').css('display','none');" alt="작성방법보기" />
									</div>
									<div style="float:right;">
										<input type="button" id="btnAddNotice" name="btnAddNotice" value="샘플 파일 다운로드" class="btn btn_basic" onclick="goSample();" alt="샘플 파일 다운로드" />
										<span id="menuAuth1">
										<input type="button" id="btnAddNotice" name="btnAddNotice" value="저장" class="btn btn_basic" onclick="goSubmit();" alt="저장" />
										</span>
									</div>
								</div>
							</form>	
						</div>
						<div id="writemethod" class="table_wrapper" style="position:relative;clear:both;text-align:left;padding-left:10px;border: 3px solid rgb(7, 175, 250); margin-top:50px;border-image: none;padding:20px;display:none;">
							<div style="position: absolute; font-size: 20pt; right: 15px; top: 5px;"><a href="#" onclick="$('#writemethod').css('display') == 'none' ? $('#writemethod').css('display','') : $('#writemethod').css('display','none');">X</a></div>
							<div>1.측정소코드와 날짜를 입력합니다. (필수값)</div>
							<div>&nbsp;&nbsp;ex) 2015년 03월 03일 12시 00분의 지점코드가 S01011이고 측정소번호가 01값을 입력할 경우</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FC=지점코드:측정소번호&DATE=날짜{년도(4자) : 월(2자) : 일(2자) : 시간(24단위) : 분(2자)} 총 12자       </div>
							<div style="color:blue;margin-top:5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▶ FC=S01011:01&DATE=201503031200</div>
							
							<div style="margin-top:20px;">2. 수질항목을 입력합니다. (선택값)</div>
							<div>&nbsp;&nbsp;ex) 탁도 수치가 21.502 ph 수치가 07.326이며 장비 상태가 정상을 입력할 경우</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수질항목=수치:장비상태 </div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;수질항목 : TMP00 = 수온 ,PHY00 = ph, DOW00 = DO, CON00 = EC, TUR00 = 탁도, TOF00 = 클로로필-a</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;장비상태 : 00:장비정상, 01:가동중지, 02:유량없음, 03:교정중, 04:정검/보수중, 05:통신불량, </div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;06:장비이상, 07:전원이상, 08:시운전, 09:재전송</div>
							<div style="color:blue;margin-top:5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▶ TUR00=21.502:00&PHY00=07.326:00 </div>
							
							<div style="margin-top:20px;">3. 측정소 현재 정보를 입력합니다. (선택값)</div>
							<div>&nbsp;&nbsp;&nbsp;ex)위도 3736.6765, 경도 12708.8614, 고도 18.7, 배터리 12.165, 온도 29.1, 습도 46.1을 입력할 경우 </div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위도=좌표값&경도=좌표값&고도=수치&배터리=값&온도=수치&습도=수치</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이동형측정기기 측정소 정보 : LAT = 위도 , LON = 경도, ALT = 고도, BAT = 배터리, CEl = 온도, HUM = 습도</div>
							<div style="color:blue;margin-top:5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▶ LAT=3736.6765&LON=12708.8614&ALT=18.7&BAT=12.165&CEL=29.1&HUM=46.1</div>
							
							<div style="margin-top:20px;">4. 1,2,3을 합쳐서 하나의 로그 파일을 만듭니다.</div>
							
							<div style="color:blue;margin-top:5px;">FC=S01011:01&DATE=201503031200&TUR00=21.502:00&PHY00=07.326:00&LAT=3736.6765&LON=12708.8614&ALT=18.7&BAT=12.165&CEL=29.1&HUM=46.1</div>
							
							<div style="color:red;margin-top:20px;">※주의사항※</div>
							<div style="color:red">TXT파일로 등록해야 합니다.</div>
							<div style="color:red">띄어쓰기 없이 작성해야 하며, 필수값은 반드시 입력하셔야 합니다. (띄어쓰기 구분은 “&” 으로 표시합니다.)</div>
							<div style="color:red">샘플파일을 다운 받으시면 예시로 작성된 파일이 있으니 참고하시기 바랍니다.</div>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
	<script language="javascript">
		function menuAuth(auth) {
			var iauthC = "";
			var iauthU = "";
			var iauthD = "";
			if (auth == "C") {
				iauthC = "Y";
			}
			if (auth == "U") {
				iauthU = "Y";
			}
			if (auth == "D") {
				iauthD = "Y";
			}
			var menuAuth = "";
			$.ajax({
				type : "post",
				url : "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
				dataType : "json",
				async : false,
				data : {
					userId : $("#userId").val(),
					menuId : $("#naviMenuNo").val(),
					authC : iauthC,
					authU : iauthU,
					authD : iauthD
				},
				success : function(result) {
					var tot = 0;
					tot = result['getUserMenuAuthorCount'];
					menuAuth = tot;
				}
			});
			return menuAuth;
		}
		if ("1" == menuAuth("U")) {
			$("#menuAuth1").show();
		} else {
			$("#menuAuth1").hide();
		}
	</script>
</body>
</html>