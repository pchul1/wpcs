package daewooInfo.cmmn.view;

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
import com.softwarefx.chartfx.server.AxisStyles;
import com.softwarefx.chartfx.server.AxisX;
import com.softwarefx.chartfx.server.ChartServer;
import com.softwarefx.chartfx.server.DockArea;
import com.softwarefx.chartfx.server.FileFormat;
import com.softwarefx.chartfx.server.Gallery;
import com.softwarefx.chartfx.server.Stacked;
import com.softwarefx.chartfx.server.TitleCollection;
import com.softwarefx.chartfx.server.TitleDockable;
import com.softwarefx.chartfx.server.adornments.GradientBackground;
import com.softwarefx.chartfx.server.adornments.SimpleBorder;
import com.softwarefx.chartfx.server.adornments.SimpleBorderType;

import daewooInfo.cmmn.bean.ChartVO;

//import daewooInfo.waterpolmnt.situationctl.view.ItemShape;

public class MainChart extends AbstractView implements Ordered {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(MainChart.class);
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
		List<ChartVO> List = (List<ChartVO>)model.get("List");
		String chartWidth = (String)model.get("width");
		String chartHeight = (String)model.get("height");
		if("null".equals(chartWidth)) chartWidth = "680";
		if("null".equals(chartHeight)) chartHeight = "500";
		Double MaxY = 0.0;
		
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
		chart1.setGallery(Gallery.BAR);
		chart1.getAllSeries().setStacked(Stacked.NORMAL);
		
		/*TitleDockable chartTitle = new TitleDockable();
		chartTitle.setAlignment(StringAlignment.CENTER);
		chartTitle.setFont(new java.awt.Font("굴림체",java.awt.Font.BOLD,10));
		chartTitle.setText(title);
		chartTitle.setTextColor(new java.awt.Color(99, 101, 99));		

		TitleCollection tc = chart1.getTitles();	
		tc.add(chartTitle);*/		
		
		chart1.getAxisY().getLabelsFormat().setCustomFormat("#0.##");
		chart1.getAxisY2().getLabelsFormat().setCustomFormat("#0.##");
		
		
		//sub Y축 관련
		chart1.getAxisY2().setVisible(true);
		chart1.getAxisY2().setPosition(AxisPosition.FAR);
		
//		chart1.getView3D().setEnabled(true);
		
		chart1.getData().clear();
		chart1.getData().setSeries(2); 
		chart1.getData().setPoints(16); 

		/*chart1.getSeries().get(0).setVolume((short)25);
		chart1.getSeries().get(1).setVolume((short)25);
		chart1.getSeries().get(2).setVolume((short)25);
		chart1.getSeries().get(3).setVolume((short)25);*/
		//SUB Y축 관련
	
		/*for(int i=0;i<chart1.getData().getSeries();i++) {
			for(int j=0;j<chart1.getData().getPoints();j++) {
				chart1.getData().set(1, 0, Double.valueOf(List.get());
				chart1.getData().set(2, 0, Double.valueOf(vo.getParam1_y()));
			}
		}*/
		int i=0;
		for(ChartVO vo : List) {
			
			chart1.getData().set(1, i, Double.valueOf(vo.getParam1_y()));
			chart1.getData().set(2, i, Double.valueOf(vo.getParam1_n()));
			chart1.getData().set(1, i+1, Double.valueOf(vo.getParam2_y()));
			chart1.getData().set(2, i+1, Double.valueOf(vo.getParam2_n()));
			chart1.getData().set(1, i+2, Double.valueOf(vo.getParam3_y()));
			chart1.getData().set(2, i+2, Double.valueOf(vo.getParam3_n()));
			chart1.getData().set(1, i+3, Double.valueOf(vo.getParam4_y()));
			chart1.getData().set(2, i+3, Double.valueOf(vo.getParam4_n()));
			
			//MaxY = Double.valueOf(vo.getParam1_all());
			if(MaxY < Double.valueOf(vo.getParam1_all())) MaxY = Double.valueOf(vo.getParam1_all());
			if(MaxY < Double.valueOf(vo.getParam2_all())) MaxY = Double.valueOf(vo.getParam2_all());
			if(MaxY < Double.valueOf(vo.getParam3_all())) MaxY = Double.valueOf(vo.getParam3_all());
			if(MaxY < Double.valueOf(vo.getParam4_all())) MaxY = Double.valueOf(vo.getParam4_all());
			
			//MaxY = Math.ceil((MaxY+(MaxY*0.1)));
			chart1.getAxisY().setMax(MaxY);
			/*chart1.getData().getLabels().set(i, "유류유출");
			chart1.getData().getLabels().set(i+1, "물고기폐사");
			chart1.getData().getLabels().set(i+2, "화학물질");
			chart1.getData().getLabels().set(i+3, "기타");*/
			
			/*chart1.getAxisX().getLabels().set(i, "유류유출");
			chart1.getAxisX().getLabels().set(i+1, "물고기폐사");
			chart1.getAxisX().getLabels().set(i+2, "화학물질");
			chart1.getAxisX().getLabels().set(i+3, "기타");*/
			//chart1.getAxisX().setLabelAngle((short) 45);

			//Sub Y축 관련
			i=i+4;
		}
		
