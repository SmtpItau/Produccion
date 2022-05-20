using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using cData.DataLogin;
using System.Xml.Linq;
using AdminOpciones.Struct; //ASVG_20140923 Todavía queda StructError en Turing2009Definitions por migrar.

namespace AdminOpciones.Web.WebService
{
    /// <summary>
    /// Descripción breve de WebLogin
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebLogin : System.Web.Services.WebService
    {

        [WebMethod]
        public string PermisosMenu(string username)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = LoginMenu.LoginUser(username);            
            _ReturnValue += "<OpcionesMenu>";            

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue +=  "<Data " +
                                     "Entidad ='" + (_DataRow["entidad"].ToString()).ToString() + "' " +
                                     "Opcion  ='" + (_DataRow["opcion"].ToString()).ToString() + "' " +
                                     "Habilitado ='" + (_DataRow["habilitado"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Modulo cData.DataLogin.LoginMenu' />";
                _ReturnValue += _Mensaje;
            }            
            _ReturnValue += "</OpcionesMenu>";
            return _ReturnValue;
         }

        [WebMethod]
        public string ValidaPassword(string username)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = LoginMenu.ValidaPass(username);
            _ReturnValue += "<ValidaPass>";
            
            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    // CLAVE clave_anterior1 clave_anterior2 clave_anterior3 clave_anterior4 clave_anterior5 TIPO_USUARIO FECHA_EXPIRACION cambio_clave bloqueado
                    _ReturnValue += string.Format(
                                                   "<Data Clave='{0}' Clave1='{1}' Clave2='{2}' Clave3='{3}' Clave4='{4}' Clave5='{5}' TipoUsuario='{6}' FechaExpiracion='{7}' CambioClave='{8}' Bloqueado='{9}' ResetPassword='{10}' LargoClave='{11}' TipoClave='{12}' DiasExpira='{13}' />",
                                                   ChangePassword(_DataRow["CLAVE"].ToString()),                // 00
                                                   ChangePassword(_DataRow["clave_anterior1"].ToString()),      // 01
                                                   ChangePassword(_DataRow["clave_anterior2"].ToString()),      // 02
                                                   ChangePassword(_DataRow["clave_anterior3"].ToString()),      // 03
                                                   ChangePassword(_DataRow["clave_anterior4"].ToString()),      // 04
                                                   ChangePassword(_DataRow["clave_anterior5"].ToString()),      // 05
                                                   _DataRow["TIPO_USUARIO"].ToString(),                         // 06
                                                   _DataRow["FECHA_EXPIRACION"].ToString(),                     // 07
                                                   _DataRow["cambio_clave"].ToString(),                         // 08
                                                   _DataRow["bloqueado"].ToString(),                            // 09
                                                   _DataRow["reset_psw"].ToString(),                            // 10
                                                   _DataRow["Largo_Clave"].ToString(),                          // 11                                                    
                                                   _DataRow["Tipo_Clave"].ToString(),                            // 12
                                                   _DataRow["Dias_Expiracion"].ToString()                       // 13
                                                 );
                }
            }
            else 
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_Rescata_Datos_Usuario' />";
                _ReturnValue += _Mensaje;
            }            
            _ReturnValue += "</ValidaPass>";
            return _ReturnValue;
        }

        private string ChangePassword(string password)
        {
            return password.Replace("&", "&#38;").Replace("<", "&#60;").Replace(">", "&#62;");
        }

        [WebMethod]
        public string WebBloqueaUsuario(string username)
        {
            DataTable _DT = cData.DataLogin.LoginMenu.BloqueoUSuario(username);
            return "OK";
        }

        [WebMethod]
        public string WebEncript(string password)
        {
            return AdminOpcionesEncript.Encript.Encrypt(password);
        }

        [WebMethod]
        public string WebDesencrypt(string password)
        {
            return AdminOpcionesEncript.Encript.DesEcrypt(password);
        }

        [WebMethod]
        public string WebCambioClave(string userName, string currentPassword ,string newPassword, string repPassword, DateTime DateProcces)
        {
            string ReturnValue="";
            XDocument UserInfoXML = new XDocument();
            XElement xElementInfo ;            
            bool validation;
            string message ="";
            StructClave UserInfo;
            DataTable ResultTable = new DataTable();
            DataRow _DataRow;
            DateTime ProxExpiracion;
            cFinancialTools.BussineDate.Calendars calendar = new cFinancialTools.BussineDate.Calendars();

            calendar.Load();
            ProxExpiracion = new DateTime(DateProcces.Year, DateProcces.Month, DateProcces.Day );

            string passBD, pass1, pass2, pass3, pass4, pass5;
            int diasExp;
             

            // ---- Captura informacion del usuario ----

            UserInfoXML = XDocument.Parse(ValidaPassword(userName));

            xElementInfo = UserInfoXML.Element("ValidaPass").Element("Data");

            UserInfo = new StructClave(
                                       xElementInfo.Attribute("Clave").Value,
                                       xElementInfo.Attribute("Clave1").Value,
                                       xElementInfo.Attribute("Clave2").Value,
                                       xElementInfo.Attribute("Clave3").Value,
                                       xElementInfo.Attribute("Clave4").Value,
                                       xElementInfo.Attribute("Clave5").Value,
                                       xElementInfo.Attribute("TipoUsuario").Value,
                                       DateTime.Parse(xElementInfo.Attribute("FechaExpiracion").Value),
                                       xElementInfo.Attribute("CambioClave").Value,
                                       xElementInfo.Attribute("Bloqueado").Value.Equals("1") ? true : false,
                                       Convert.ToInt32(xElementInfo.Attribute("ResetPassword").Value),
                                       Convert.ToInt32(xElementInfo.Attribute("LargoClave").Value),
                                       xElementInfo.Attribute("TipoClave").Value,
                                       Convert.ToInt32(xElementInfo.Attribute("DiasExpira").Value)
                                      );

            passBD = UserInfo.Clave.Trim();
            pass1 = UserInfo.Clave1.Trim();
            pass2 = UserInfo.Clave2.Trim();
            pass3 = UserInfo.Clave3.Trim();
            pass4 = UserInfo.Clave4.Trim();
            pass5 = UserInfo.Clave5.Trim();
            diasExp = Convert.ToInt32(xElementInfo.Attribute("DiasExpira").Value);

            for (int i = 0; i < diasExp; i++)// días hábiles def. MAP 21-01-2010 TELEFONO.
            {
                ProxExpiracion = calendar.NextDate(6, ProxExpiracion);
            }
                

            // ---- 1.0 Validaciones Basicas ----
            message = "";
            validation = true;

            //1.1
            if (UserInfo.CambioClave != "S")
            {
                validation = false;
                message = "Usuario " + userName + " no tiene privilegios para cambiar contraseña";
            }
            //1.2
            if (validation && passBD != currentPassword)
            {
                validation = false;
                message = "Contraseña actual incorrecta";
            }
            //1.3
            if (validation && currentPassword == newPassword)
            {
                validation = false;
                message = "La nueva contraseña debe ser distinta de la contraseña anterior";
            }
            //1.4
            if (validation && newPassword != repPassword)
            {
                validation = false;
                message = "Nueva Contraseña y Repeticion de Nueva Contraseña no son igual";
            }
            //1.5
            if (validation && newPassword == pass1 || newPassword == pass2 ||
                newPassword == pass3 || newPassword == pass4 ||
                newPassword == pass5)
            {
                validation = false;
                message = "La nueva contraseña debe ser distinta de las 5 contraseñas anterior"; 
            }

            // ---- 2.0 Validaciones Segun Tipo de Contraseña ----

            //2.1  Validaciones para tipo de Datos Alfanumericos
            if (validation)
            {
                if(UserInfo.TipoClave == "A")
                {
                    ResultTable = cData.DataLogin.LoginMenu.CambioClave(userName, currentPassword, newPassword, repPassword, ProxExpiracion, DateProcces);
                }                
                else 
                {
                    validation = false;
                    message = "- El usuario tiene asignado un tipo de clave no alfanumerico \n Por favor contactarse con el administrador del sistema";
                }
            }
            

            if (validation)
            {
                _DataRow = ResultTable.Rows[0];
                if (_DataRow[0].ToString() != "-1")
                {                   
                    message = "- Cambio de clave exitoso \n";
                }
                else 
                {
                    validation = false;
                    message = message + _DataRow[1].ToString();
                }
            }
            
            ReturnValue += "<ValidaPass>";
            ReturnValue += string.Format("<Data Validation='{0}' Menssage='{1}' />", validation ? "TRUE":"FALSE", message);
            ReturnValue += "</ValidaPass>";
            return ReturnValue;
        }


        //CER 
        [WebMethod]
        public string FecProcHabilProx(DateTime DateProcces)
        {
            DataTable _DataResults = new DataTable();
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";


            DateTime ProxProcHabil;
            cFinancialTools.BussineDate.Calendars calendar = new cFinancialTools.BussineDate.Calendars();

            _ReturnValue += "<FecProcHabilProx>";

            ProxProcHabil = new DateTime(DateProcces.Year, DateProcces.Month, DateProcces.Day);

            calendar.Load();

            for (int i = 0; i < 3; i++)
            {
                ProxProcHabil = calendar.NextHolidayDate(6, ProxProcHabil);
            }

            _ReturnValue += string.Format("<Data ProxProcHabil='{0}' />", ProxProcHabil);

            _ReturnValue += "</FecProcHabilProx>";
            return _ReturnValue;


        }

     //   private string ValidacionAlfanumerica(string NuevaPass)
     //   {
     //       string ReturnMessage="";
     //       string newPastemp = "";
     //       int minLength, maxLength;            
     //       char ch1, ch2;
     //       //System.Text.RegularExpressions.Regex ExRegAlfa = new System.Text.RegularExpressions.Regex(@"^[A-Z]{1}[a-z]+[0-9]+$"); //Corpbanca01
     //       System.Text.RegularExpressions.Regex ExRegAlfa = new System.Text.RegularExpressions.Regex(@"[A-Z]+[a-z]*[0-9]+"); 
            
     //       minLength = 8;
     //       maxLength = 15;


     //       newPastemp = NuevaPass;
     //       NuevaPass = AdminOpcionesEncript.Encript.PwdDecrypts(newPastemp, false);

     //       if (NuevaPass.Length < minLength)
     //           ReturnMessage = ReturnMessage + "- Nueva Contraseña debe tener minimo " + minLength + " caracteres \n ";

     //       if (NuevaPass.Length > maxLength)
     //           ReturnMessage = ReturnMessage + "- Nueva Contraseña debe tener maximo " + maxLength + " caracteres \n ";

     //       if (!ExRegAlfa.IsMatch(NuevaPass))
     //           ReturnMessage = ReturnMessage + "- Formato incorrecto de la nueva contraseña \n ";

     //       for (int i = 0; i < NuevaPass.Length-1; i++)
     //       {
     //           ch1 = Convert.ToChar(NuevaPass[i]);
     //           ch2 = Convert.ToChar(NuevaPass[i+1]);
     //           if ((int)ch1 >= 48 && (int)ch1 <= 57 && (int)ch2 >= 48 && (int)ch2 <= 57 && ch1 == ch2)
     //               ReturnMessage = ReturnMessage + "- La nueva contraseña no debe tener dos numeros consecutivos iguales\n ";
     //       }

     //           return ReturnMessage;
     //   }

     }
}
