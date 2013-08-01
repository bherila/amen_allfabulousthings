<%@ Page Language="vb"  AutoEventWireup="true" CodeFile="PayPalRecord.aspx.vb" Inherits="PayPalRecord" Title="PayPal Record"%>
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
		<title="PayPal Record"></title>
	</head>
	<body>
		<div>
		<h1>PayPal Transaction Record</h1>
		The following is the record of this transaction, taken directly from PayPal.
		<br />
			<asp:Label ID="lblTransaction" runat="server" Text=""></asp:Label>
		</div>
   
	</body>
</html>