		chart1.getAxisX().setFont(new java.awt.Font("굴림",java.awt.Font.PLAIN,10));
		
		chart1.getAxisX().getGrids().getMajor().setVisible(false);
		//chart1.getAxisY().getGrids().getMajor().setVisible(false);
		chart1.getAxisX().getLabels().set(0, "유류유출");
		chart1.getAxisX().getLabels().set(1, "물고기폐사");
		chart1.getAxisX().getLabels().set(2, "화학물질");
		chart1.getAxisX().getLabels().set(3, "기타");
		chart1.getAxisX().getLabels().set(4, "유류유출");
		chart1.getAxisX().getLabels().set(5, "물고기폐사");
		chart1.getAxisX().getLabels().set(6, "화학물질");
		chart1.getAxisX().getLabels().set(7, "기타");
		chart1.getAxisX().getLabels().set(8, "유류유출");
		chart1.getAxisX().getLabels().set(9, "물고기폐사");
		chart1.getAxisX().getLabels().set(10, "화학물질");
		chart1.getAxisX().getLabels().set(11, "기타");
		chart1.getAxisX().getLabels().set(12, "유류유출");
		chart1.getAxisX().getLabels().set(13, "물고기폐사");
		chart1.getAxisX().getLabels().set(14, "화학물질");
		chart1.getAxisX().getLabels().set(15, "기타");
		chart1.getAxisX().setLabelAngle((short) 45);
		/*chart1.getAxisX().getLabels().set(0, "유출");
		chart1.getAxisX().getLabels().set(1, "폐사");
		chart1.getAxisX().getLabels().set(2, "화학");
		chart1.getAxisX().getLabels().set(3, "기타");
		chart1.getAxisX().getLabels().set(4, "유출");
		chart1.getAxisX().getLabels().set(5, "폐사");
		chart1.getAxisX().getLabels().set(6, "화학");
		chart1.getAxisX().getLabels().set(7, "기타");
		chart1.getAxisX().getLabels().set(8, "유출");
		chart1.getAxisX().getLabels().set(9, "폐사");
		chart1.getAxisX().getLabels().set(10, "화학");
		chart1.getAxisX().getLabels().set(11, "기타");
		chart1.getAxisX().getLabels().set(12, "유출");
		chart1.getAxisX().getLabels().set(13, "폐사");
		chart1.getAxisX().getLabels().set(14, "화학");
		chart1.getAxisX().getLabels().set(15, "기타");*/
		chart1.getAxisX().setStaggered(false);
		
		AxisX axis = new AxisX();
		axis.setVisible(true);
		axis.setMin(0);
		axis.setMax(16);
		axis.setStep(4);
		axis.setPosition(AxisPosition.FAR);
		//axis.getGrids().setInterlaced(true);
		//axis.getGrids().getMajor().setVisible(true);
		//axis.getGrids().getMajor().setColor(new java.awt.Color(135, 206, 250));
		//axis.getLabels().set(3,"1st Quarter");
		//axis.getLabels().set(6,"2nd Quarter");
		//axis.getLabels().set(9,"3rd Quarter");
		//axis.getLabels().set(12,"4rd Quarter");
		java.util.EnumSet<AxisStyles> style = axis.getStyle();
        style.add(AxisStyles.CENTERED);
        axis.setStyle(style);
        chart1.getLegendBox().setVisible(false);
        axis.getLabels().set(4,"한강");
        axis.getLabels().set(8,"낙동강");
        axis.getLabels().set(12,"금강");
        axis.getLabels().set(16,"영산강");
		chart1.getAxesX().add(axis);
		
//		
//		chart1.getSeries().get(1).setText("지원");
//		chart1.getSeries().get(2).setText("접수");
		chart1.getLegendBox().setVisible(false);
//		
//		chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
//		chart1.getLegendBox().setDock(DockArea.RIGHT);
		chart1.getLegendBox().setDock(DockArea.TOP);
//		chart1.getLegendBox().setContentLayout(ContentLayout.CENTER);
		chart1.getLegendBox().setHeight(0);
//		chart1.getLegendBox().setWidth(60);
//		Font font = new Font(null, 0, 10);
//		chart1.getLegendBox().setFont(font);
	
		//chart1.getAxisX().setStep(1);
		//chart1.getAxisX().setStaggered(false);
		
		chart1.setAntialiasing(true);
		
		//서버에 capture 파일 생성
		//chart1.renderControl();
		
		// 로컬에 capture 파일 생성
		chart1.renderToStream();
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
