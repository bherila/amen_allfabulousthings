<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Receipt.aspx.vb" Inherits="Receipt" Title="Order Receipt"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table border="0" cellpadding="0" cellspacing="0" width="550"><tr>
	<td valign="top">    
		<table id="Table2" cellspacing="0" cellpadding="2" width="100%">
			<tr>
				<td >
					<h1>
						Receipt <asp:Label ID="lblTitle" runat="server"></asp:Label>
					</h1>
				</td>
			</tr>
			<tr>
				<td  class="checkoutlabel">
					Status: <asp:Label ID="lblStatus" runat="server" Text="Label" Font-Bold="True"></asp:Label></td>
			</tr>            
			<tr runat="server" enableviewstate="False" visible="False" id="trError">
				<td id="Td1" runat="server" colspan="2">
					<font color="#990000"><b>
					<asp:Label Runat="server" ID="lblError"></asp:Label>
					</b></font>
				</td>
			</tr>

		</table>
		<asp:Panel ID="pnlDetail" runat="server">
		<br />
		<table cellspacing="1" cellpadding="2" width="100%" >
			<tr>
				<td colspan="2" class="sectionheader"><b>Shipping Information</b></td>
			</tr>
			<tr>
				<td>
					<table width="100%">

						<tr>
							<td  class="checkoutlabel">
								<asp:Label ID="lblShippingSummary" runat="server" Text="Label"></asp:Label></td>
						</tr>
						<tr><td>&nbsp;</td></tr>
					   <tr>
							<td  class="checkoutlabel"><b>Shipping Method</b><br />
								<asp:Label ID="lblShippingMethod" runat="server" Text="Label"></asp:Label></td>
						</tr>               
						<tr>
							<td  class="checkoutlabel">
								Tracking Number<br />
								<asp:Label ID="lblTrackingNumber" runat="server"></asp:Label>
							 
							</td>
						</tr>
				</table>               
				</td>
			</tr>
		</table>

		<br />
		<table cellspacing="1" cellpadding="2" width="100%" >
			<tr>
				<td  colspan="2" class="sectionheader"><b>Billing Information</b></td>
			</tr>
			<tr>
				<td>
					<table width="100%">
						<tr>
							<td class="checkoutlabel">Payment Method</td>
						</tr>
						<tr>
							<td class="plainbox">
								<asp:Label ID="lblPaymentMethod" runat="server" Text=""></asp:Label></td>
						</tr>
					   <tr>
							<td class="checkoutlabel">Transaction ID</td>
					   </tr>
						<tr>
							<td class="plainbox">
								<asp:Label ID="lblTransactionID" runat="server" Text=""></asp:Label></td>
						</tr>               
				</table>               
				</td>
			</tr>        
		</table>    
		<br />    
		<table width="100%">
			<tr>
				<td  colspan="2" class="sectionheader"><b>Order Details</b></td>
			</tr>
			<tr>
				<td >
					<asp:GridView ID="dgItems" Runat="server" AutoGenerateColumns="False" Width="100%">
						<EmptyDataTemplate>
							&nbsp;-- No items in your basket --
						</EmptyDataTemplate>
						<Columns>
							<asp:BoundField DataField="productID" Visible="False"></asp:BoundField>
							<asp:BoundField HeaderText="Number" DataField="modelnumber"></asp:BoundField>
							<asp:BoundField HeaderText="Item" DataField="modelname"></asp:BoundField>
							<asp:BoundField HeaderText="Quantity" DataField="quantity"></asp:BoundField>
							<asp:BoundField HeaderText="Price" DataField="price" DataFormatString="{0:C}">
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
								<td style="text-align:right" class="checkoutlabel">Tax:</td>
								<td  style="text-align:right; width:50px;" class="checkoutlabel">
									<asp:Label ID="lblTax" Runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td  style="text-align:right;"  class="checkoutlabel">Shipping:</td>
								<td  style="text-align:right; width:50px;" class="checkoutlabel">
									<asp:Label ID="lblShipping" Runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td  style="text-align:right;"  class="checkoutlabel"><b>Total:</b></td>
								<td  style="text-align:right; width:50px;" class="checkoutlabel">
									<b><asp:Label ID="lblTotal" Runat="server"></asp:Label></b>
								</td>
							</tr>
						</table>
				</td>
			</tr>
		</table>  
		</asp:Panel>    
		</td>
	</tr>
</table>  
</asp:Content>

