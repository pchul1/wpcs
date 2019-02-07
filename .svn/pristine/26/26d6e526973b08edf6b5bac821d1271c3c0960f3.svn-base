package daewooInfo.waterpolmnt.situationctl.view;

import java.awt.Color;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.Ordered;
import org.springframework.core.io.Resource;
import org.springframework.web.context.support.ServletContextResource;
import org.springframework.web.servlet.view.AbstractView;

import com.softwarefx.StringAlignment;
import com.softwarefx.chartfx.server.AxisSection;
import com.softwarefx.chartfx.server.ChartServer;
import com.softwarefx.chartfx.server.ContentLayout;
import com.softwarefx.chartfx.server.DockArea;
import com.softwarefx.chartfx.server.DockBorder;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.TitleCollection;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.adornments.GradientBackground;
import com.softwarefx.chartfx.server.adornments.SimpleBorder;
import com.softwarefx.chartfx.server.adornments.SimpleBorderType;

public class PopupChartView extends AbstractView implements Ordered {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(PopupChartView.class);
	/**
	 * @uml.property  name="chartTemplatePath"
	 */
	private String chartTemplatePath;
	/**
	 * @uml.property  name="order"
	 */
	private int order = Integer.MAX_VALUE;
	
	@SuppressWarnings("unchecked")
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		
		String title = (String)model.get("title");
		String renderStyle = (String)model.get("renderStyle");
		List<String> itemNameList = (List<String>)model.get("itemNameList");
		List<String> itemCodeList = (List<String>)model.get("itemCodeList");
		List<String> itemMinorList = (List<String>)model.get("itemMinorList");
		Map<String, List> itemDataMap = (Map<String, List>)model.get("itemDataMap");
		//String constLine = (String)model.get("constLine");
		//Map<String, String> constantMap = (Map<String, String>)model.get("constantMap");
		Integer itemDataSize = (Integer)model.get("itemDataSize"); 
		String chartWidth = (String)model.get("width");
		String chartHeight = (String)model.get("height");
		String legBox = (String)model.get("legBox");
		int chartType = (Integer)model.get("chartType");
		String axisTitleYn = (String)model.get("axisTitleYn");
		String axisXTitle = (String)model.get("axisXTitle");
		String axisYTitle = (String)model.get("axisYTitle");
		String sys = (String)model.get("sys");
		Float lawVl = (Float)model.get("lawVl");
		if("null".equals(chartWidth)) chartWidth = "680";
		if("null".equals(chartHeight)) chartHeight = "500";
		Double MaxY = 0.0;
		
		Double dLawVl = null;
		try
		{
			dLawVl = (double)lawVl;
		}
		catch(Exception e)
		{
			dLawVl = 50D;
		}
		
		ChartServer chart1 = new ChartServer(getServletContext(),request,response);
		Resource resource = new ServletContextResource(getServletContext(),getChartTemplatePath());
		chart1.importChart(FileFormat.XML, resource.getFile().getPath());
		
		chart1.setContextMenus(false);
		
		chart1.setWidth(Integer.parseInt(chartWidth));
		chart1.setHeight(Integer.parseInt(chartHeight));
		
		//외곽 테두리 없애기
		SimpleBorder myBorder = new SimpleBorder();
		myBorder.setType(SimpleBorderType.NONE);
		chart1.setBorder(myBorder);

		//그라데이션 없애기
		GradientBackground myBorder1 = new GradientBackground();
		myBorder1.setEffectArea(0);
		chart1.setBackground(myBorder1);
		
		chart1.getToolBar().setVisible(false); 
		
		if(legBox.equals("Y")) 
			chart1.getLegendBox().setVisible(true); 
		else 
			chart1.getLegendBox().setVisible(false); 

		switch(chartType) {
			case 1 :
				chart1.setGallery(Gallery.LINES);
				break;
			case 2 :
				chart1.setGallery(Gallery.BAR);
//				chart1.getAllSeries().setHorizontal(true); 차트를 세로로...
				break;
			case 3 :
				chart1.setGallery(Gallery.SCATTER);
				break;
			default :
				chart1.setGallery(Gallery.LINES);
		}

		
		TitleDockable chartTitle = new TitleDockable();
		chartTitle.setAlignment(StringAlignment.CENTER);
		chartTitle.setFont(new java.awt.Font("굴림체",java.awt.Font.BOLD,6));
		chartTitle.setText(title);
		chartTitle.setTextColor(new java.awt.Color(99, 101, 99));

		TitleCollection tc = chart1.getTitles();
		tc.add(chartTitle);
		
		chart1.getAxisX().setLabelAngle((short)75);
		chart1.getAxisX().getLabelsFormat().setCustomFormat("#0.###");
		chart1.getAxisY().getLabelsFormat().setCustomFormat("#0.###");
		
		if(axisTitleYn != null && axisTitleYn.equals("Y")) {
			chart1.getAxisX().getTitle().setText(axisXTitle);
			chart1.getAxisY().getTitle().setText(axisYTitle);
		}		
				
		chart1.getData().clear();
		chart1.getData().setSeries(itemCodeList.size()); 
		chart1.getData().setPoints(itemDataSize.intValue()); 
		
		
		String cd = "";
		if(itemCodeList.size() > 0)
		{
			cd = itemCodeList.get(0);
		}
		
		if("T".equals(sys))
		{
			if(itemCodeList.size() > 0)
			{
				cd = itemCodeList.get(0);
			
				if(cd.equals("TUR00") || cd.equals("TUR"))
				{
					//경계선 표시
					AxisSection as = new AxisSection();
					as.setFrom(50);
					as.setTo(50.1);
					as.setBackColor(new Color(255, 153, 51));
					as.setVisible(true);
					chart1.getAxisY().getSections().add(as);
				}
			}
		}
		
