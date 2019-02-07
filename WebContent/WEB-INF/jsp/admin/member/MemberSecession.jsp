<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
 /**
  * @Class Name  : MemberSecession.jsp
  * @Description : 회원탈퇴  화면
  * @Modification Information
  * @
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2016.11.16             최초 생성
  *
  *  @author KANG JI NAM
  *  @since 2016.11.16
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
<script type="text/javascript" src="<c:url value="/js/admin/menu/MyMenuList.js" />"></script>
<script type="text/javascript">
function fnMemberSecession(){
	var radio_policy = $('input[name="radio_policy"]:checked').val();
	
	if(radio_policy=='N'){
		alert("동의하지 않는 경우 회원탈퇴를 진행 하실 수 없습니다.");
		return;
	}else{
		//document.memberVO.action = "<c:url value='/common/login/actionLogout.do'/>";
		document.memberVO.action = "<c:url value='/common/member/MemberRemove.do'/>";
		document.memberVO.submit();
	}
}
</script>
<style type="text/css">
.info_agree {
    overflow: hidden;
    padding: 42px 50px 29px;
    border-top: 1px solid #e1e1e1;
    border-bottom: 1px solid #e1e1e1;
    background-color: #fbfbfb;
}
.info_user .tit_agree {
    display: block;
    margin-right: 30px;
    padding-bottom: 13px;
    font-size: 14px;
    line-height: 24px;
    letter-spacing: -1px;
}
</style>

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
						
						<div class="info_user">
			                <strong class="tit_agree">아이디 재사용 및 복구 불가 안내</strong><br>
			                <span class="txt_agree">회원탈퇴 진행 시 본인을 포함한 타인 모두 <em class="emph_g">아이디 재사용이나 복구가 불가능합니다.</em><br>
			                신중히 선택하신 후 결정해주세요.</span>
			               <br><br>
			              </div>
			              
			              <div class="info_user">
			                <strong class="tit_agree">개인정보 기록 삭제 안내</strong><br>
			                <span class="txt_agree">연락처 및 내정보는 모두 삭제되며,<em class="emph_g">삭제된 데이터는 복구되지 않습니다.</em></span>
			                <br><br>
			              </div>
			              
			              <div class="info_user">
			                <strong class="tit_agree">게시판형 서비스에 등록한 게시글 삭제 불가 안내</strong><br>
			                <span class="txt_agree">삭제를 원하는 게시글이 있다면 반드시 회원탈퇴 전 삭제하시기 바랍니다.<br>탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어, <em class="emph_g">게시글을 임의로 삭제해드릴 수 없습니다.</em></span>
			                <br><br>
			              </div>
			            </div>
						<br><br><br><br><br><br><br>
						<form:form commandName="memberVO" name="memberVO" method="post" >	
							<input type="hidden" name="memberId" value="${memberVO.memberId}"/>
							<h4>회원탈퇴동의</h4>
							
							<span>
								<strong>동의 하지 않는 경우 회원탈퇴를 진행 하실 수 없습니다.</strong>
							</span>
							<span style="padding-left:300px;">
								<input type="radio" name="radio_policy" value="Y"/>동의&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="radio_policy" checked="checked" value="N"/>동의하지 않음
							</span>
						
						</form:form>							
						<div style="padding-top:20px;text-align:right;cursor:pointer;">
							<a href="javascript:fnMemberSecession();"><img src="/images/new/btn_apply.gif" alt="신청하기"/></a>
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
</body>
</html>