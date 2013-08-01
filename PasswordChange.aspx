<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="PasswordChange.aspx.vb" Inherits="PasswordChange" Title="Change Your Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ChangePassword ID="ChangePassword1" runat="server" CancelDestinationPageUrl="~/Default.aspx"
		ContinueDestinationPageUrl="~/Default.aspx" CreateUserUrl="~/Register.aspx" PasswordRecoveryUrl="~/PasswordRecover.aspx"
		SuccessTitleText="Your password has been changed">
				<FailureTextStyle CssClass="errorbox" />
			<TitleTextStyle CssClass="sectionheader" />
			<InstructionTextStyle CssClass="plainbox" />
			<LabelStyle CssClass="checkoutlabel" />

	</asp:ChangePassword>
</asp:Content>

