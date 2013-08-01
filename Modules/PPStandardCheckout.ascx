<%@ Control Language="vb" AutoEventWireup="true" CodeFile="PPStandardCheckout.ascx.vb" Inherits="Modules_PPStandardCheckout" %>
<div class=sectionheader>Checkout with PayPal</div>
<div class=plainbox>
You are about to be redirected to PayPal.com to purchase this order. 
Once payment is completed, please be sure to let PayPal redirect you 
back to this site. When PayPal redirects you, they send along your transaction 
information which we need in order to complete and reconcile your payment.
</div>
<br />
<center>
	<asp:Button ID=btnContinue runat=server Text="Continue" OnClick="btnContinue_Click" /><br />
</center>