<%@ Page Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="RegistryUser.aspx.cs" Inherits="RegistryUser" Title="AMEN Gift Registry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1><asp:Literal ID="txtTitle" runat="server"></asp:Literal></h1>
<style>
td {font-size: 9pt;}
</style>
<table width="450" border="0" cellspacing="0" cellpadding="6">
  <tr>
    <td style="border-right: 1px solid black;"><table width="207" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td nowrap="nowrap" style="height: 18px; width: 78px;">Registry # </td>
        <td width="98" style="height: 18px">
            <asp:Literal ID="Literal1" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 78px"> Event Type </td>
        <td>&nbsp;<asp:Literal ID="Literal2" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td colspan="2" nowrap="nowrap"><strong>Primary Registrant/Bride</strong></td>
        </tr>
      <tr>
        <td nowrap="nowrap" style="width: 78px">Name </td>
        <td>&nbsp;<asp:Literal ID="Literal3" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 78px">Address</td>
        <td>&nbsp;<asp:Literal ID="Literal4" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 78px">Phone  </td>
        <td>&nbsp;<asp:Literal ID="Literal5" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 78px">E-Mail </td>
        <td>&nbsp;<asp:Literal ID="Literal6" runat="server"></asp:Literal></td>
      </tr>
    </table></td><td><table width="207" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td nowrap="nowrap" style="width: 76px">Reg. Date </td>
        <td width="81">
            <asp:Literal ID="Literal7" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 76px">Event Date </td>
        <td>&nbsp;<asp:Literal ID="Literal8" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td colspan="2" nowrap="nowrap"><strong>Secondary Registrant/Groom </strong></td>
        </tr>
      <tr>
        <td nowrap="nowrap" style="width: 76px">Name </td>
        <td>&nbsp;<asp:Literal ID="Literal9" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 76px">Address</td>
        <td>&nbsp;<asp:Literal ID="Literal10" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 76px">Phone </td>
        <td>&nbsp;<asp:Literal ID="Literal11" runat="server"></asp:Literal></td>
      </tr>
      <tr>
        <td nowrap="nowrap" style="width: 76px">E-Mail </td>
        <td>&nbsp;<asp:Literal ID="Literal12" runat="server"></asp:Literal></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td colspan="2">
        <asp:Literal ID="litTable" runat="server"></asp:Literal>    
    </td>
  </tr>
</table>
</asp:Content>

