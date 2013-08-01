<%@ Page  ValidateRequest="false" Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="CheckoutConfirm.aspx.vb" Inherits="CheckoutConfirm" Title="Confirm Your Order" %>

<%@ Register Src="Modules/PPStandardCheckout.ascx" TagName="PPStandardCheckout" TagPrefix="uc2" %>
<%@ Register Src="Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<h2><a href="checkout.aspx"> Shipping >>></a>  
	<a href="billing.aspx"> Billing  >>></a>
	Confirm and Purchase</h2>
	<br /><br />
<table border="0" cellpadding="5" cellspacing="0" width="550" >
	<tr>
		<td valign="top">    

			<uc1:ResultMessage ID="uResult" runat="server" Visible="false" EnableViewState="false" />
			<table width="100%">
				<tr>
					<td  class="sectionheader" colspan="2">Shipping Information</td>
				</tr>
				<tr>
					<td>
						<table width="100%" cellspacing="3">
							<tr>
								<td>
									<div class="plainbox">
									<asp:Label id="lblShipName" runat="server"></asp:Label><br/>
									<asp:Label id="lblShipAddress1" runat="server"></asp:Label><br/>
									<asp:Label id="lblShipAddress2" runat="server"></asp:Label>
									<asp:Label id="lblShipCity" runat="server"></asp:Label>,
									<asp:Label id="lblShipState" runat="server"></asp:Label>&nbsp;&nbsp;
									<asp:Label id="lblShipZip" runat="server"></asp:Label><br/>
									<asp:Label id="lblShipCountry" runat="server"></asp:Label>
									</div>
								</td>
							</tr>
						 </table>
						 
					 </td>
				  </tr>
				  <tr>
					<td  class="sectionheader" colspan="2">Shipping Options</td>
				</tr>                
				<tr>
					<td>
						<asp:DropDownList Runat="server" ID="ddlShipService" AutoPostBack="True" OnSelectedIndexChanged="ddlShipService_SelectedIndexChanged">
						</asp:DropDownList>
                        <br />
                        <br />
                        <span style="font-size: 10pt"><strong>All customers in the Bernardsville, NJ area are
                            welcome to pick up their items or request free home delivery. Please select the
                            appropriate option above.</strong></span></td>
				</tr>

			 </table>
			<br />
			  <br />
		   <table width="100%" id=tblBillInfo runat=server>
				<tr>
					<td  class="sectionheader" colspan="2">Billing Information</td>
				</tr>
				<tr>
					<td >
						<table width="100%">
							<tr>
								 <td>
									<div class="plainbox">

									<asp:Label id="lblName" runat="server"></asp:Label><br />
									<asp:Label id="lblAddress1" runat="server"></asp:Label><br/>
									<asp:Label id="lblAddress2" runat="server"></asp:Label>
									<asp:Label id="lblCity" runat="server"></asp:Label>,
									<asp:Label id="lblState" runat="server"></asp:Label>&nbsp;&nbsp;<asp:Label id="lblZip" runat="server"></asp:Label><br/>
									<asp:Label id="lblCountry" runat="server"></asp:Label>                                    
									</div>
								</td>
							</tr>
						 </table>
					 </td>
				 </tr>
			
			</table>
			<br />
			<table width="100%">
				<tr>
					<td  class="sectionheader" colspan="2">Payment Method</td>
				</tr>
				<tr>
					<td>
					<div class="plainbox">
						<asp:Label ID="lblPaymentSummary" runat="server"></asp:Label>
						<asp:TextBox ID="txtToken" runat="server" Visible="False"></asp:TextBox><asp:TextBox
							ID="txtPayerID" runat="server" Visible="False"></asp:TextBox><asp:TextBox ID="txtZip"
								runat="server" Visible="False"></asp:TextBox><asp:TextBox ID="txtCCNumber" runat="server"
									Visible="False"></asp:TextBox>
						<asp:TextBox ID="txtCCType" runat="server" Visible="False"></asp:TextBox>
						<asp:TextBox ID="txtCCExpMonth" runat="server" Visible="False"></asp:TextBox>
						 <asp:TextBox ID="txtCCExpYear" runat="server" Visible="False"></asp:TextBox>
					   <asp:TextBox ID="txtCCAuthCode" runat="server" Visible="False"></asp:TextBox>
						&nbsp;
						<asp:TextBox ID="txtTaxAmount" runat="server" Visible="False"></asp:TextBox>
					</div>
					
					</td>
				</tr>
			</table>
			
			<br />
			 <br />
		   <table width="100%">
					<tr>
					<td  class="sectionheader" colspan="2">Order Details</td>
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
				<tr >
					<td>
						<table width="100%"><tr>
								<td align="right" class="checkoutlabel">Tax:</td>
								<td align="right" style="width:50px;" class="checkoutlabel">
									<asp:Label ID="lblTax" Runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td align="right"  class="checkoutlabel">Shipping:</td>
								<td style="width:50px;" align="right" class="checkoutlabel">
									<asp:Label ID="lblShipping" Runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td align="right"  class="checkoutlabel"><b>Total:</b></td>
								<td style="width:50px;" align="right" class="checkoutlabel">
									<b><asp:Label ID="lblTotal" Runat="server"></asp:Label></b>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr id="trPlaceOrder" runat="server" >
					<td align="right">
					<asp:Button ID="btnOrder" runat="server" Text="Place Order" OnClick="btnOrder_Click" /></td></tr>
				<tr id="trRunPayPal" runat="server">
					<td>                    
					<uc2:PPStandardCheckout id="PPStandardCheckout1" runat="server">
					</uc2:PPStandardCheckout>
					</td>
				</tr>
			</table>                        
		</td>
	</tr>
</table>
</asp:Content>

