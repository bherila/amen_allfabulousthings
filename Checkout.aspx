<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Checkout.aspx.vb" Inherits="Checkout" Title="Order Checkout"  %>
<%@ Register Src="Modules/LocationSelector.ascx" TagName="LocationSelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<h2><b>Shipping</b> >>> </h2>
	<h2 class="shaded"> Billing >>> Confirm and Purchase</h2>
	<br /><br />
		<asp:Panel ID="pnlError" runat="server" Visible="false">
			<div class="errorbox"><asp:Label Runat="server" ID="lblError"></asp:Label></div>
		</asp:Panel>
	   
		<table border="0" cellpadding="5" cellspacing="0" width="550" ><tr>
			<td valign="top">    
				 <asp:Panel ID="pnlDirectPay" runat="server">
				<br />
				<table cellspacing="1" cellpadding="2" width="100%" id=tblExpress runat=server>
					<tr>
						<td class="sectionheader" colspan="2">Fast, Secure Checkout with Paypal</td>
					</tr>                  
					<tr >
						<td colspan="2">
							<table width="100%">
								<tr>
									<td><asp:ImageButton id="imgPayPal" runat="server" ImageUrl="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" OnClick="imgPayPal_Click" CausesValidation="False"/>
										</td>
										<td class="plainbox">Save Time. Checkout Securely.<br />
										Pay withouth sharing your financial information.
										</td>
								</tr>
							</table>                        
						
						</td>
					</tr>
				</table>
				<table cellspacing="1" cellpadding="2" width="100%">
					<tr>
						<td class="sectionheader" colspan="2">Shipping Information</td>
					</tr>
					<tr>
						<td class="checkoutlabel" >
							First:</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipFirst"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtShipFirst" ErrorMessage="Required"
								ID="RequiredFieldValidator1"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Last:</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipLast"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtShipLast" ErrorMessage="Required"
								ID="Requiredfieldvalidator5"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel" >
							Email</td>
						<td height="28">
							<asp:TextBox Runat="server" ID="txtShipEmail"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtShipEmail" ErrorMessage="Required"
								ID="Requiredfieldvalidator4"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Address</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipAddress"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtShipAddress" ErrorMessage="Required"
								ID="RequiredFieldValidator2"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Address 2</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipAddress2"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							City</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipCity"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtShipCity" ErrorMessage="Required"
								ID="RequiredFieldValidator3"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<uc1:LocationSelector id="LocationSelector1" runat="server"></uc1:LocationSelector>

					<tr>
						<td class="checkoutlabel">
							Zip</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipZip"></asp:TextBox>
							<asp:RequiredFieldValidator Runat="server" ControlToValidate="txtShipZip" Display="Dynamic"
								ErrorMessage="Required" ID="RequiredFieldValidator6"></asp:RequiredFieldValidator>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="checkoutlabel">
							Phone</td>
						<td>
							<asp:TextBox Runat="server" ID="txtShipPhone"></asp:TextBox><asp:RequiredFieldValidator
								ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtShipPhone"
								Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator><br />
							<div class="plainbox">A valid phone number is required for all shipments</div></td>
					</tr>
				</table>
				</asp:Panel>
				<br />
				<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
					 <tr>
						<td  class="sectionheader">Order Details</td>
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
					<tr id="trContinue" runat="server" >
						<td align="right" style="height: 26px">
							<asp:Button ID="btnContinue" runat="server" Text="Continue" OnClick="btnContinue_Click" /></td>
					</tr>
			   </table>                        
			</td>
		  </tr>
		</table>
</asp:Content>

