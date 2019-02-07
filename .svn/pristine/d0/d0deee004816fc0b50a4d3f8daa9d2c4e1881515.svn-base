<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
						<table class="dataTable">
						<colgroup>
							<col width="">
							<col width="">
							<col width="">
						</colgroup>
						<thead> 
							<tr> 
								<th>프로그램 파일명</th> 
								<th>프로그램명</th> 
								<th>URL</th> 
							</tr> 
						</thead>
						<tbody>
						<c:forEach var="result" items="${programList}" varStatus="status">
							<tr style="cursor:pointer" onClick="javascript:detailView(${result.menuNo}, ${result.upperMenuId});">
								<td>${result.progrmFileNm}</td>
								<td>${result.progrmKoreanNm}</td>
								<td>${result.url}</td>
							</tr>
						</c:forEach>
						</tbody>
						</table>
