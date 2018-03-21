<%@ Page Title="SPEX CertiPrep - Knowledge Base - Dilutilator" Language="C#" MasterPageFile="~/Inside.master" AutoEventWireup="true" CodeFile="dilutilator.aspx.cs" Inherits="knowledge_dilutilator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        .dilutulator {
            -moz-background-clip:border;
            -moz-background-inline-policy:continuous;
            -moz-background-origin:padding;
            background:#EEEEEE none repeat scroll 0 0;
            border:2px solid #999999;
            color:#6F6F6F;
            font-size:48px;
            font-weight:bold;
            height:42px;
            outline-color:-moz-use-text-color;
            outline-style:none;
            outline-width:medium;
            padding:10px;
        }
        .focus {
	        font-weight: bold;
	        font-size: 48px;
        }
        .outter_div {
	        width: 160px;
	        float: left;
	        margin-right: 15px;
        }	
        .outter_div label {
	        font-size: 12px;
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
                    //alert ("the count is 3!");
                    //get all values of text boxes			
                    w = $("#w").val();
                    x = $("#x").val();
                    y = $("#y").val();
                    z = $("#z").val();
                    //alert ("w = " + w + "x = " + x + "y = " + y + "z = " + z); 

                    //check for which is the empty input box, solve for missing value, set textbox of missing value
                    if (w == '') {
                        w = (x * y) / z;
                        //alert ("w=" + w);
                        $("#w").val(w); //set value
                        $("#w").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box
                        $("#w").addClass("focus");
                        $("#w").focus();

                    }
                    else if (x == '') {
                        x = (z / y) * w;
                        //alert ("x=" + x);
                        $("#x").val(x); //set value
                        $("#x").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box
                        $("#x").addClass("focus");
                        $("#x").focus();

                    }
                    else if (y == '') {
                        y = (z * w) / x;
                        //alert ("y=" + y);
                        $("#y").val(y); //set value
                        $("#y").effect("highlight", { color: "#CBDA45" }, 5000); //highlight the box
                        $("#y").addClass("focus");
                        $("#y").focus();

                    }
                    else {
                        z = (x * y) / w;
                        //alert ("z=" + z);
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
                    //alert ("the count = " + count);
                    //alert ("the count is not 3, reset");
                    alert("You must fill 3 fields");
                    count = 0; //reset count;
                }
                //alert ("the count is now: " + count);
            }); //end function on all key ups of text boxes


            $('#clear').click(function () {
                document.dilutulator.reset();
            });

        }); //end document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" Runat="Server"><a href="../default.aspx">Home</a> > Knowledge Base > Dilutulator</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBody" Runat="Server">
            <div id="mainHeader">
                <h1>Dilutulator</h1>
            </div>
            <div id="main">
                <div id="col1">
                    <div id="col1_content" class="clearfix">
                        <img src="images/certi_tempimage_22.jpg" alt="Your science is our passion" width="240" height="240" />
                    </div>
                </div>
                <div id="col3">
                    <div id="col3_content" class="clearfix">
                        <p>Use our convenient DILUT-ULATOR to easily calculate the volume of concentrate needed to pipette when diluting your standards and samples. Simply complete the first three boxes and click &#8220;Calculate&#8221;.</p>
                        <div style = "width: 100%; height: 150px; float: left;
                        padding: 20px;
                        background-color: #cccccc;
                        color: #fff;
                        border: 1px solid;
                        -webkit-border-radius: 10px;
                        -moz-border-radius: 10px;"> 
                        <fieldset>
                        <div class="outter_div">
                        <p><label for="current_concentration">Concentration of<br />Concentrate (w) in ppm</label></p>
                        <input type="text" name="current_concentration" id="w" class="dilutulator digits"/>
                        </div>
                        <div class="outter_div">
                        <p><label for="final_concentration">Final Concetration <br />Desired (x) in ppm</label></p>
                        <input type="text" name="final_concentration" id="x" class="dilutulator digits" />
                        </div>
                        <div class="outter_div">
                        <p><label for="final_volume">Final Volume <br />Desired (y) in ml</label></p>
                        <input type="text" name="final_volume" id="y" class="dilutulator digits" />
                        </div>
                        <div class="outter_div" style="margin-right: 0; float: right;">
                        <p><label for="required_volume">Volume of Concentration<br />Required (z) in ml</label></p>
                        <input type="text" name="required_volume" id="z" class="dilutulator digits" />
                        </div>
                        <div style="width: 100%; clear: both; padding-top: 20px;">
                        <div id="clear" class="footer_item footer_hover" style="width: 150px;border-color: #FFFFFF; font-size: 14px; font-weight: bold; text-align: center; cursor: pointer;">CLEAR ALL</div>
                        <div id="calculate" class = "footer_item footer_checkout" style=" float: right;  width: 150px; border-color: #FFFFFF; font-size: 14px; font-weight: bold; text-align: center;">CALCULATE</div>
          
              
                        </div>
                        </fieldset>
                        </div><!-- end dilutilator -->
                    </div>
                    <div id="ie_clearing"> &#160; </div>
                </div>
            </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooter" Runat="Server">
</asp:Content>

