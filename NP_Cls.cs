using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;

/// <summary>
/// Summary description for NP_Cls
/// </summary>
public class NP_Cls
{
    #region "Global Variable"
    SqlDataAdapter myda;
    SqlConnection conn;
    SqlCommand command;
    DataSet ds;
    public static string sqlSelect = String.Empty;
    public static string sqlInsert = String.Empty;
    public static string sqlUpdate = String.Empty;
    public static string sqlDelete = String.Empty;
    public static System.Globalization.CultureInfo cul = new System.Globalization.CultureInfo("En-us");
    
    public static string strconn = ConfigurationSettings.AppSettings["ConnectionString"];
    public static string strconnIT = ConfigurationSettings.AppSettings["ConnectionStringIT"];
    public static string strconnBio = ConfigurationSettings.AppSettings["ConnectionStringBIO"];
   

    public static string strErr = string.Empty;
    #endregion
    public static class Comp_Entity
    {
        public const string En_Investigation = "cmp_investigation"; public const string En_Correction = "cmp_correction"; public const string En_CorAction = "cmp_cor_action";
        public const string En_PreAction = "cmp_pre_action"; public const string En_Follow = "cmp_follow";
    }
    public bool SQLCommand(string strsql, ref string strErr)
    {
        conn = new SqlConnection(strconn);
        try
        {
            if (conn.State == ConnectionState.Open) { conn.Close(); }
            conn.Open();
            command = new SqlCommand(strsql, conn);
            command.ExecuteNonQuery();
            return true;
        }
        catch (Exception ex)
        {
            strErr = ex.Message;
            return false;
        }
        finally
        {
            conn.Close();
            conn.Dispose();
        }
    }
    public DataSet GetWithTran(string strsql, SqlConnection conn, SqlTransaction tr)
    {
        try
        {
            SqlCommand cmdSe = new SqlCommand();
            cmdSe.CommandText = strsql;
            cmdSe.Connection = conn;
            cmdSe.Transaction = tr;
            SqlDataAdapter da = new SqlDataAdapter(cmdSe);
            DataSet ds = new DataSet();
            da.Fill(ds, "SE");
            return ds;
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }

    public DataSet ExecuteIT(string strsql, ref string strErr)
    {
        try
        {
            conn = new SqlConnection(strconnIT);
            myda = new SqlDataAdapter(strsql, conn);
            ds = new DataSet();
            myda.Fill(ds);

            return ds;
        }
        catch (Exception ex)
        {
            strErr = ex.Message;
            ds = new DataSet();
            return ds;
        }
        finally
        {
            if (conn.State == ConnectionState.Open) { conn.Close(); }
        }
    }
    public DataSet ExecuteBio(string strsql, ref string strErr)
    {
        try
        {
            conn = new SqlConnection(strconnBio);
            myda = new SqlDataAdapter(strsql, conn);
            ds = new DataSet();
            myda.Fill(ds);

            return ds;
        }
        catch (Exception ex)
        {
            strErr = ex.Message;
            ds = new DataSet();
            return ds;
        }
        finally
        {
            if (conn.State == ConnectionState.Open) { conn.Close(); }
        }
    }

    public DataSet Execute(string strsql, ref string strErr)
    {
        try
        {
            conn = new SqlConnection(strconn);
            myda = new SqlDataAdapter(strsql, conn);
            ds = new DataSet();
            myda.Fill(ds);

            return ds;
        }
        catch (Exception ex)
        {
            strErr = ex.Message;
            ds = new DataSet();
            return ds;
        }
        finally
        {
            if (conn.State == ConnectionState.Open) { conn.Close(); }
        }
    }
    public DataTable Execute(string strsql, string TableName, ref string strErr)
    {
        try
        {
            conn = new SqlConnection(strconn);
            myda = new SqlDataAdapter(strsql, conn);
            ds = new DataSet();
            myda.Fill(ds, TableName);

            return ds.Tables[0].Copy();
        }
        catch (Exception ex)
        {
            strErr = ex.Message;
            ds = new DataSet();
            return ds.Tables[0].Copy();
        }
        finally
        {
            if (conn.State == ConnectionState.Open) { conn.Close(); }
        }
    }
    public DateTime setDate(string txtDate)
    {
        string SDate = txtDate.ToString();
        string[] tempSDate = System.Text.RegularExpressions.Regex.Split(SDate, "/");
        int SDay = Convert.ToInt16(tempSDate[0]);
        int SMonth = Convert.ToInt16(tempSDate[1]);
        int SYear = Convert.ToInt16(tempSDate[2]);
        DateTime StartDate = new DateTime(SYear, SMonth, SDay);
        return StartDate;
    }
    public string exDate(string strDate)
    {
        string SDate = strDate.ToString();
        string[] tempSDate = System.Text.RegularExpressions.Regex.Split(SDate, "/");
        string SDay = Convert.ToString(tempSDate[0]);
        string SMonth = Convert.ToString(tempSDate[1]);
        switch (SMonth.ToString())
        {
            case "01":
                SMonth = "ม.ค.";
                break;
            case "02":
                SMonth = "ก.พ.";
                break;
            case "03":
                SMonth = "มี.ค.";
                break;
            case "04":
                SMonth = "เม.ย.";
                break;
            case "05":
                SMonth = "พ.ค.";
                break;
            case "06":
                SMonth = "มิ.ย.";
                break;
            case "07":
                SMonth = "ก.ค.";
                break;
            case "08":
                SMonth = "ส.ค.";
                break;
            case "09":
                SMonth = "ก.ย'";
                break;
            case "10":
                SMonth = "ต.ค.";
                break;
            case "11":
                SMonth = "พ.ย'";
                break;
            case "12":
                SMonth = "ธ.ค.";
                break;
            default:
                SMonth = "Nothing";
                break;
        }
        string SYear = Convert.ToString(Convert.ToInt16(tempSDate[2]) + 543);
        return SDay + "-" + SMonth + "-" + SYear;
    }

    public string RetMonthName(int intMonth)
    {
        switch (intMonth)
        {
            case 1:
                return "January";
            case 2:
                return "February";
            case 3:
                return "March";
            case 4:
                return "April";
            case 5:
                return "May";
            case 6:
                return "June";
            case 7:
                return "July";
            case 8:
                return "August";
            case 9:
                return "September";
            case 10:
                return "October";
            case 11:
                return "November";
            case 12:
                return "December";
            default:
               return string.Empty;
        }
    }
    public static Int32 GetID(SqlConnection oConn, SqlTransaction Tr, string strEntity, string str_non_docno)
    {
        string strTmp = "SELECT top(1) autoid From " + strEntity + " WHERE (non_docno = '"+ str_non_docno +"') order by autoid desc";
        SqlCommand cmdGet = new SqlCommand(strTmp, oConn, Tr);
        SqlDataAdapter da = new SqlDataAdapter(cmdGet);
        DataSet ds = new DataSet(); da.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            return Convert.ToInt32(ds.Tables[0].Rows[0][0]) + 1;
        }
        else
        {
            return 1;
        }
    }

