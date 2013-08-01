<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Basket.aspx.vb" Inherits="Basket" Title="Shopping Cart"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	 <h1>Your Shopping Cart</h1>       
	 <table>
		<tr>
			<td valign="top" >       
			<asp:GridView ID="dgBasket" Runat="server" AutoGenerateColumns="False" OnRowDeleting="Remove_Item" OnRowCommand="DoCommand" OnSelectedIndexChanged="dgBasket_SelectedIndexChanged">
				<EmptyDataTemplate>
					&nbsp;-- No items in your cart --
				</EmptyDataTemplate>
				<Columns>
					<asp:BoundField DataField="productID"></asp:BoundField>
					<asp:BoundField HeaderText="Number" DataField="ModelNumber"></asp:BoundField>
					<asp:BoundField HeaderText="Item" DataField="ModelName"></asp:BoundField>
					<asp:BoundField HeaderText="Price" DataField="Price" DataFormatString="{0:C}"></asp:BoundField>
					<asp:TemplateField HeaderText="Quantity"><ItemTemplate>
						<asp:TextBox ID="txtQuantity" Runat="server" Text='<%#Eval("quantity")%>' Width="20px"
							Height="20px" AutoPostBack="True" CausesValidation="True"></asp:TextBox>
						<asp:RangeValidator ID="RangeValidator1" Runat="server" ErrorMessage="Number Please"
							ControlToValidate="txtQuantity" MaximumValue="100" MinimumValue="0" Type="Integer"
							Display="Dynamic">
						</asp:RangeValidator>
					</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField HeaderText="Line Total" DataField="LineTotal" DataFormatString="{0:c}"></asp:BoundField>
				</Columns>
	   </asp:GridView>
				<asp:Panel ID="pnlCheckout" runat="server">
				 <div class="plainbox">
				 To Remove an item, set it's quantity to zero.
				 </div>
			<a href="checkout.aspx" class="checkout">Checkout >>></a></asp:Panel>
			</td>
		  </tr></table>
</asp:Content>

