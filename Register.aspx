<%@ Page Language="vb" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="Register.aspx.vb" Inherits="Register" Title="Please Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<h1>Register</h1>
	<asp:CreateUserWizard ID="CreateUserWizard1" Enabled="false" Visible="false" runat="server" CancelDestinationPageUrl="~/Login.aspx" ContinueDestinationPageUrl="~/Default.aspx" FinishDestinationPageUrl="~/Default.aspx" OnCreatedUser="MigrateAnonymous">
		<WizardSteps>
			<asp:CreateUserWizardStep runat="server">
			</asp:CreateUserWizardStep>
			<asp:CompleteWizardStep runat="server">
			</asp:CompleteWizardStep>
		</WizardSteps>
			<HyperLinkStyle CssClass="sidemenulink" />
			<TitleTextStyle CssClass="sectionheader" />
			<InstructionTextStyle CssClass="plainbox" />
			<LabelStyle CssClass="checkoutlabel" />
	</asp:CreateUserWizard>
</asp:Content>

