<%@ Page Title="SPEX CertiPrep - Knowledge Base - Dilutilator" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="dilutulator.aspx.cs" Inherits="knowledge_dilutilator" %>
<%@ Register src="~/_controls/ShareThis.ascx" tagname="ShareThis" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        #dilutulator {
            float: left;
            padding: 20px;
            background-color: #cccccc;
            color: #fff;
            border: 1px solid #fff;
            border-radius:10px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            margin-bottom: 20px;
        }
        .dilutulator {
            -moz-background-clip:border;
            -moz-background-inline-policy:continuous;
            -moz-background-origin:padding;
            background:#EEEEEE none repeat scroll 0 0;
            border:2px solid #999999;
            color:#6F6F6F;
            font-size:48px;
            font-weight:bold;
            outline-color:-moz-use-text-color;
            outline-style:none;
            outline-width:medium;
            padding:5px;
        }
        .dilutulator:focus {
            background-color:#CBDA45;
        }
        .focus {
	        font-weight: bold;
	        font-size: 48px;
        }
        .outter_div {
	        width: 160px;
	        float: left;
        }	
        .outter_div label {
	        font-size: 14px;
	        color: #333333;
	        font-weight: bold;
        }	
        .outter_div p {
	        padding: 0 0 5px 5px; margin-bottom: 0;
        }	
        .outter_div input {
	        width: 135px;
	        font-size: 48px;
	        font-weight: bold;
        }	
    </style>	
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > Knowledge Base > Dilutulator</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Dilut-U-Lator</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
						<div class="CustomOS_logo">
							<asp:PlaceHolder ID="Image" runat="server" />
						</div>
                        <br /><br />
						<asp:PlaceHolder ID="SideContent" runat="server" />
						<uc1:ShareThis ID="ShareThis1" runat="server" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
						<asp:PlaceHolder ID="BodyContent" runat="server" />
                        <div id="dilutulator"> 
                            <div class="outter_div">
                                <p><label for="current_concentration">Concentration of<br />Concentrate (w) in ppm</label></p>
                                <input type="text" name="current_concentration" id="w" class="dilutulator digits"/>
                            </div>
                            <div class="outter_div">
                                <p><label for="final_concentration">Final Concentration <br />Desired (x) in ppm</label></p>
                                <input type="text" name="final_concentration" id="x" class="dilutulator digits" />
                            </div>
                            <div class="outter_div">
                                <p><label for="final_volume">Final Volume <br />Desired (y) in mL</label></p>
                                <input type="text" name="final_volume" id="y" class="dilutulator digits" />
                            </div>
                            <div class="outter_div">
                                <p><label for="required_volume">Volume of Concentrate<br />Required (z) in mL</label></p>
                                <input type="text" name="required_volume" id="z" class="dilutulator digits" />
                            </div>
                            <div class="dilu_buttons" style="width: 640px; clear: both; padding-top: 20px;">
                                <div id="clear" class="footer_item footer_hover" style="width: 150px;border-color: #FFFFFF; font-size: 14px; font-weight: bold; text-align: center; cursor: pointer;">CLEAR ALL</div>
                                <div id="calculate" class = "footer_item footer_checkout" style=" float: right;  width: 150px; border-color: #FFFFFF; font-size: 14px; font-weight: bold; text-align: center;">CALCULATE</div>
                            </div>
                         </div><!-- end dilutilator -->
               <div>NEW! <p>Don't have an internet connection at your lab workstation?  Download our handy Dilut-u-lator Excel spreadsheet and easily calculate your dilutions offline!</p><p><a href="images/Dilutulator.xlsx"><h2 style="float:left">Excel Dilut-u-lator</h2></a>&nbsp;&nbsp;<img src="images/excel_16x16.png" alt=".exe" width="16px" height="16px"/></p><br /><br /><p style="font-style:italic">Disclaimer: This spreadsheet is for informational purposes only.  No guarantees are made in its accuracy or fitness for use.  Use at your own discretion.  SPEX CertiPrep assumes no liability in the use of this product or the results it provides.</p></div>
                     <div id="ie_clearing"> &#160; </div>
                     </div>
              </div>
           </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
	<script type="text/javascript">

        $(document).ready(function () {

            /*
            Concentration of Concentrate (w)
            Final Concentration Desired (x)
            Final Volume Desired (y) 
            Volume of Concentrate Required (z )	
            w = (x*y)/z;
            x = (z/y)*w;	
            y = (z*w)/x;	
            z = (x*y)/w;	
            */

            var w;
            var x;
            var y;
            var z;
            var count = 0;

            // $('#dilutulator :text').bind('keyup',function() { - not using right now, using a submit button instead 
            $('#calculate').click(function () {
                $('#dilutulator :text').each(function () { //check for text box values
                    if (this.value != '') {
                        count++; //if filled, increase count
                    }
                }); //end iterate through text boxes and check for value

                if (count == 3) { //check if 3 have been filled
                    //get all values of text boxes			
                    w = $("#w").val();
                    x = $("#x").val();
                    y = $("#y").val();
                    z = $("#z").val();

                    //check for which is the empty input box, solve for missing value, set textbox of missing value
                    if (w == '') {
                        w = (x * y) / z;
                        $("#w").val(w); //set value
                        $("#w").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box
                        $("#w").addClass("focus");
                        $("#w").focus();
                    }
                    else if (x == '') {
                        x = (z / y) * w;
                        $("#x").val(x); //set value
                        $("#x").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box
                        $("#x").addClass("focus");
                        $("#x").focus();
                    }
                    else if (y == '') {
                        y = (z * w) / x;
                        $("#y").val(y); //set value
                        $("#y").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box
                        $("#y").addClass("focus");
                        $("#y").focus();
                    }
                    else {
                        z = (x * y) / w;
                        $("#z").val(z); //set value
                        $("#z").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box		
                        $("#z").addClass("focus");
                        $("#z").focus();
                    }

                    w = ''; //reset vars in case they want to enter different values and check for it again
                    x = '';
                    y = '';
                    z = '';
                    count = 0; //reset count;

                } // end check if 3 have been filled

                else { //if 3 haven't been filled, reset the count to 0 and check again on next text box key up
                    alert("You must fill 3 fields");
                    count = 0; //reset count;
                }
            }); //end function on all key ups of text boxes


            $('#clear').click(function () {
                $("#w").val(""); //set value
                $("#x").val(""); //set value
                $("#y").val(""); //set value
                $("#z").val(""); //set value
            });

        }); //end document ready
    </script>

</asp:Content>

