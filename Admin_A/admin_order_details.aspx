<%@ Page validaterequest="false" Language="vb" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_order_details.aspx.vb" Inherits="admin_order_details" Title="Untitled Page" StylesheetTheme="White" %>
<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">
<h1>Order Detail<br />
</h1>
<uc1:ResultMessage ID="uResult" runat="server" visible="false" />
<table border="0" cellpadding="0" cellspacing="0" width=100% ><tr>
	<td valign="top">    
		<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
			<tr>
				<td height=25  class=sectionheader colspan=2><b>Administrative Detail</b></td>
			</tr>
			<tr>
				<td>
					<table width=100%>
						<tr>
							<td style="width: 131px" valign="top">
								Order ID</td>
							<td valign="top">
								<asp:Label ID="lblID" runat="server" Text=""></asp:Label></td>
						</tr>
						<tr>
							<td style="width: 131px" valign="top">
								Status</td>
							<td valign="top">
								<asp:Label ID="lblStatus" runat="server"></asp:Label></td>
						</tr>
						<tr>
							<td valign=top style="width: 131px">Issue Refund</td>
							<td valign=top>
								<asp:Button ID="btnRefundFull" runat="server" Text="Refund" OnClick="btnRefundFull_Click" /></td>
						</tr>
						<tr>
							<td valign="top">
								Mark as Shipped</td>
							<td>
								Shipped Date<br />
								<asp:TextBox ID="txtShipDate" runat="server" ></asp:TextBox><br />
								<asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtShipDate"
									Display="Dynamic" ErrorMessage="Invalid Date" MaximumValue="1/1/2050" MinimumValue="1/1/1990"
									Type="Date"></asp:RangeValidator><br />
								Tracking Number<br />
								<asp:TextBox ID="txtTrackingNumber" runat="server"></asp:TextBox><br />
								<br />
								<asp:Button ID="btnSetShipped" runat="server" Text="Shipped" OnClick="btnSetShipped_Click" /></td>
						</tr>
		   
				</table>               
				</td>
			</tr>       
		</table>
		   <br />
		 <table width=100%>
				<tr>
				<td height=25  class=sectionheader colspan=2><b>Order Details</b></td>
			</tr>
			<TR>
				<TD bgColor="white">
					<asp:GridView ID="dgItems" Runat="server" AutoGenerateColumns="False" Width=100%>
						<EmptyDataTemplate>
							&nbsp;-- No items  --
						</EmptyDataTemplate>
						<Columns>
							<asp:BoundField DataField="productID" Visible="False"></asp:BoundField>
							<asp:BoundField HeaderText="Number" DataField="modelNumber"></asp:BoundField>
							<asp:BoundField HeaderText="Item" DataField="modelName"></asp:BoundField>
							<asp:BoundField HeaderText="Quantity" DataField="quantity"></asp:BoundField>
							<asp:BoundField HeaderText="Price" DataField="Price" DataFormatString="{0:c}">
								<ItemStyle HorizontalAlign="Right"></ItemStyle>
							</asp:BoundField>
							<asp:BoundField HeaderText="Total" DataField="LineTotal" DataFormatString="{0:c}">
								<ItemStyle HorizontalAlign="Right"></ItemStyle>
							</asp:BoundField>
						</Columns>
					</asp:GridView>
					
				</TD>
			</TR>
			<TR >
				<TD>
					<table width=100%><tr>
							<td align=right>Tax:</td>
							<td width=20>
								<asp:Label ID="lblTax" Runat="server"></asp:Label>
							</td>
						</tr>
						<tr>
							<td align=right>Shipping:</td>
							<td width=20>
								<asp:Label ID="lblShipping" Runat="server"></asp:Label>
							</td>
						</tr>
						<tr>
							<td align=right><b>Total:</b></td>
							<td width=20>
								<b><asp:Label ID="lblTotal" Runat="server"></asp:Label></b>
							</td>
						</tr></table>
				</TD>
			</TR>
		</table>      
		 <br />
	   <table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
			<tr>
				<td height=25  class=sectionheader colspan=2><b>PayPal Transaction Detail</b></td>
			</tr>
			<tr>
				<td><asp:LinkButton ID="lnkGetPPRecord"
						runat="server" OnClick="lnkGetPPRecord_Click">Get PayPal Record...</asp:LinkButton>
						<asp:Label ID="lblPP" runat="server" Text=""></asp:Label></td>
			</tr>
	   </table>
		<br />
		<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
			<tr>
				<td height=25  class=sectionheader colspan=2><b>Shipping Information</b></td>
			</tr>
			<tr>
				<td>
					<table width=100%>
						<tr>
							<td valign=top style="width: 131px; height: 41px;">Shipping Address</td>
							<td valign=top style="height: 41px">
								<asp:TextBox ID="txtShippingAddress" runat="server" TextMode="MultiLine" Height="96px" Width="185px"></asp:TextBox><br />
								<asp:Button ID="btnUpdateShipping" runat="server" Text="Update" OnClick="btnUpdateShipping_Click" /><br />
							</td>
						</tr>
					   <tr>
							<td valign=top style="width: 131px">Shipping Method</td>
							<td valign=top>
								<asp:Label ID="lblShippingMethod" runat="server" Text="Label"></asp:Label></td>
						</tr>               
				</table>               
				</td>
			</tr>
		</table>


		<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
			<tr>
				<td height=25  class=sectionheader colspan=2><b>Billing Information</b></td>
			</tr>
			<tr>
				<td>
					<table width=100%>
						<tr>
							<td valign=top style="width: 131px">Payment Method</td>
							<td valign=top>
								<asp:Label ID="lblPaymentMethod" runat="server" Text=""></asp:Label></td>
						</tr>
					   <tr>
							<td valign=top style="width: 131px">Transaction ID</td>
							<td valign=top>
								<asp:Label ID="lblTransactionID" runat="server" Text=""></asp:Label></td>
						</tr>               
				</table>               
				</td>
			</tr>        
		</table>        

	   </td>
	</tr>
</table>
<script>
function CheckRefund(){
		
	return confirm("Refund this transaction? This action cannot be undone...");

}</script>
</asp:Content>
