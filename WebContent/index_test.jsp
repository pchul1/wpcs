<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%
            String sError = null;
            sError = request.getParameter("ERROR");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chart FX for Java Activation</title>
        <LINK REL ="stylesheet" TYPE="text/css" HREF="style.css" TITLE="Style">
    </head>
    <body  bgcolor="#FFFFFF">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="center" valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" valign="top" width="99%">
                                <table width="1%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td >
                                            <table width="1%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <table width="500" border="0" cellspacing="0" cellpadding="5">
                                                            <tr>
                                                                <td><img src="images/cfxjavaregtitle.gif"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                            <tr>
                                                                <td width="1"><img src="images/formbox1.gif" width="5" height="28"></td>
                                                                <td align="center" valign="bottom" background="images/formbox2.gif" class="header"></td>
                                                                <td width="1"><img src="images/formbox3.gif" width="6" height="28"></td>
                                                            </tr>
                                                            <tr>
                                                                <td background="images/formbox4.gif"><img src="images/spacer.gif" width="1" height="75"></td>
                                                                <td bgcolor="F5F7F7">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="5">
                                                                        <tr>
                                                                            <td colspan="3" > 
                                                                                <p>The information is encrypted using the standard RSA Public/Private key methodology. Our installation does not scan your hard drive or gather any personal information from your computer; therefore, no privacy issues should be of concern to our customers.</p>
                                                                                <p>Our goal is to prevent installation of serial numbers that have been obtained from fraudulent purchases, returned products, expired programs and other suspicious means.</p>
                                                                                <p>For more information on installation and licensing, please <a href="mailto:support@softwarefx.com">contact</a> Software FX, Inc.</p> 
                                                                                <p><strong>Please enter your Serial Number. This number was previously provided to you by Software FX, Inc.</strong></p>
                                                                                <%if (sError != null) {
                                                                                if (sError.equals("1")) {%>
                                                                                <p class="error">*ERROR - Invalid serial number. Please try again.</p>
                                                                                <%}%>
                                                                                <%if (sError.equals("2")) {%>
                                                                                <p class="error">*ERROR - Serial number is Development ONLY.</p>
                                                                                <%}}%>
                                                                                <form name="Form1" Action="GenerateLicense" method="post">
                                                                                    <p align="center"><INPUT type="text" NAME="SERIALNUM" WIDTH=256 HEIGHT=24></p>
                                                                                    <p><strong>Please select the type of License you want to activate:</strong></p>    
                                                                                    <p align="center"><input type="radio" name="TYPE" value="Production" checked="checked" />Production  <input type="radio" name="TYPE" value="Development" />Test/Development</p>
                                                                                    <p align="center"><INPUT name="submit" type="submit" value="Generate License"></p>
                                                                                </form>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td background="images/formbox5.gif" width="1"><img src="images/spacer.gif" width="1" height="75"></td>
                                                            </tr>
                                                            <tr>
                                                                <td><img src="images/formbox6.gif" width="5" height="7"></td>
                                                                <td background="images/formbox7.gif"><img src="images/spacer.gif" width="75" height="1"></td>
                                                                <td><img src="images/formbox8.gif" width="6" height="7"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
