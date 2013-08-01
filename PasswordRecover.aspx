<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="PasswordRecover.aspx.vb" Inherits="PasswordRecover" Title="Recover Your Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<h1>
		Recover Your Password</h1>
	<p>
		<asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
			<FailureTextStyle CssClass="errorbox" />
			<TitleTextStyle CssClass="sectionheader" />
			<InstructionTextStyle CssClass="plainbox" />
			<LabelStyle CssClass="checkoutlabel" />

		</asp:PasswordRecovery>
		&nbsp;</p>
</asp:Content>

