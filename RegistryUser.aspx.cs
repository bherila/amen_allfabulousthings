using System;
using System.Text;
using System.Data.Odbc;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class RegistryUser : System.Web.UI.Page
{

    const string SQL_DP_NAME = "select * from amen_users where id = '{0}' order by LastName1 asc";
    const string SQL_DP_REGISTRY = "select * from amen_items where id = '{0}' order by Display_Index desc, item asc";
    const string SQL_DP_COMPLETE = "update amen_items set complete = '{0}' where id = '{1}'";

    protected void Page_Load(object sender, EventArgs e)
    {
        OdbcConnection cn = DB.GetConnection();
        OdbcCommand cmd = new OdbcCommand();
        StringBuilder sb = new StringBuilder();
        cmd.Connection = cn;
        cmd.CommandText = string.Format(SQL_DP_NAME, DB.Prime(Request["id"]));
        OdbcDataReader dr = cmd.ExecuteReader();
        if (!dr.Read())
            Response.Redirect("Registry.aspx?err=0");

        txtTitle.Text = "Gift Registry";
        Literal1.Text = Request["id"]; //ID dr["id"].ToString();
        Literal2.Text = ""; //TODO: Event Type
        Literal3.Text = dr["LastName1"].ToString() + ",&nbsp;" + dr["Name1"].ToString();
        Literal4.Text = dr["Address1"].ToString() + "<br>" +
                        dr["City1"].ToString() + ",&nbsp;" + dr["State1"].ToString() + "<br>" +
                        dr["Zip1"].ToString();
        Literal5.Text = dr["Phone1"].ToString();
        Literal6.Text = dr["Email1"].ToString();

        //TODO: Literal7, Literal8

        Literal9.Text = dr["LastName2"].ToString() + ",&nbsp;" + dr["Name2"].ToString();
        Literal10.Text = dr["Address2"].ToString() + "<br>" +
                        dr["City2"].ToString() + ",&nbsp;" + dr["State2"].ToString() + "<br>" +
                        dr["Zip2"].ToString();
        Literal11.Text = dr["Phone2"].ToString();
        Literal12.Text = dr["Email2"].ToString();

        dr.Close();

        sb.AppendLine("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"2\" style=\"border: 2px solid black;\">");
        sb.AppendLine("<tr>");
        sb.AppendLine("<td bgcolor=\"#D8E4F1\" style=\"border-bottom: 1px solid black; border-right: 1px solid gray;\"><strong>Item</strong></td>");
        sb.AppendLine("<td width=\"80\" bgcolor=\"#D8E4F1\" style=\"border-bottom: 1px solid black; border-right: 1px solid gray;\"><strong>Unit Price</strong></td>");
        sb.AppendLine("<td width=\"80\" bgcolor=\"#D8E4F1\" style=\"border-bottom: 1px solid black;\"><strong>Quantity</strong></td>");
        sb.AppendLine("</tr>");

        Page.Title = "AMEN Gift Registry";

        cmd.CommandText = string.Format(SQL_DP_REGISTRY, DB.Prime(Request["id"]));
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            // <!-- Prepare description 
            string Desc = dr["Item"].ToString();
            if (dr["ItemURL"].ToString().ToLower().StartsWith("http"))
                Desc = "<a href=\"" + dr["ItemURL"].ToString() + "\">" + Desc + "</a>";
            if (dr["Description"].ToString().Length > 0)
                Desc = Desc + "<br><i>" + Server.HtmlEncode(dr["Description"].ToString()) + "</i>";
            // --> 

            sb.AppendLine("<tr>");
            sb.Append("  <td bgcolor=\"#FFFFFF\" style=\"border-bottom: 1px solid gray; border-right: 1px solid gray;\">").Append(Desc).AppendLine("(</td>");
            sb.Append("  <td width=\"80\" bgcolor=\"#FFFFFF\" style=\"border-bottom: 1px solid gray; border-right: 1px solid gray;\">").Append(dr["Quantity"].ToString()).AppendLine("</td>");
            sb.Append("  <td width=\"80\" bgcolor=\"#FFFFFF\" style=\"border-bottom: 1px solid gray;\">").Append(Double.Parse(dr["Price"].ToString()).ToString("C")).AppendLine("</td>");
            sb.AppendLine("</tr>");
        }
        dr.Close();
        sb.AppendLine("</table>");
        litTable.Text = sb.ToString();
        cmd.Dispose();
        cn.Close();
        cn.Dispose();
    }
}
