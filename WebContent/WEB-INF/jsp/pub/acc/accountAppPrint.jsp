<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript">
//<![CDATA[
	function fnPrint(){
		$('#btnPrint').hide();
		window.print();
		window.close();
	}
//]]>
</script>
</head>
<body>
<!-- wrap -->
<div class="section_popup">
  	<div class="section_membership">
        <div style="padding-top:10px;">   
    		<div class="title">
       		<h3>계정신청</h3>
    		</div>
            
            <div class="section_table04">
            <table>
            	  <colgroup>
						<col width="200" />
						<col />
					</colgroup>
                  <tbody>
 	                 <tr>
						<th>관련기관</th>
						<td class="td_left">
							${memberVO.deptNoName}
						</td>
					</tr>
					<tr>
						<th>직급(위)</th>
						<td class="text_l">
							${memberVO.gradeName}
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td class="text_l">
							${memberVO.memberName}
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td class="text_l">
							${memberVO.memberId}
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td class="text_l">
							${memberVO.email}
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td class="text_l">
							<div style="margin-top:5px">
								사무실: ${memberVO.officeNo}
							</div>
							<div style="margin-top:5px">
								핸드폰:${memberVO.mobileNo}
							</div>
							<div style="margin-top:5px; margin-bottom:5px;">
								<span style="margin-right:12px;">팩</span>스:${memberVO.faxNum}
							</div>
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<td class="text_l">
							${memberVO.bigo}
						</td>
					</tr>
                  </tbody>
                </table>
            	<p class="float_r"><a href="javascript:fnPrint();"><img src="/images/new/btn_print.gif" alt="인쇄" id="btnPrint"/></a></p>
            </div>
        
        </div>
    
    </div>
  
  </div>

</body>
</html>