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

public partial class Registry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        OdbcConnection cn = DB.GetConnection();
        OdbcCommand cmd = new OdbcCommand();
        cmd.Connection = cn;
        cmd.CommandText = "select * from amen_users_view where length(LastName1) > 1 order by LastName1 asc";
        doit:
        OdbcDataReader dr = cmd.ExecuteReader();
        StringBuilder sb = new StringBuilder("<ul>");
        while (dr.Read())
        {
            Object[] data = new Object[dr.FieldCount];
            dr.GetValues(data);
            sb.AppendFormat("<li style=\"font-size: 10pt;\"><a href=\"RegistryUser.aspx?id={0}\">{2}, {1}</a></li>", data);
        }
        dr.Close();
        sb.Append("</ul>");
        litRegistry.Text = sb.ToString();
        cmd.Dispose();
        cn.Close();
        cn.Dispose();
    }
}
