<%@ Page Language="vb" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_orders.aspx.vb" Inherits="admin_orders" Title="Order Administration" StylesheetTheme="White" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">
<h1>Order Administration</h1>
<table width=100%>
	<tr>
		<td>
		<table>
			<tr>
				<td>User Name</td>
				<td>
					<asp:TextBox ID="txtUserName" runat="server"></asp:TextBox><asp:Button ID="btnUserSearch"
						runat="server" OnClick="btnUserSearch_Click" Text="Go" /><br />
Supports partial search    

				</td>
		   </tr>
			 <tr>
				<td>Transaction ID</td>
				<td>
					<asp:TextBox ID="txtTransactionID" runat="server"></asp:TextBox><asp:Button ID="btnTrans"
						runat="server" OnClick="btnTrans_Click" Text="Go" /><br />
					Supports partial search    
				</td>
		   </tr>
			 <tr>
				<td style="height: 26px">Order Date Start</td>
				<td style="height: 26px">
					<asp:TextBox ID="txtDateStart" runat="server"></asp:TextBox>
					</td>
		   </tr>
			  <tr>
				<td>Order Date End</td>
				<td>
					<asp:TextBox ID="txtDateEnd" runat="server"></asp:TextBox>
					</td>
		   </tr>
			<tr>
				<td>
				</td>
				<td>
					<asp:Button ID="btnSearch" runat="server" Text="Find By Date" OnClick="btnSearch_Click" /></td>
			</tr>
		  </table>
		</td>
	</tr>
	<tr id=trError runat=server visible=false>
		<td class=errorbox>Query Error - Invalid criteria. Please make sure your dates are formatted correctly.</td>
	</tr>
	<tr>
		<td>
			<asp:GridView ID="dgResults" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
				<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
				<Columns>
					<asp:HyperLinkField DataNavigateUrlFields="PayPalTransactionID" DataNavigateUrlFormatString="admin_order_details.aspx?t={0}"
						Text="View" />
					<asp:BoundField DataField="PayPalTransactionID" HeaderText="PayPalTransactionID"  SortExpression="PayPalTransactionID" />
					 <asp:BoundField DataField="OrderStatus" HeaderText="Status" SortExpression="OrderStatus" />
				   <asp:BoundField DataField="OrderDate" HeaderText="Date" SortExpression="OrderDate" />
					<asp:BoundField DataField="UserName" HeaderText="User" SortExpression="UserName" />
					<asp:BoundField DataField="orderTotal" HeaderText="Total" SortExpression="orderTotal" DataFormatString="{0:c}" />
				</Columns>
				<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#999999" />
				<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
			</asp:GridView>
			&nbsp;
		</td>
	</tr>
</table>
</asp:Content>

