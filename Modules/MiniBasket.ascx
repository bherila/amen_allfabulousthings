<%@ Control Language="vb" AutoEventWireup="true" CodeFile="MiniBasket.ascx.vb" Inherits="MiniBasket" %>
<asp:Panel ID=pnlCart runat=server>
<table border="0" cellpadding="0" cellspacing="0" class="sp">
	<td class="textboxheader">
	<img src="<%=Utility.GetSiteRoot()%>/images/icons/shopping_cart.gif" align=absmiddle/>&nbsp;<a href="<%=Utility.GetSiteRoot()%>/basket.aspx">Your Cart</a>
	</td>
</tr>
	<td class="textbox">
		<asp:Repeater ID="dlBasket" Runat="server">
			<ItemTemplate>
			<div>
				(<%#Eval("quantity") %>)
			<%#Eval("modelName") %>
			</div>
			</ItemTemplate>
		</asp:Repeater>
		<div class=subtotal>
			<asp:Label runat="server" ID="lblTotal"></asp:Label>
		</div>
		<a href="<%=Utility.GetSiteRoot()%>/checkout.aspx" class="checkout">Checkout >>></a>
	</td>
	</tr>
	</table>
</asp:Panel>