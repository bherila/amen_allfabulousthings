<%@ Page  Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Product.aspx.vb" Inherits="ProductPage" Title="Product Detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	   <h1><asp:Label ID="lblModelName" runat="server"></asp:Label></h1>
		 <asp:Label ID="lblModelNumber" runat="server" Visible="false"></asp:Label>
		<asp:Label ID="lblProductNumber" Runat="server" Visible="false"></asp:Label>
	   <table>
			<tr>
				<td align="center"><asp:Image ID="imgProduct" BorderColor="Black" BorderStyle="solid" BorderWidth="1px" runat="server" /></td></tr><tr>
				<td>
					<div>
					<asp:Panel runat="server" ID="pFPrice" Visible="false">
						<asp:Label ID="lblUnitCost" runat="server" Font-Bold="True"></asp:Label><asp:Label ID="lblWeight" runat="server"
							Visible="False"></asp:Label>
						<asp:Label ID="lblDiscountPrice" runat="server" Visible="False" Font-Bold="True" ForeColor="#C00000"></asp:Label>
					</asp:Panel>
					</div>
					<div class="plainbox">
						<asp:Label  ID="lblDescription" runat="server"></asp:Label>
						<asp:Panel runat="server" ID="pPrice" Visible="false">
						    <asp:Label ID="lblPrice" runat="server" Visible="False"></asp:Label>
						    <asp:Label ID="lblDPrice" runat="server" Visible="false"></asp:Label>
						</asp:Panel>
						</div>
					 <div class="plainbox">
						<asp:Panel ID="pnlAdd" runat="server" Visible="false">
						<table width="100%" cellpadding="2" cellspacing="0">
							<tr id="trAddToCart" runat="server">
								<td>
									<asp:LinkButton id="lnkAddToCart" runat="server" CssClass="addtocartlink" OnClick="lnkAddToCart_Click">Add To Cart</asp:LinkButton>
									<asp:Label id="lblOutOfStock" runat="server" ForeColor="Gray" Visible="False">[Currently Out of Stock]</asp:Label>
								</td>
							</tr>
						</table>
						</asp:Panel>                     

					</div>
				</td>
			</tr>
	   </table>

</asp:Content>

