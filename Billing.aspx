<%@ Page validaterequest="false" Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Billing.aspx.vb" Inherits="Billing" Title="Billing Information" %>

<%@ Register Src="Modules/PPStandardCheckout.ascx" TagName="PPStandardCheckout" TagPrefix="uc2" %>

<%@ Register Src="Modules/LocationSelector.ascx" TagName="LocationSelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<h2><a href="checkout.aspx"> Shipping >>></a>  Billing >>> </h2>
	<h2 class="shaded">Confirm and Purchase</h2>
	<br /><br />

<asp:Panel ID="pnlError" runat="server" Visible="false">
	<div class="errorbox"><asp:Label Runat="server" ID="lblError"></asp:Label></div>
</asp:Panel>
<table border="0" cellpadding="5" cellspacing="0"><tr>
	<td valign="top">    
	<br />
		<!--
		<table width=100%>
			<tr>
				<td height=25 class=sectionheader><b>Payment Method</b></td>
			</tr>
			<tr>
				<td >
				<div class=plainbox>
					<asp:RadioButtonList ID="radPayType" runat="server" AutoPostBack="True">
						<asp:ListItem Selected="True">&lt;IMG SRC=&quot;images/ccs.gif&quot; /&gt;</asp:ListItem>
						<asp:ListItem CssClass=plainbox>&lt;IMG SRC=&quot;images/ppsmall.gif&quot; align=absmiddle/&gt;
						Save Time. Checkout Securely.Pay withouth sharing your financial information.</asp:ListItem>
					</asp:RadioButtonList>
				 </div>
				 </td>
			</tr>
		   
		</table> 
		-->
		<asp:Panel ID="pnlBillInfo" runat="server">

		<table width="100%">
			<tr>
				<td class="sectionheader" >Debit or Credit Card Information</td>
			</tr>
			<tr>
				<td>
					<table >
						<tr>
							<td  class="checkoutlabel">Credit Card Type</td>
							<td >
								<asp:DropDownList ID="ddlCCType" runat="server">
									<asp:ListItem>Visa</asp:ListItem>
									<asp:ListItem>MasterCard</asp:ListItem>
									<asp:ListItem>AMEX</asp:ListItem>
								</asp:DropDownList></td>
						  </tr>
						 <tr>
							<td  class="checkoutlabel">Credit Card Number</td>
							<td ><asp:TextBox Runat="server" ID="txtCCNumber" Width="276px">4869269250951863</asp:TextBox><asp:RequiredFieldValidator
									ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCCNumber" ErrorMessage="Required"></asp:RequiredFieldValidator></td>
						  </tr>                   
						 <tr>
							<td class="checkoutlabel" >Security Code</td>
							<td ><asp:TextBox Runat="server" ID="txtCCAuthCode" Width="38px">027</asp:TextBox><asp:RequiredFieldValidator
									ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCCAuthCode"
									ErrorMessage="Required"></asp:RequiredFieldValidator></td>
							</tr> 
						<tr>
							<td  class="checkoutlabel">Expiration</td>
							<td >
							<asp:DropDownList ID="ddlExpMonth" runat="server" Width="49px">
									<asp:ListItem >01</asp:ListItem>
									<asp:ListItem>02</asp:ListItem>
									<asp:ListItem>03</asp:ListItem>
									<asp:ListItem>04</asp:ListItem>
									<asp:ListItem>05</asp:ListItem>
									<asp:ListItem>06</asp:ListItem>
									<asp:ListItem>07</asp:ListItem>
									<asp:ListItem>08</asp:ListItem>
									<asp:ListItem>09</asp:ListItem>
									<asp:ListItem>10</asp:ListItem>
									<asp:ListItem>11</asp:ListItem>
									<asp:ListItem>12</asp:ListItem>
							   </asp:DropDownList>&nbsp;
								<asp:DropDownList ID="ddlExpYear" runat="server" Width="73px">
								</asp:DropDownList>
							</td>
						 </tr>                   
				   </table>
				</td>
			</tr>
		 </table>
		 <br />
		 <table width="100%">
			<tr>
				<td class="sectionheader" >Billing Information</td>
			</tr>
			<tr>
				<td>
					<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
					<tr>
						<td class="checkoutlabel">
							First:</td>
						<td>
							<asp:TextBox Runat="server" ID="txtBillFirst"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtBillFirst" ErrorMessage="Required"
								ID="RequiredFieldValidator1"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Last:</td>
						<td>
							<asp:TextBox Runat="server" ID="txtBillLast"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtBillLast" ErrorMessage="Required"
								ID="Requiredfieldvalidator5"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Address</td>
						<td>
							<asp:TextBox Runat="server" ID="txtBillAddress"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtBillAddress" ErrorMessage="Required"
								ID="RequiredFieldValidator2"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Address 2</td>
						<td>
							<asp:TextBox Runat="server" ID="txtBillAddress2"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							City</td>
						<td>
							<asp:TextBox Runat="server" ID="txtBillCity"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtBillCity" ErrorMessage="Required"
								ID="RequiredFieldValidator3"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<uc1:LocationSelector id="LocationSelector1" runat="server" />

					<tr>
						<td class="checkoutlabel">
							Zip</td>
						<td>
							<asp:TextBox Runat="server" ID="txtBillZip"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtBillZip" Display="Dynamic"
								ErrorMessage="Required" ID="RequiredFieldValidator6"></asp:RequiredFieldValidator>
							&nbsp;
						</td>
					</tr>
				</table>
				
				</td>
			</tr>
		</table>
		<br />
 
		</asp:Panel>
		<br />
		<table width="100%">
				<tr>
				<td class="sectionheader" >Order Details</td>
			</tr>
			<tr>
				<td bgcolor="white">
					<asp:GridView ID="dgBasket" Runat="server" AutoGenerateColumns="False" Width="100%">
						<EmptyDataTemplate>
							&nbsp;-- No items in your basket --
						</EmptyDataTemplate>
						<Columns>
							<asp:BoundField DataField="productID" Visible="False"></asp:BoundField>
							<asp:BoundField HeaderText="Number" DataField="ModelNumber"></asp:BoundField>
							<asp:BoundField HeaderText="Item" DataField="ModelName"></asp:BoundField>
							<asp:BoundField HeaderText="Quantity" DataField="quantity"></asp:BoundField>
							<asp:BoundField HeaderText="Price" DataField="Price" DataFormatString="{0:C}">
								<ItemStyle HorizontalAlign="Right"></ItemStyle>
							</asp:BoundField>
							<asp:BoundField HeaderText="Total" DataField="LineTotal" DataFormatString="{0:C}">
								<ItemStyle HorizontalAlign="Right"></ItemStyle>
							</asp:BoundField>
						</Columns>
					</asp:GridView>
					
				</td>
			</tr>
			<tr id="trPlaceOrder" runat="server">
				<td align="right">
					<asp:Button ID="btnContinue" runat="server" Text="Continue" PostBackUrl="~/CheckoutConfirm.aspx" />
				</td>
			</tr>
		</table>                        
	</td>
	</tr>
</table>

</asp:Content>