		//log.debug("itemCodeList.size ==== "+itemCodeList.size());
		for( int i=0; i < itemCodeList.size(); i++) {
			String code = itemCodeList.get(i);
			List<Map> dataList = itemDataMap.get(code);

			if(dataList.size() ==  1)
				chart1.getAllSeries().setVolume((short)10);
			else if(dataList.size() == 2)
				chart1.getAllSeries().setVolume((short)15);
			else if(dataList.size() == 3)
				chart1.getAllSeries().setVolume((short)20);
			else if(dataList.size() == 4)
				chart1.getAllSeries().setVolume((short)25);
			
			for( int j=0; j < dataList.size(); j++) {
				
				//Min or 값에 따라서 색상변화
				Color pointColor = this.getPointColor(itemMinorList.get(j));
				if(itemCodeList.size() == 1){
					chart1.getPoints().get(j).setColor(pointColor);
				}
				
				Map<String,String> data = dataList.get(j);
				String x = data.get("x");
				String y = data.get("y");
				y = y.replace(",", "");
				chart1.getData().set(i, j, Double.valueOf(y));
				if(MaxY < Double.valueOf(y)) MaxY = Double.valueOf(y) + 1.0;
				
				chart1.getData().getLabels().set(j, x);
			}
		}

		for(int i=0; i < itemNameList.size(); i++) {
			chart1.getSeries().get(i).setText(itemNameList.get(i));
		}
		
		double  maxAxisy = 0;
		for(int j=0; j<itemCodeList.size(); j++){
			//List<Map> list = itemDataMap.get(itemCodeList.get(0));
			List<Map> list = itemDataMap.get(itemCodeList.get(j));
			
			
			Map<String,String> listdata; 
			for(int i=0; i<list.size();i++)
			{
				listdata = list.get(i);
				if(null != listdata.get("y")){
					String tempY = listdata.get("y").replace(",", "");
					/*if(maxAxisy < Double.parseDouble(listdata.get("y"))){ 
						maxAxisy = Double.parseDouble(listdata.get("y"));
					}*/
					if(maxAxisy < Double.parseDouble(tempY)){ 
						maxAxisy = Double.parseDouble(tempY);
					}
				}
			}
		}

		int sub1 = 0;
		if(maxAxisy >= 10){
			sub1 = Integer.parseInt((maxAxisy + "").substring(0,1));
		}
		chart1.getAxisY().setMax(Double.parseDouble((sub1+1) + "0"));
		
		if(itemCodeList.size() == 1){
			if(maxAxisy > 99 && maxAxisy < 1000){
				chart1.getAxisY().setMax(Double.parseDouble((sub1+1) + "00"));
			}
			else if(maxAxisy > 999 && maxAxisy < 10000){
				chart1.getAxisY().setMax(Double.parseDouble((sub1+1) + "000"));
			}
		}
		//chart1.getAxisY().setMax(100);
		/*if(maxAxisy >= 10){
			sub1 = Integer.parseInt((maxAxisy + "").substring(0,1));
		}
				
		chart1.getAxisY().setMax(Double.parseDouble((sub1+1) + "0"));*/
		//chart1.getAxisY().setMax(100);
		
		//탁수모니터링시스템에서 탁수 선택시 기준값은 무조건 표시합니다
//		if(chart1.getSeries().size() == 1 && (itemCodeList.get(0).equals("TUR00") || itemCodeList.get(0).equals("TUR")))
//		{
//			if(MaxY <= dLawVl)
//			{
//				Double max = dLawVl + 20;
//				chart1.getAxisY().setMax(max);
//			}
//		}

		chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
		chart1.getLegendBox().setDock(DockArea.RIGHT);
		chart1.getLegendBox().setContentLayout(ContentLayout.CENTER);
		
		chart1.getAxisX().setStaggered(false);
		//if("Y".equals(constLine))chart1.getAxisY().setMax(MaxY);
		chart1.setAntialiasing(true);
		
		
		if(renderStyle.equals("control"))
		{
			//서버에 capture 파일 생성
			chart1.renderControl();
		}
		else {
			// 로컬에 capture 파일 생성
			chart1.renderToStream();
		}
		
	}

	
	public Color getPointColor(String minor)
	{
		if(minor == null)
			return Color.green;
		
		Color result = Color.green;
		
		if(minor.equals("0"))
		{
			float[] hsb = Color.RGBtoHSB(80, 180, 60, null);
			result = Color.getHSBColor(hsb[0], hsb[1], hsb[2]);
		}
		else if(minor.equals("1"))
			result = new Color(20, 100, 255);
		else if(minor.equals("2"))
			result = Color.yellow;
		else if(minor.equals("3"))
			result = Color.orange;
		else if(minor.equals("4"))
			result = new Color(255,74,74);
		
		return result;
	}
	
	
	/**
	 * @return
	 * @uml.property  name="chartTemplatePath"
	 */
	public String getChartTemplatePath() {
		return chartTemplatePath;
	}


	/**
	 * @param chartTemplatePath
	 * @uml.property  name="chartTemplatePath"
	 */
	public void setChartTemplatePath(String chartTemplatePath) {
		this.chartTemplatePath = chartTemplatePath;
	}


	/**
	 * @param order
	 * @uml.property  name="order"
	 */
	public void setOrder(int order) {
		this.order = order;
	}
	
	/**
	 * @return
	 * @uml.property  name="order"
	 */
	public int getOrder() {
		return this.order;
	}

}
