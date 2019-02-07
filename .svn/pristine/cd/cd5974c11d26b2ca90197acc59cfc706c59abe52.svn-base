package daewooInfo.cmmn;

import java.awt.Color;

import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.CMYKColor;
import com.lowagie.text.pdf.ColumnText;
import com.lowagie.text.pdf.PdfWriter;
public class PdfPageEvent {
 
    // Watermark 폰트 설정
//  Font FONT = new Font(FontFamily.HELVETICA, 52, Font.BOLD, new GrayColor(0.75f));
	private BaseFont bf;
    Font FONT;
     
    Phrase[] header = new Phrase[2];
    int pagenumber;
     
	public void Pdf_Common_Style() throws Exception{
		//글자 타입이 3개 밖에없다 젠장...
		// HYSMyeongJo-Medium  
		// HYSMyeongJoStd-Medium 
		// HYGoThic-Medium
		String name = "HYSMyeongJoStd-Medium";
		String encoding = "UniKS-UCS2-H";
		bf = BaseFont.createFont( name, encoding, BaseFont.NOT_EMBEDDED );
		FONT = new Font(bf);
	}
	
    public void onOpenDocument(PdfWriter writer, Document document) {
        header[0] = new Phrase("2015. 01. 07"); // 헤더 머릿말에 넣을 텍스트
    }
     
    public void onChapter(PdfWriter writer, Document document,
            float paragraphPosition, Paragraph title) {
        header[1] = new Phrase(title.getContent());
                pagenumber = 1;
    }
 
    public void onStartPage(PdfWriter writer, Document document) {
        pagenumber++;
    }
     
    public void onEndPage(PdfWriter writer, Document document) throws Exception {
    	Pdf_Common_Style();
        Rectangle rect = writer.getBoxSize("boxName"); // boxName을 PdfWriter.setBoxSize의 boxname 매개 변수와 같게 해야 함.
         
        switch (writer.getPageNumber() % 2) { // 쪽수 쪽, 홀수 쪽 구분해서 속성 적용.
        case 0: // 짝수 쪽
            ColumnText.showTextAligned(writer.getDirectContent(),
                    Element.ALIGN_RIGHT, header[0], rect.getRight(),
                    rect.getTop(), 0);
            break;
        case 1: // 홀수 쪽
            ColumnText.showTextAligned(writer.getDirectContent(),
                    Element.ALIGN_LEFT, header[1], rect.getLeft(),
                    rect.getTop(), 0);
            break;
        }
         
        // Watermark
        ColumnText.showTextAligned(writer.getDirectContentUnder(),
                Element.ALIGN_CENTER, new Phrase("CONFIDENTIAL DOCUMENT", FONT), // 워터마크로 넣을 텍스트
                297.5f, 421, writer.getPageNumber() % 2 == 1 ? 45 : -45);
         
        // 쪽 번호 매기기
        ColumnText.showTextAligned(writer.getDirectContent(),
                Element.ALIGN_CENTER,
                new Phrase(String.format("%d", pagenumber)), // %d의 앞 뒤에 "-" 추가하면 "-1-" 이런 식..
                (rect.getLeft() + rect.getRight()) / 2, rect.getBottom() - 18, 0);
         
    }
     
}