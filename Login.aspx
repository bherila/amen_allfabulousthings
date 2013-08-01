<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Login.aspx.vb" Inherits="Login" Title="Commerce Starter Kit Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<h1>
		Login</h1>
	<div class="plainbox">
		<asp:Login ID="Login1" runat="server" CreateUserText="Register" CreateUserUrl="~/Register.aspx"
			PasswordRecoveryText="Forgot Password?" PasswordRecoveryUrl="~/PasswordRecover.aspx" CssClass="plainbox" OnLoggedIn="LogInUser">
			<FailureTextStyle CssClass="errorbox" />
			<CheckBoxStyle CssClass="checkoutlabel" />
			<HyperLinkStyle CssClass="sidemenulink" />
			<TitleTextStyle CssClass="sectionheader" />
			<InstructionTextStyle CssClass="plainbox" />
			<LabelStyle CssClass="checkoutlabel" />
		</asp:Login>
		&nbsp;</div>
</asp:Content>

