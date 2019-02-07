package daewooInfo.waterpolmnt.waterinfo.view;

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
import com.softwarefx.chartfx.server.AxisPosition;
import com.softwarefx.chartfx.server.ChartServer;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.Stacked;
import com.softwarefx.chartfx.server.TitleCollection;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.adornments.GradientBackground;
import com.softwarefx.chartfx.server.adornments.SimpleBorder;
import com.softwarefx.chartfx.server.adornments.SimpleBorderType;

import daewooInfo.waterpolmnt.waterinfo.bean.LimitViewVO;

//import daewooInfo.waterpolmnt.situationctl.view.ItemShape;

public class DefiniteDataChart extends AbstractView implements Ordered {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(DefiniteDataChart.class);
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
		List<LimitViewVO> lastYearList = (List<LimitViewVO>)model.get("lastYearList");
		List<LimitViewVO> YearList = (List<LimitViewVO>)model.get("YearList");
		String chartWidth = (String)model.get("width");
		String chartHeight = (String)model.get("height");
		if("null".equals(chartWidth)) chartWidth = "680";
		if("null".equals(chartHeight)) chartHeight = "500";
		double MaxY = 0;
		ChartServer chart1 = new ChartServer(getServletContext(),request,response);
		Resource resource = new ServletContextResource(getServletContext(),getChartTemplatePath());
		chart1.importChart(FileFormat.XML, resource.getFile().getPath());
		
		chart1.setContextMenus(false);
		
		chart1.setWidth(Integer.parseInt(chartWidth));
		chart1.setHeight(Integer.parseInt(chartHeight));
		chart1.getPlotAreaMargin().setTop(35);
		
		//외곽 테두리 없애기
		SimpleBorder myBorder = new SimpleBorder();
		myBorder.setType(SimpleBorderType.NONE);
		chart1.setBorder(myBorder);

		//그라데이션 없애기
		GradientBackground myBorder1 = new GradientBackground();
		myBorder1.setEffectArea(0);
		chart1.setBackground(myBorder1);
		chart1.getToolBar().setVisible(false); 

		//차트 bar
		chart1.setGallery(Gallery.LINES);
//		chart1.getAllSeries().setStacked(Stacked.NORMAL);
		
		TitleDockable chartTitle = new TitleDockable();
		chartTitle.setAlignment(StringAlignment.CENTER);
		chartTitle.setFont(new java.awt.Font("굴림체",java.awt.Font.BOLD,10));
		chartTitle.setText(title);
		chartTitle.setTextColor(new java.awt.Color(99, 101, 99));		

		TitleCollection tc = chart1.getTitles();	
		tc.add(chartTitle);		
		
		chart1.getAxisY().getLabelsFormat().setCustomFormat("#0.##");
		chart1.getAxisY2().getLabelsFormat().setCustomFormat("#0.##");
		
		
		//sub Y축 관련
		chart1.getAxisY2().setVisible(true);
		chart1.getAxisY2().setPosition(AxisPosition.FAR);
		
//		chart1.getView3D().setEnabled(true);
		
		chart1.getData().clear();
		chart1.getData().setSeries(3); 
		chart1.getData().setPoints(1); 

		//SUB Y축 관련
//		lastYearList YearList
		int i =0;
		
		LimitViewVO vo1;
		LimitViewVO vo2;
		
		for(i=0 ; i < ((lastYearList.size() > YearList.size()) ? lastYearList.size() : YearList.size())  ; i++){
			
			vo1 = new LimitViewVO();
			vo2 = new LimitViewVO();
			
			if(lastYearList.size() > i){
				vo1 = lastYearList.get(i); 
			}
			if(YearList.size() > i){
				vo2 = YearList.get(i);
			}
			
			
			chart1.getData().set(1, i, Double.valueOf((null != vo1.getMin_vl() ? vo1.getMin_vl() : "0")));
			chart1.getData().set(2, i, Double.valueOf((null != vo2.getMin_vl() ? vo2.getMin_vl() : "0")));
			
			if(MaxY < Double.valueOf((null != vo1.getMin_vl() ? vo1.getMin_vl() : "0"))) MaxY = Double.valueOf((null != vo1.getMin_vl() ? vo1.getMin_vl() : "0"));
			if(MaxY < Double.valueOf((null != vo2.getMin_vl() ? vo2.getMin_vl() : "0"))) MaxY = Double.valueOf((null != vo2.getMin_vl() ? vo2.getMin_vl() : "0"));
			 
			chart1.getData().getLabels().set(i, (null != vo1.getMin_time() ? vo1.getMin_time() : vo2.getMin_time()));

			//Sub Y축 관련
		}
		
		MaxY = Math.ceil((MaxY+(MaxY*0.1)));
		
		chart1.getAxisY().setMax(MaxY);
//		
		int y = 0;
		if(null != lastYearList) chart1.getSeries().get(++y).setText("확정 후");
		if(null != YearList) chart1.getSeries().get(++y).setText("확정 전");
//		chart1.getLegendBox().setVisible(false);
//		
//		chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
//		chart1.getLegendBox().setDock(DockArea.RIGHT);
//		chart1.getLegendBox().setDock(DockArea.TOP);
//		chart1.getLegendBox().setContentLayout(ContentLayout.CENTER);
//		chart1.getLegendBox().setHeight(0);
//		chart1.getLegendBox().setWidth(60);
//		Font font = new Font(null, 0, 10);
//		chart1.getLegendBox().setFont(font);
	
		chart1.getAxisX().setStaggered(false);
		
		chart1.setAntialiasing(true);
		
		//서버에 capture 파일 생성
		chart1.renderControl();
		
		// 로컬에 capture 파일 생성
		//chart1.renderToStream();
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
