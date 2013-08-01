<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="MyOrders.aspx.vb" Inherits="MyOrders" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>Your Orders</h1>

<table >
	<tr class="sectionheader">
		<td>Order Number</td>
		<td>Date</td>
		<td>Amount</td>
		<td>Options</td>
	</tr>
	<asp:Repeater ID="rptMyOrders" runat="server">
		<ItemTemplate>
	<tr class="plainbox">
		<td><%#Eval("paypalTransactionID")%></td>
		<td><%#Eval("orderDate")%></td>
		<td><%#Convert.ToDouble(Eval("orderTotal")).ToString("c")%></td>
		<td><a class="sidemenulink" href="receipt.aspx?t=<%# Eval("paypalTransactionID") %>">View</a> | 
		<a class="sidemenulink" href="PayPalRecord.aspx?t=<%# Eval("paypalTransactionID") %>" target="_blank">PayPal Record</a></td>
	   
	</tr>
		</ItemTemplate>
	</asp:Repeater>
</table>
</asp:Content>

