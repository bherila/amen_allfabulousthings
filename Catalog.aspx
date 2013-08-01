<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Catalog.aspx.vb" Inherits="Catalog" Title="Product Catalog"%>
<%@ Register TagPrefix="uc1" TagName="CatalogList" Src="Modules/CatalogList.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label></h1>
	
	<asp:DataList ID="DataList1" Runat="server" DataKeyField="ProductID" DataSourceID="ObjectDataSource1">
			<ItemTemplate>
<table><tr><td style="width: 100px; text-align: center;" align="center" valign="middle" width="100"><a href="product.aspx?id=<%# Eval("ProductID") %>" >
<img style="border: 1px solid black;" alt='Product Image - <%#Eval("ModelName")%>' src='images/ProductThumbnails/<%#Eval("ProductImage")%>' class="thumbimage"></a></td><td><div class="plainbox">
<a href="product.aspx?id=<%# Eval("ProductID") %>">
<a href="product.aspx?id=<%# Eval("ProductID") %>"><b><%#Eval("ModelName")%></b></a>&nbsp; </A>
<asp:Label id="lblProductID" runat="server" Visible="False" Text='<%#Eval("ProductID")%>'></asp:Label>  
<br />
<%#FmtDesc(Eval("Description"))%>
<a href="product.aspx?id=<%# Eval("ProductID") %>">Details</a> <img alt="More Detail" src="images/morearrow.gif"></div></td></tr></table>
						
			</ItemTemplate>
		</asp:DataList>
		
		<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetProductsByCategory"
		TypeName="CatalogManager">
		<SelectParameters>
			<asp:QueryStringParameter DefaultValue="14" Name="categoryID" QueryStringField="cid"
				Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
</asp:Content>

