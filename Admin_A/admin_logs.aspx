<%@ Page Language="vb" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admin_logs.aspx.vb" Inherits="Admin_admin_logs" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">
	<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" PageSize="50">
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CommerceTemplate %>"
		SelectCommand="SELECT [logID], [category],userName, message, [event], [itemID],logDate as [Date] FROM [CMRC_Logs] ORDER BY logDate DESC" >
	</asp:SqlDataSource>
</asp:Content>

