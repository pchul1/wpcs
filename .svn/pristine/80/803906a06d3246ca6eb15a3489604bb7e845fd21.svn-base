package daewooInfo.mobile.com.utl;

import java.lang.reflect.Field;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

public class GenerateXml {
	protected StringBuffer sb = null;
	
	public final static String RESULT_CODE_F = "F";
	public final static String RESULT_CODE_S = "S";
	
	private String totalNum;
	private String listNum;
	private String pageNum;
	private String listMode;
	
	public void setTotalNum(String totalNum) {
		this.totalNum = totalNum;
	}

	public void setListNum(String listNum) {
		this.listNum = listNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public void setListMode(String listMode) {
		this.listMode = listMode;
	}

	public GenerateXml(String code, String msg){
		sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"euc-kr\" ?>");
		sb.append("<root>");
		sb.append("<result>");
		sb.append("<code>").append(code).append("</code>");
		sb.append("<msg>").append(msg).append("</msg>");
		sb.append("</result>");		
	}
	
	public void setListInfo(){
		/*
		System.out.println("TOTAL_NUM:"+list.totalNum);		
		System.out.println("LIST_NUM:"+list.listNum);
		System.out.println("PAGE_NUM:"+list.pageNum);
		System.out.println("LIST_MODE:"+list.listMode);
		*/
		sb.append("<list_info>");
		sb.append("<total_num>").append(this.totalNum).append("</total_num>");
		sb.append("<list_num>").append(this.listNum).append("</list_num>");
		sb.append("<page_num>").append(this.pageNum).append("</page_num>");
		sb.append("<list_mode>").append(this.listMode).append("</list_mode>");
		sb.append("</list_info>");
	}
	
	public <T> void setList(List<T> list) throws Exception{
		if(list != null){
			Field[] fields = list.get(0).getClass().getDeclaredFields();
			String[] columns = new String[fields.length];
			for(int i=0; i<fields.length ; i++){
				columns[i] = fields[i].getName();
			}
			
			sb.append("<list>");
			int cnt = 1;
			for(T t : list){
				sb.append("<row>");
				for(int i = 0; i < columns.length; i++){
					
					sb.append("<"+ columns[i] +">").append(BeanUtils.getProperty(t, columns[i])).append("</"+ columns[i] +">");
				}
				//sb.append("<row_class>").append(rs.getString("row_class")).append("</row_class>");
				sb.append("<row_class>").append("</row_class>");
				sb.append("<__ord>").append(cnt++).append("</__ord>");
				//sb.append("<__asc>").append(rs.getString("__asc")).append("</__asc>");
				sb.append("<__asc>").append("</__asc>");
				sb.append("</row>");
			}
			sb.append("</list>");
		}
	}
	
	public <T> void setData(List<T> list) throws Exception {
		if(list != null){
			Field[] fields = list.get(0).getClass().getDeclaredFields();
			String[] columns = new String[fields.length];
			for(int i=0; i<fields.length ; i++){
				columns[i] = fields[i].getName();
			}
			
			sb.append("<data>");
			for(T t : list){
				for(int i = 0; i < columns.length; i++){
					sb.append("<"+ columns[i] +">").append(BeanUtils.getProperty(t, columns[i])).append("</"+ columns[i] +">");
				}
			}
			sb.append("</data>");
		}
	}
	
	public void append(String str){
		sb.append(str);
	}
	
	public String toString(){
		sb.append("</root>");
		return sb.toString();
	}

}
