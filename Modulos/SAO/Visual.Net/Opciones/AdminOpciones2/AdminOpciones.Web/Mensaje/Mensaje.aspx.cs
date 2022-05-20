using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI.HtmlControls;

namespace AdminOpciones.Web.Mensaje
{
    public partial class Mensaje : System.Web.UI.Page
    {
        string Archivo;
        string Error;
        string Status;
        string Path;
        string Message;

        protected void Page_Load(object sender, EventArgs e)
        {
            Archivo = Request["NombreArchivo"];
            Error = Request["mensaje"];
            Status = Request["status"];
            Path = Request["Path"];

            if (!IsPostBack)
            {
                btnConfirmar.Enabled = false;
                btnCancelar.Enabled = true;

                if (Status == "" || Status == "FTP")
                {
                    Message = string.Format("La interfaz {0} fue exitosamente generada en Scl009 - pctraderftp\n ¿Desea bajar una copia?", Archivo);
                    btnConfirmar.Enabled = true;
                }
                else
                {
                    Message = "Se produjo un Error: " + Error;
                }

                lblMessage.Text = Message;
            }
        }


        private void DownloadFile(string path, string fname)
        {
            string name = path + fname;
            Response.AppendHeader("content-disposition", "attachment; filename=" + fname);
            Response.WriteFile(name);
            Response.End();
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            DownloadFile(Path, Archivo);
            CloseWindows();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            CloseWindows();
        }

        private void CloseWindows()
        {
            Response.Write("<script language='JavaScript'>window.close();</script>");
        }

    }
}
