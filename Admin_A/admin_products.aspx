<%@ Page Language="vb" MasterPageFile="~/admin.master" ValidateRequest="false" AutoEventWireup="true" CodeFile="admin_products.aspx.vb" Inherits="admin_products" Title="Product Administration" StylesheetTheme="White" %>

<%@ Register Src="../Modules/ResultMessage.ascx" TagName="ResultMessage" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPlaceHolder" Runat="Server">
	<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
		<tr>
			<td height=25 class=sectionheader><b>Product Administration</b></td>
		</tr>
	</table>
	<asp:Panel ID=pnlGrid runat=server>
	<input type=button value="Add Product" onclick="location.href='admin_products.aspx?p=0'" />
	<asp:GridView ID="dgProducts" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID" OnRowDataBound="InventoryCheck" >
		<Columns>
			<asp:HyperLinkField DataNavigateUrlFields="ProductID" DataNavigateUrlFormatString="admin_products.aspx?p={0}"
				HeaderText="View" Text="View" />
			<asp:BoundField DataField="ProductID" HeaderText="ProductID" InsertVisible="False"
				ReadOnly="True" SortExpression="ProductID" Visible=False />
			<asp:BoundField DataField="ModelNumber" HeaderText="ModelNumber" SortExpression="ModelNumber" />
			<asp:BoundField DataField="ModelName" HeaderText="ModelName" SortExpression="ModelName" />
			<asp:BoundField DataField="UnitCost" HeaderText="UnitCost" SortExpression="UnitCost" />
			<asp:BoundField DataField="AmountOnHand" HeaderText="AmountOnHand" SortExpression="AmountOnHand" />
			<asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU" />
			<asp:BoundField DataField="IsActive" HeaderText="Is Active" SortExpression="IsActive" />
	   </Columns>
		
	</asp:GridView>
	<input type=button value="Add Product" onclick="location.href='admin_products.aspx?p=0'" />
	</asp:Panel>
	<asp:panel id="pnlEdit" Runat="server" Visible=false>
		<uc1:ResultMessage ID="uResult" runat="server" visible="false" />
		<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%">
			<TR id="trError" runat="server" visible="false" enableviewstate="false">
				<TD id="tdError" bgColor="#ffcc33" colSpan="2" runat="server">
					<asp:Label id="lblError" runat="server"></asp:Label></TD>
			</TR>
			<TR>
				<TD colSpan="2">
					<TABLE id="Table4" cellSpacing="1" width="100%" bgColor="gainsboro">
						<TR id="trID" runat="server">
							<TD bgColor="whitesmoke" style="width: 73px">ID</TD>
							<TD bgColor="white">
								<asp:Label id="lblID" runat="server"></asp:Label></TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">Category</TD>
							<TD bgColor="white">
								<asp:DropDownList id="ddlCategoryID" runat="server"></asp:DropDownList>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1ddlCategoryID" runat="server" Display="Dynamic" ControlToValidate="ddlCategoryID"
									ErrorMessage="Required"></asp:RequiredFieldValidator></TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">Model Number</TD>
							<TD bgColor="white">
								<asp:textbox id="txtModelNumber" runat="server"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1txtModelNumber" runat="server" Display="Dynamic" ControlToValidate="txtModelNumber"
									ErrorMessage="Required"></asp:RequiredFieldValidator></TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">Model&nbsp;Name</TD>
							<TD bgColor="white">
								<asp:textbox id="txtModelName" runat="server"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1txtModelName" runat="server" Display="Dynamic" ControlToValidate="txtModelName"
									ErrorMessage="Required"></asp:RequiredFieldValidator></TD>
						</TR>
						<tr>
							<td bgcolor="whitesmoke" style="width: 73px">
								SKU</td>
							<td bgcolor="white">
								<asp:TextBox ID="txtSKU" runat="server"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSKU"
									Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator></td>
						</tr>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">Product Image</TD>
							<TD bgColor="white">
								<asp:Image id="imgProductImage" runat="server"></asp:Image><BR><br />
								<asp:textbox id="txtProductImage" runat="server"></asp:textbox> <A onclick="loadPix(); return false;" href="javascript:void(0);">Select ...</A>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1txtProductImage" runat="server" Display="Dynamic" ControlToValidate="txtProductImage"
									ErrorMessage="Required"></asp:RequiredFieldValidator>
									<br />
									
									
							</TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">Unit Cost</TD>
							<TD bgColor="white">
								<asp:textbox id="txtUnitCost" runat="server"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1txtUnitCost" runat="server" Display="Dynamic" ControlToValidate="txtUnitCost"
									ErrorMessage="Required"></asp:RequiredFieldValidator><asp:RangeValidator ID="RangeValidator1"
										runat="server" Display="Dynamic" ErrorMessage="Invalid Number" MaximumValue="1000000"
										MinimumValue="0" Type="Currency" ControlToValidate="txtUnitCost"></asp:RangeValidator></TD>
						</TR>
						<TR>
							<TD bgColor="whitesmoke" style="width: 73px">Description</TD>
							<TD bgColor="white">
								<asp:textbox id="txtDescription" runat="server" Width="465px" TextMode="MultiLine" Height="96px"></asp:textbox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1txtDescription" runat="server" Display="Dynamic" ControlToValidate="txtDescription"
									ErrorMessage="Required"></asp:RequiredFieldValidator></TD>
						</TR>
						<tr runat="server">
							<td bgcolor="whitesmoke" style="width: 73px">
								Weight</td>
							<td runat="server" bgcolor="white">
								<asp:TextBox ID="txtWeight" runat="server" Width="84px">1</asp:TextBox>&nbsp;(pounds)
								<asp:RequiredFieldValidator
									ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtWeight" Display="Dynamic"
									ErrorMessage="Required"></asp:RequiredFieldValidator><asp:RangeValidator ID="RangeValidator2"
										runat="server" ControlToValidate="txtWeight" Display="Dynamic" ErrorMessage="Invalid Number"
										MaximumValue="1000000" MinimumValue="0" Type="Currency"></asp:RangeValidator></td>
						</tr>
						<tr runat="server">
							<td bgcolor="whitesmoke" style="width: 73px">
								Discount</td>
							<td runat="server" bgcolor="white">
								<asp:TextBox ID="txtDiscount" runat="server" Width="84px">0</asp:TextBox>&nbsp;<strong>%
									<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDiscount"
										Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>&nbsp;<asp:RangeValidator
											ID="RangeValidator3" runat="server" ControlToValidate="txtDiscount" Display="Dynamic"
											ErrorMessage="Invalid Percentage" MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator></strong></td>
						</tr>
						<tr id=trAmountOnHand runat=server>
							<td bgcolor="whitesmoke" style="width: 73px">
								Amount On Hand</td>
							<td bgcolor="white" id=tdAmountOnHand runat=server>
								<asp:Label ID="lblAmountOnHand" runat="server" Font-Bold="True" ForeColor="ForestGreen"></asp:Label></td>
						</tr>                        
						<tr id=trActive runat=server>
							<td bgcolor="whitesmoke" style="width: 73px">
								Is Active</td>
							<td bgcolor="white" id=td1 runat=server>
								<asp:CheckBox ID="chkIsActive" runat="server" /></td>
						</tr>                        

					</TABLE>
				</TD>
			</TR>
				<TR>
				<TD>
					<asp:Button id="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"></asp:Button>&nbsp;
					&nbsp;<asp:Button ID="btnPerm" runat="server" Text="Permanently Delete" OnClick="btnPerm_Click" /></TD>
				<TD align="right">
					&nbsp;<input type=button value="Return" onclick="location.href='admin_products.aspx'" /></TD>
			</TR>
		</TABLE>
		<BR>
		<TABLE id="tblInventory" cellSpacing="0" cellPadding="0" width="100%" runat="server">
			<TR>
				<TD>
					<table cellspacing="1" cellpadding="2" width="100%" bgcolor="white">
						<tr>
							<td height=25 class=sectionheader><b>Inventory</b></td>
						</tr>
					</table>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE id="Table5" cellSpacing="1" width="100%" bgColor="gainsboro">
						<TR>
							<TD vAlign="top" width="227" bgColor="whitesmoke">
								<P>Adjust your inventory<BR>
									<BR>
									Add items to your online inventory here. To debit this amount, enter a negative 
									number.</P>
								<P>Whenever an order is processed and paid for, the inventory is debited by that 
									amount.</P>
							</TD>
							<TD vAlign="top" bgColor="white">Add
								<asp:textbox id="txtAmountOnHand" runat="server" Width="40px">0</asp:textbox>&nbsp;Items
								<asp:RangeValidator id="Rangevalidator4" runat="server" Display="Dynamic" ControlToValidate="txtAmountOnHand"
									ErrorMessage="Invalid Number" MaximumValue="99999999" MinimumValue="0" Type="Integer"></asp:RangeValidator><BR>
								<asp:Button id="btnAdjustInventory" runat="server" Text="Adjust Inventory" OnClick="btnAdjustInventory_Click"></asp:Button><BR>
								<BR>
								
									<asp:GridView ID="dgInventory" runat="server" AutoGenerateColumns="False" width=100% CellPadding="4" ForeColor="#333333" GridLines="None">
										<Columns>
										<asp:BoundField DataField="ProductID" HeaderText="ID"></asp:BoundField>
										<asp:BoundField DataField="oldAmount" HeaderText="On Hand"></asp:BoundField>
										<asp:BoundField DataField="Adjustment" HeaderText="Adjustment"></asp:BoundField>
										<asp:BoundField DataField="datestamp" HeaderText="Date" DataFormatString="{0:d}"></asp:BoundField>
										<asp:BoundField HeaderText="Comment" DataField="Comment" ></asp:BoundField>
										</Columns>
										<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
										<RowStyle BackColor="#EFF3FB" />
										<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
										<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
										<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
										<EditRowStyle BackColor="#2461BF" />
										<AlternatingRowStyle BackColor="White" />
										
									</asp:GridView>
								
								
								</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</asp:panel>
	<script>
function CheckDelete(){
		
	return confirm("Permanently delete this product (product will not be deleted if there are orders associated with it)? This action cannot be undone...");

}
function loadPix(){
	imgArr = showModalDialog("ftb.imagegallery.aspx?rif=images/productimages&cif=images/productimages");

	if (imgArr != null) {
		imagestring = imgArr['filename'];
		lastslash=imagestring.lastIndexOf("/");
		filename=imagestring.substring(lastslash+1,imagestring.length);
		document.forms[0].ctl00_AdminPlaceHolder_txtProductImage.value=filename;
		document.forms[0].ctl00_AdminPlaceHolder_imgProductImage.src="../images/productimages/"+filename;
		

	} else {
		//alert("You did not select an image");
	}

}
	</script>
</asp:Content>