    public string EnText(string wantEn)
    {
        EncryptionClassLibrary.Encryption.Symmetric sym = new EncryptionClassLibrary.Encryption.Symmetric(EncryptionClassLibrary.Encryption.Symmetric.Provider.Rijndael, true);
        EncryptionClassLibrary.Encryption.Data key = new EncryptionClassLibrary.Encryption.Data("IMMYNAPANN");
        EncryptionClassLibrary.Encryption.Data encryptedData = new EncryptionClassLibrary.Encryption.Data();

        encryptedData = sym.Encrypt(new EncryptionClassLibrary.Encryption.Data(wantEn), key);
        return encryptedData.ToHex();
    }
    public string DeText(string wantDe)
    {
        EncryptionClassLibrary.Encryption.Symmetric sym = new EncryptionClassLibrary.Encryption.Symmetric(EncryptionClassLibrary.Encryption.Symmetric.Provider.Rijndael, true);
        EncryptionClassLibrary.Encryption.Data key = new EncryptionClassLibrary.Encryption.Data("IMMYNAPANN");
        EncryptionClassLibrary.Encryption.Data encryptedData = new EncryptionClassLibrary.Encryption.Data();

        encryptedData.Hex = wantDe;
        EncryptionClassLibrary.Encryption.Data decryptedData = new EncryptionClassLibrary.Encryption.Data();
        decryptedData = sym.Decrypt(encryptedData, key);

        return decryptedData.ToString();
    }

}
