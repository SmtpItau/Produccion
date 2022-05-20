using System;
using System.Data;
using System.Text;
using AdminOpciones.Web.Recursos;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BytesRoad.Net.Ftp;
using System.Configuration;

namespace AdminOpciones.Web.ExportaTexto
{
    public partial class ExportaTxt : System.Web.UI.Page
    {
        private string _fecha;
        private string _tipo;
        private string _mensaje = string.Empty;
        private string _Archivo = string.Empty;
        private static string _status = string.Empty;
        private DateTime _fechap;
        private DataTable _datos;
        /// <summary>
        /// Ruta física en servidor de aplicaciones para interfaces.
        /// Ej: "c://inetpub//wwwroot//adminopciones//btrader//";
        /// </summary>
        private static string __URL_Interfaz = "";
        private static string __URL_Message = ""; //"/Mensaje/Mensaje.aspx?status="; // ej: "/dmatamalavxp/AdminOpciones/Mensaje/Mensaje.aspx?status="

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // MAP 2010 Enero 14 __URL_Interfaz = ConfigurationManager.AppSettings["URL_Interfaz"];
                //<add key="URL_Interfaz" value="C://Alan//AdminOpcionesAsiatico//AdminOpciones.Web//Btrader//"/>
                //<add key="URL_Interfaz" value="d://AdminOpciones//Btrader//"/>
                __URL_Interfaz = Server.MapPath("")+"\\..\\Btrader\\";  // MAP 2010 Enero 21 OK en Sitio

                //__URL_Message = ConfigurationManager.AppSettings["URL_Message"];
                //__URL_Message = "http://localhost:4444/Mensaje/Mensaje.aspx";
                //ASVG_20140818 confirmar este cambio y eliminar using.
                //__URL_Message = AdminOpciones.Recursos.wsGlobales.FullUri + "Mensaje/Mensaje.aspx";
                __URL_Message = ConfigurationManager.AppSettings["FULLURI"].ToString() + "Mensaje/Mensaje.aspx";


                //Decodificar
                SecureQueryString qs = new SecureQueryString(Context.Request.QueryString["d"]);
                _tipo = qs["Tipo"];

                #region "Tipos Archivos"

                switch (_tipo)
                {
                    case "CntVoucher":
                        _fecha = qs["Fecha"];
                        Recursos.SerIContableOpc _SerIconta = new SerIContableOpc();
                        _datos = _SerIconta._InterContableOpc();
                        GridView1.DataSource = _datos;
                        GridView1.DataBind();
                        _ExportaTxt(_tipo);
                        break;
                    case "IntDerivados":
                        _fecha = qs["Fecha"];
                        Recursos.SerDerivados _SerDeriva = new SerDerivados();
                        _datos = _SerDeriva._InterfazDerivadosOpciones();
                        GridView1.DataSource = _datos;
                        GridView1.DataBind();
                        _ExportaTxt(_tipo);
                        break;
                    case "IntOperaciones":
                        _fecha = qs["Fecha"];
                        Recursos.SerOperaciones _SerOpera = new SerOperaciones();
                        _datos = _SerOpera._InterfazOperacionesOpciones();
                        GridView1.DataSource = _datos;
                        GridView1.DataBind();
                        _ExportaTxt(_tipo);
                        break;
                    case "IntBalance":
                        _fecha = qs["Fecha"];
                        Recursos.SerBalance _SerBalance = new SerBalance();
                        _datos = _SerBalance._InterfazBalanceOpciones();
                        GridView1.DataSource = _datos;
                        GridView1.DataBind();
                        _ExportaTxt(_tipo);
                        break;
                }
                #endregion
            }
            catch (Exception _Error)
            {
                _mensaje = _Error.Message;
                _status = "Err";
            }


            if (_mensaje == "Err")
            {
                string _Page = string.Format("{0}?Status={1}&mensaje={2}&NombreArchivo={3}&Path={4}", __URL_Message, _status, _mensaje, _Archivo, __URL_Interfaz);
                Response.Redirect(_Page);

            }

        }

        private void _ExportaTxt(string _tipo)
        {
            StringBuilder str = new StringBuilder();
            string strColumnName = string.Empty;
            string _cNombreArchivo = string.Empty;
            string _tipoArchivo = string.Empty;
            string _cDia = string.Empty;
            string _fechaProc = string.Empty;
            string _stringPath = string.Empty;
            StreamWriter sw;


            #region "Parametrización y llenado de Archivo"
            switch (_tipo)
            {
                case "CntVoucher":
                    //_cDia = string.Format("{0:d}", _fecha);
                    _fechap = DateTime.Parse(_fecha);
                    _cDia = _fechap.ToString("yyyyMMdd");
                    _fechaProc = _fechap.ToString("yyMMdd");
                    _cNombreArchivo = "GL58" + _fechaProc + ".DAT";
                    str = FormatoVoucher(str, _cDia);
                    _stringPath = "MDICont\\";
                    break;
                case "IntDerivados":
                    _fechap = DateTime.Parse(_fecha);
                    _cDia = _fechap.ToString("yyyyMMdd");
                    _fechaProc = _fechap.ToString("yyMMdd");
                    _cNombreArchivo = "DE49" + _fechaProc + ".DAT";
                    str = FormatoDerivados(str, _cDia);
                    _stringPath = "IBS\\OPT\\";
                    break;
                case "IntOperaciones":
                    _fechap = DateTime.Parse(_fecha);
                    _cDia = _fechap.ToString("yyyyMMdd");
                    _fechaProc = _fechap.ToString("yyMMdd");
                    _cNombreArchivo = "OP49" + _fechaProc + ".DAT";
                    str = FormatoOperaciones(str, _cDia);
                    _stringPath = "IBS\\OPT\\";
                    break;
                case "IntBalance":
                    _fechap = DateTime.Parse(_fecha);
                    _cDia = _fechap.ToString("yyyyMMdd");
                    _fechaProc = _fechap.ToString("yyMMdd");
                    _cNombreArchivo = "BO49" + _fechaProc + ".DAT";
                    str = FormatoBalance(str, _cDia);
                    _stringPath = "IBS\\OPT\\";
                    break;
            }
            #endregion

            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + _cNombreArchivo);
            Response.Charset = "";
            Response.ContentType = "application/vnd.text";

            #region Crea Archivo Texto

            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            sw = File.CreateText(__URL_Interfaz + _cNombreArchivo);
            Response.Write(str.ToString());
            sw.WriteLine(str.ToString());
            sw.Close();
            stringWrite.Dispose();
            htmlWrite.Dispose();

            #endregion

            _Archivo = _cNombreArchivo;

            #region Envia FTP

            try
            {
                string _FTP_Server = ConfigurationManager.AppSettings["FTP_Server"];
                string _FTP_UserName = ConfigurationManager.AppSettings["FTP_UserName"];
                string _FTP_Password = AdminOpcionesEncript.Encript.DesEcrypt(ConfigurationManager.AppSettings["FTP_Password"]);

                //UploadFile(500, "scl009", "pctraderftp", "Deptost06", _stringPath, _cNombreArchivo);
                UploadFile(500, _FTP_Server, _FTP_UserName, _FTP_Password, _stringPath, _cNombreArchivo);
            }
            catch (Exception _Error)
            {
                _status = "FTP";
                _mensaje = _Error.Message;
            }

            #endregion

            #region Redirecciona a la pagina de mensaje

            string _Page = string.Format("{0}?Status={1}&mensaje={2}&NombreArchivo={3}&Path={4}", __URL_Message, "", _mensaje, _cNombreArchivo, __URL_Interfaz);
            Response.Redirect(_Page);

            #endregion

        }

        //ASVG se declara private para que no se invoque sin haber definido previamente __URL_Interfaz
        private static void UploadFile(int Timeout, string FtpServer,string Username, string Password, string RemotePath,string LocalFile)
        {
            // Instancia el cliente FTP
            FtpClient client = new FtpClient();

            // Modo Pasivo
            client.PassiveMode = true;

            // Conectar al Servidor FTP
            client.Connect(Timeout, FtpServer, 21);
            client.Login(Timeout, Username, Password);

            string target = Path.Combine(RemotePath,
            Path.GetFileName(LocalFile)).Replace("\\", "/");

            client.PutFile(Timeout, target, __URL_Interfaz + LocalFile);

        }

        private StringBuilder FormatoVoucher(StringBuilder _str, string _cDia)
        {
            StringBuilder str = new StringBuilder();

            #region "Configuración Archivo Voucher"
            if (_datos.Rows.Count > 0)
            {
                foreach (DataRow row in _datos.Rows)
                {
                    string strRow = string.Empty;
                    foreach (DataColumn col in _datos.Columns)
                    {
                        if (strRow != "")
                        {
                            strRow = strRow + row[col.ColumnName].ToString();
                        }
                        else
                        {
                            strRow = row[col.ColumnName].ToString();
                        }
                    }


                    if (strRow.Length != 283)        // Ajusta Condicion de Borde, Corregig variable Control Interfaz Contable
                    {
                        throw new Exception("Formato no permitido al Generar Interfaz Contable");
                        //string _Page = string.Format("{0}?Status={1}&mensaje={2}&NombreArchivo={3}&Path={4}", __URL_Message, "Formato no permitido al Generar Interfaz Contable", "Err", "", "");
                        //Response.Redirect(_Page);
                    }

                    else
                    {
                        str.Append(strRow);
                        str.Append("\r\n");
                    }
                }
            }
            #endregion

            return str;
        }

        private StringBuilder FormatoDerivados(StringBuilder _str, string _cDia)
        {
            StringBuilder str = new StringBuilder();

            #region "Configuración Archivo Derivados"
            if (_datos.Rows.Count > 0)
            {
                int _count = 0;
                string _fRG = "";
                foreach (DataRow row in _datos.Rows)
                {

                    string strRow = string.Empty;
                    string aux_1 = "DE49";
                    string aux_2 = row[_datos.Columns[0]].ToString();
                    string aux_3 = string.Empty;
                    string aux_4 = row[_datos.Columns[7]].ToString();
                    string aux_5 = row[_datos.Columns[9]].ToString();
                    string aux_6 = row[_datos.Columns[11]].ToString();
                    string aux_7 = row[_datos.Columns[13]].ToString();
                    string aux_8 = row[_datos.Columns[14]].ToString();
                    string aux_9 = row[_datos.Columns[15]].ToString();
                    string aux_10 = row[_datos.Columns[16]].ToString();

                    DateTime _fec1 = DateTime.Parse(aux_2);
                    DateTime _fec2 = DateTime.Parse(aux_4);
                    decimal _valor = decimal.Parse(aux_5);
                    decimal _valor2 = decimal.Parse(aux_6);
                    decimal _valor3 = decimal.Parse(aux_7);
                    decimal _valor4 = decimal.Parse(aux_8);
                    decimal _valor5 = decimal.Parse(aux_9);
                    decimal _valor6 = decimal.Parse(aux_10);

                    //Cod Columnas de achivo VB   
                    string col_0 = _fec1.ToString("yyyyMMdd");              // 1
                    _fRG = col_0;
                    string col_1 = row[_datos.Columns[1]].ToString();     // 2
                    string col_2 = row[_datos.Columns[2]].ToString();     // 3
                    string col_3 = row[_datos.Columns[3]].ToString();     // 4   
                    string col_4 = row[_datos.Columns[4]].ToString();     // 5   
                    string col_5 = row[_datos.Columns[5]].ToString();     // 6   
                    string col_6 = row[_datos.Columns[6]].ToString();     // 7
                    string col_7 = _fec2.ToString("yyyyMMdd");              // 8
                    string col_8 = row[_datos.Columns[8]].ToString();     // 9

                    string col_9 = _valor.ToString("0000000000000000"); // 10
                    col_9 += (_valor % 1).ToString("00");

                    string col_10 = row[_datos.Columns[10]].ToString();  // 11

                    string col_11 = _valor2.ToString("0000000000000000"); // 12
                    col_11 += (_valor2 % 1).ToString("00");

                    string col_12 = row[_datos.Columns[12]].ToString();  // 13
                    string col_13 = ((Int64)_valor3).ToString("0000000000000000"); // 14
                    col_13 += (_valor3 % 1).ToString("00");
                    string col_14 = ((Int64)_valor4).ToString("0000000000000000"); // 15
                    col_14 += (_valor4 % 1).ToString("00");
                    string col_17 = row[_datos.Columns[17]].ToString();  // 18
                    string col_15 = ((Int64)_valor5).ToString("0000000000000000"); // 16
                    col_15 += (_valor5 % 1).ToString("00");
                    string col_16 = ((Int64)_valor6).ToString("0000000000000000"); // 17
                    col_16 += (_valor6 % 1).ToString("00");
                    string col_18 = row[_datos.Columns[19]].ToString();
                    string col_19 = row[_datos.Columns[20]].ToString();

                    strRow = "CL ";                                 // 1. COdigo ISO del pais
                    strRow += col_0;                                // 2. Fecha de la interfaz
                    strRow += aux_1.PadRight(14, ' ');              // 3. Numero de Identificador de la fuentes
                    strRow += "001";                                // 4. Codigo de La Empresa    
                    strRow += "MDIR";                               // 5. Familia de Producto
                    strRow += col_2;                                // 6. Tipo de Producto
                    strRow += col_1.PadRight(16, ' ');              // 7. Codigo Interno del Producto
                    strRow += " ";                                  // 8. Clase del producto
                    strRow += "M";                                  // 9. Tipologia del producto
                    strRow += col_0;                                // 10. Fecha Contabble 
                    strRow += "1  ";                                // 11. Codigo de Sucursal
                    strRow += col_5.PadRight(20, ' ');              // 12. Numero de Operacion
                    aux_3 = col_3 + col_4;
                    strRow += aux_3.PadRight(12, ' ');              // 13. Identificación del Cliente
                    strRow += col_6;                                // 14. Fecha de Inicio
                    strRow += col_7;                                // 15. Fecha de Vencimiento
                    strRow += col_8 == "0" ? "   " : col_8.PadRight(3, ' ');    // 16. Moneda de Compra SBIF
                    strRow += col_9.PadLeft(18, '0');                           // 17. Monto De Compra SBIF
                    strRow += col_10 == "0" ? "   " : col_10.PadRight(3, ' ');  // 18. Moneda de Venta SBIF 
                    strRow += col_11.PadLeft(18, '0');                          // 19. Monto De Venta SBIF
                    strRow += col_12;                                           // 20. Tipo de Vencimiento
                    strRow += col_13;                                           // 21. Valor C08 Compra
                    strRow += col_14;                                           // 22. Valor C08 Venta 
                    strRow += col_17.PadLeft(2, ' ');                           // 23. Indicador Tipo Tasa
                    strRow += col_17.PadLeft(2, ' ');                           // 24. Indicador Tipo Tasa
                    strRow += col_17.PadLeft(8, ' ');                           // 25. Fecha Cambio Tasa
                    strRow += col_17.PadLeft(8, ' ');                           // 26. Fecha prximo cambio de Tasa
                    strRow += col_15;                                           // 27. Valor Presente del activo
                    strRow += col_16;                                           // 28. Valor Presente del pasivo
                    strRow += col_18 == "0" ? "   " : col_18.PadRight(3,' ');   // 29. Moneda Pago Entra MAP 5203
                    strRow += col_19 == "0" ? "   " : col_19.PadRight(3, ' ');  // 30. Moneda Pago Sale  MAP 5203                                      

                    str.Append(strRow);
                    str.Append("\r\n");
                    _count++;

                }
                string _space = "";
                _count++;
                string _strFinal = "99" + _fRG + _count.ToString("0000000000") + _space.PadRight(234, ' ');
                str.Append(_strFinal);
            }
            #endregion

            else
            {
                int count2 = 0;
                string sp = "";
                string _strFinal = "99" + _fechap.ToString("yyyyMMdd") + count2.ToString("0000000001") + sp.PadRight(234, ' ');
                str.Append(_strFinal);
            }
            return str;
        }

        private StringBuilder FormatoOperaciones(StringBuilder _str, string _cDia)
        {
            StringBuilder str = new StringBuilder();

            #region "Configuración Archivo Operaciones"
            if (_datos.Rows.Count > 0)
            {
                int _count = 0;
                string _fRG = "";
                foreach (DataRow row in _datos.Rows)
                {
                    string strRow = string.Empty;
                    string aux_1 = "OP49";
                    string aux_2 = row[_datos.Columns[0]].ToString();
                    string aux_3 = string.Empty;
                    string aux_4 = string.Empty;
                    string aux_5 = row[_datos.Columns[9]].ToString();
                    string aux_6 = row[_datos.Columns[12]].ToString();
                    string aux_7 = row[_datos.Columns[14]].ToString();
                    string aux_8 = row[_datos.Columns[16]].ToString();
                    string aux_9 = row[_datos.Columns[29]].ToString();
                    string aux_10 = row[_datos.Columns[20]].ToString();
                    string aux_11 = row[_datos.Columns[30]].ToString();
                    string aux_12 = row[_datos.Columns[27]].ToString();
                    string aux_13 = row[_datos.Columns[21]].ToString();
                    string aux_14 = row[_datos.Columns[22]].ToString();
                    string aux_15 = row[_datos.Columns[24]].ToString();
                    
                    // Normativo
                    string aux_16 = row[_datos.Columns[38]].ToString();  // 39 Fecha del primer vencimiento



                    DateTime _fec1 = DateTime.Parse(aux_2);
                    DateTime _fec2 = DateTime.Parse(aux_5);
                    decimal _valor = decimal.Parse(aux_6);
                    decimal _valor1 = decimal.Parse(aux_7);
                    decimal _valor2 = decimal.Parse(aux_8);
                    decimal _valor3 = decimal.Parse(aux_9);
                    decimal _valor4 = decimal.Parse(aux_10);
                    decimal _valor5 = decimal.Parse(aux_11);
                    decimal _valor6 = decimal.Parse(aux_12);
                    decimal _valor7 = decimal.Parse(aux_13);
                    decimal _valor8 = decimal.Parse(aux_14);
                    decimal _valor9 = decimal.Parse(aux_15);

                    // Normativo
                    DateTime _fecPrimVenc = DateTime.Parse(aux_16);

                    //Cod Columnas de achivo VB
                    string col_0 = _fec1.ToString("yyyyMMdd");            // 1
                    _fRG = col_0;
                    string col_1 = row[_datos.Columns[1]].ToString();     // 2
                    string col_2 = row[_datos.Columns[2]].ToString();     // 3
                    string col_3 = row[_datos.Columns[3]].ToString();     // 4   
                    string col_4 = row[_datos.Columns[4]].ToString();     // 5   
                    string col_5 = row[_datos.Columns[5]].ToString();     // 6   
                    string col_6 = row[_datos.Columns[6]].ToString();     // 7
                    string col_7 = row[_datos.Columns[7]].ToString();     // 8
                    string col_8 = row[_datos.Columns[8]].ToString();     // 9
                    string col_9 = _fec2.ToString("yyyyMMdd");            // 10
                    string col_10 = row[_datos.Columns[10]].ToString();   // 11
                    string col_11 = row[_datos.Columns[11]].ToString();   // 12
                    string col_12 = (_valor).ToString("000000000000000000"); // 13
                    string col_13 = row[_datos.Columns[13]].ToString();  // 14
                    string col_14 = (_valor1).ToString("000000000000000000"); // 15
                    string col_15 = row[_datos.Columns[15]].ToString();  // 16
                    string col_16 = ((int)_valor2).ToString("000000000000000000"); // 17
                    string col_18 = row[_datos.Columns[18]].ToString();  // 19
                    string col_19 = row[_datos.Columns[19]].ToString();  // 20
                    string col_20 = ((int)_valor4).ToString("0000000000000000");  // 21
                    string col_21 = ((int)_valor7).ToString("000000000000000000");  // 22
                    string col_22 = ((int)_valor8).ToString("000000000000000000");  // 23
                    string col_23 = row[_datos.Columns[23]].ToString();  // 24
                    string col_24 = ((int)_valor9).ToString("000000000000"); // 25
                    string col_26 = row[_datos.Columns[26]].ToString();  // 27
                    string col_27 = ((int)_valor6).ToString("000000000000000000");  // 28
                    string col_28 = row[_datos.Columns[28]].ToString();  // 29
                    string col_29 = ((int)_valor3).ToString("0000000000000000");    // 30
                    string col_30 = ((int)_valor5).ToString("000000000000000000");  // 31
                    // Cambio Semantica, evaluar
                    string col_32 = row[_datos.Columns[31]].ToString();             // 32
                    string col_33 = row[_datos.Columns[32]].ToString();             // 33
                    string col_34 = row[_datos.Columns[33]].ToString();             // 34
                    string col_35 = row[_datos.Columns[34]].ToString();             // 35
                    string col_36 = row[_datos.Columns[35]].ToString();             // 36
                    string col_37 = row[_datos.Columns[36]].ToString();             // 37

                    string col_38 = row[_datos.Columns[37]].ToString();             // 38 (Riesgo Pais)

                    string col_39 = _fecPrimVenc.ToString("yyyyMMdd");              // 39 Fecha del primer vencimiento
                    string col_40 = row[_datos.Columns[39]].ToString();             // 40 Tipo de otorgamiento
                    string col_41 = row[_datos.Columns[40]].ToString();             // 41 Precio de la vivienda
                    string col_42 = row[_datos.Columns[41]].ToString();             // 42 Tipo de operación renegociada
                    string col_43 = row[_datos.Columns[42]].ToString();             // 43 Monto del pie pagado
                    string col_44 = row[_datos.Columns[43]].ToString();             // 44 Seguro de Remate
                    string col_45 = row[_datos.Columns[44]].ToString();             // 45 Dias de morosidad con que se efectuo la renegociación”.




                    strRow = "CL ";                         //  1. Codigo ISO de Pais 
                    strRow += col_0;            //  _cDia;  //  2. Fecha Contable
                    strRow += col_0;                        //  3. Fecha de La interfaz
                    strRow += aux_1.PadRight(14, ' ');      //  4. Numero identificador de la fuente
                    strRow += "001";                        //  5. Codigo de la empresa "001" 
                    strRow += "1  ";                        //  6. Codigo interno de Sucursal
                    strRow += "A  ";                        //  7. Status del Contrato
                    strRow += "1";                          //  8. Status crediticio 
                    strRow += "MDIR";                       //  9. Familia del producto
                    strRow += col_3.PadRight(4, ' ');       // 10. Tipo de Producto
                    strRow += col_2.PadRight(16, ' ');      // 11. Codigo interno de Producto
                    strRow += " ";                          // 12. Clase de Producto
                    strRow += "M";                          // 13. Tipologia de Producto
                    strRow += col_8;                        // 14. Fecha en que se abrio la operacion, POR HACER: revisar
                    strRow += col_0;                        // 15. Ultima fecha de devengamiento de intereses, OK
                    aux_3 = col_4.TrimEnd() + col_5;
                    strRow += aux_3.PadRight(12, ' ');      // 16. NUmero interno que identifica al cliente 
                    aux_3 = string.Empty;
                    strRow += col_6 == "0" ? aux_3.PadRight(10, ' ')
                                            : col_6.PadRight(10, ' ');  // 17. Codigo Interno de Centro de Costo
                    strRow += col_7.PadRight(20, ' ');      // 18. Numero de Operacion  
                    strRow += col_8;                        // 19. Fecha de Inicio
                    strRow += col_9;                        // 20. Fecha de vencimiento
                    strRow += aux_3.PadRight(8, ' ');       // 21. Fecha de Renovacion
                    strRow += "V";                          // 22. Indicador de Calculo de interes Vencido - Anticipado
                    strRow += col_10.PadRight(3, ' ');      // 23. Codigo Interno de Moneda
                    strRow += col_11;                       // 24. Signo Monto Capital Mda Origen
                    strRow += col_12;                       // 25. Monto Capital Mda. Origen
                    strRow += col_13;                       // 26. Signo Monto Capital Mda Local
                    strRow += col_14;                       // 27. Monto Capital en Moneda Local
                    strRow += aux_3.PadRight(18, '0');      // 28. Monto LCR en Moneda Extranjera
                    strRow += col_15;                       // 29. Signo Monto Reajuste Moneda Local
                    strRow += col_16;                       // 30. Monto Reajuste Moneda Local
                    strRow += "+";                          // 31. Signo Monto Interes Moneda Origen 
                    strRow += aux_3.PadRight(18, '0');      // 32. Monto Interes en Moneda Origen
                    strRow += "+";                          // 33. Signo Monto Interes Moneda Local
                    strRow += col_18.PadRight(18, '0');     // 34. Monto Interes en Moneda Local
                    strRow += col_19.PadRight(2, ' ');      // 35. Indicador Tasa Fija o Variable
                    strRow += aux_3.PadRight(4, ' ');       // 36. Codigo de Tasa Base
                    strRow += col_29;                       // 37. Tasa de Interes 
                    strRow += aux_3.PadRight(16, '0');      // 38. Tasa de Penalidad
                    strRow += "0";                          // 39. Codigo Calculo interes
                    strRow += aux_3.PadRight(16, '0');      // 40. Costo de Fondo de la operacion
                    strRow += aux_3.PadRight(5, ' ');       // 41. Codigo Costo de Fondo de la operacion
                    strRow += aux_3.PadRight(4, ' ');       // 42. Codigo Tasa de Penalidad
                    strRow += col_20;                       // 43. Spread de Tasa de Interes
                    strRow += aux_3.PadRight(16, '0');      // 44. Spread de Tasa Pool (costo de fondo de la operacion)
                    strRow += aux_3.PadRight(16, '0');      // 45. Spread de Tasa de Penalidad
                    strRow += col_26;                       // 46. Indicador si es activo o Pasivo
                    strRow += "+";                          // 47. Signo Monto Vencido no reportado
                    strRow += aux_3.PadRight(18, '0');      // 48. Deudas vencidas no incluidas en el estado deudor
                    strRow += "105";                        // 49. Tipo Tasa
                    strRow += aux_3.PadRight(2, '0');       // 50. Producto Transfronterizo
                    strRow += aux_3.PadRight(1, '0');       // 51. Tipo de operacion transfronterizo
                    strRow += "+";                          // 52. Signo monto de Comision Moneda Local
                    strRow += aux_3.PadRight(18, '0');      // 53. Monto Comision Moneda Local
                    strRow += aux_3.PadRight(8, ' ');       // 54. Fecha Otorgamiento Op. Extinguida
                    strRow += aux_3.PadRight(8, ' ');       // 55. Fecha en Cartera Vencida
                    strRow += aux_3.PadRight(8, ' ');       // 56. Fecha Fecha en mora
                    strRow += aux_3.PadRight(8, ' ');       // 57. Fecha en Cartera Castigada
                    strRow += col_34.PadRight(20, ' ');     // 58. Numero de Operacion Original
                    strRow += aux_3.PadRight(4, '0');       // 59. Numero de Cuotas remanente
                    strRow += aux_3.PadRight(4, '0');       // 60. Numero de Cuotas en mora
                    strRow += aux_3.PadRight(4, '0');       // 61. Numero total de Cuotas 
                    strRow += col_28;                       // 62. Destino de Las colocaciones
                    strRow += aux_3.PadRight(8, ' ');       // 63. Fecha Suspencion devengo de interes
                    strRow += aux_3.PadRight(8, ' ');       // 64. Fecha del ultimo pago de interes
                    strRow += "N";                          // 65. Indicador de Renovacion
                    strRow += aux_3.PadRight(8, ' ');       // 66. Fecha de Ultima renovacion 
                    strRow += aux_3.PadRight(8, ' ');       // 67. Fecha de Proximo Cambio de Tasa
                    strRow += aux_3.PadRight(8, ' ');       // 68. Fecha del ultimo cambio de Tasa
                    strRow += col_30;                       // 69. Monto Inicial en moneda Original
                    strRow += aux_3.PadRight(18, '0');      // 70. Saldo Disponible en moneda Local
                    strRow += aux_3.PadRight(18, '0');      // 71. Monto Mora 1 en moneda Local
                    strRow += aux_3.PadRight(18, '0');      // 72. Monto Mora 2 en moneda Local
                    strRow += aux_3.PadRight(18, '0');      // 73. Monto Mora 3 en moneda Local
                    strRow += col_27;                       // 74. Colocacion efectiva en moneda local
                    strRow += aux_3.PadRight(18, '0');      // 75. Linea de Credito
                    strRow += aux_3.PadRight(18, '0');      // 76. Pago Minimo en Moneda Local
                    strRow += " ";                          // 77. Indicador de Cobranza Judicial
                    strRow += col_21;                       // 78. Valor de Mercado en CLP
                    strRow += col_22;                       // 79. Valor Par o Nominal en CLP
                    strRow += col_23.Trim();                // 80. Tipo de Cartera
                    strRow += aux_3.PadLeft(3, '0');        // 81. Num. renegociacion
                    strRow += aux_3.PadLeft(4, '0');        // 82. Perioricidad de las cuotas       
                    strRow += aux_3.PadLeft(18, '0');       // 83. Monto Pagado
                    strRow += col_32.PadRight(1, ' ');      // 84. Tipo de Contrato, Revisar
                    strRow += col_33.PadRight(1, ' ');      // 85. Tipo de Operacion
                    strRow += " ";                          // 86. Modalidad de Entrega de Bienes
                    strRow += col_24.PadLeft(12, '0');      // 87. Valor de Opcione de Compra, Art 84 para derivados
                    strRow += aux_3.PadRight(5, ' ');       // 88. Identificacion del Tipo de Instrumento
                    strRow += aux_3.PadRight(15, ' ');      // 89. Identificacion del Emisor del Instrumento
                    strRow += aux_3.PadRight(4, ' ');       // 90. Serie registrada en el instrumento 
                    strRow += aux_3.PadRight(4, ' ');       // 91. SubSerie registrada en el instrumento 

            //      strRow += aux_3.PadRight(3, ' ');       // 92. Categoria de Riesgo asignada al instrumento
                    strRow += col_38.PadRight(3, ' ');      // 92. Categoria de Riesgo asignada al instrumento

                    strRow += aux_3.PadRight(16, '0');      // 93. Tasa limite
                    strRow += aux_3.PadRight(4, '0');       // 94. Perioricidad de tasa despues de periodo Fijo , 806
                    strRow += col_35.ToString().PadLeft(18, '0');      // 95. Monto Mora 4 
                    strRow += col_36.PadLeft(18, '0');      // 96. Monto Mora 5 
                    strRow += col_37.PadLeft(18, '0');      // 97. Monto Mora 6 
                    strRow += "S";                          // 98. Indicador SBIF
                    strRow += aux_3.PadRight(18, '0');      // 99. Otros Cobros para mora 
                                                            // Cambios solicitados por SIGIR
                    strRow += aux_3.PadRight(18, '0');      // 100. Monto Mora 7
                    strRow += aux_3.PadRight(18, '0');      // 101. Monto Mora 8
                    strRow += aux_3.PadRight(18, '0');      // 102. Monto Mora 9
                    strRow += " ";                          // 103. Origen activo

                    strRow += "".PadRight(8, '0');           // 104. Fecha del primer vencimiento
                    strRow += col_40.PadRight(1, ' ');       // 105. Tipo de otorgamiento
                    strRow += col_41.PadRight(19,'0');       // 106. Precio de la vivienda
                    strRow += col_42.PadRight(1, ' ');       // 107. Tipo de operación renegociada
                    strRow += col_43.PadRight(19,'0');       // 108. Monto del pie pagado
                    strRow += col_44.PadRight(1,' ');        // 109. Seguro de Remate
                    strRow += col_45.PadRight(8, '0');       // 110. Dias de morosidad con que se efectuo la renegociación”.


                    str.Append(strRow);
                    str.Append("\r\n");
                    _count++;
                }
                string _space = "";
                _count++;
                string _strFinal = "99" + _fRG + _count.ToString("0000000000") + _space.PadRight(914, ' '); // 859 + 55
                str.Append(_strFinal);
            }
            #endregion

            else
            {
                int count2 = 0;
                string sp = "";
                string _strFinal = "99" + _fechap.ToString("yyyyMMdd") + count2.ToString("0000000001") + sp.PadRight(914, ' '); // 859 + 55
                str.Append(_strFinal);
            }

            return str;
        }

        private StringBuilder FormatoBalance(StringBuilder _str, string _cDia)
        {
            StringBuilder str = new StringBuilder();


            #region "Cofiguración Archivo Balance"
            if (_datos.Rows.Count > 0)
            {
                DateTime _fec1 = new DateTime();
                int _count = 0;
                foreach (DataRow row in _datos.Rows)
                {
                    string strRow = string.Empty;
                    string aux_1 = "BO49";
                    string aux_2 = row[_datos.Columns[5]].ToString();
                    string aux_3 = string.Empty;
                    string aux_4 = row[_datos.Columns[14]].ToString();
                    string aux_5 = row[_datos.Columns[9]].ToString();
                    string aux_6 = row[_datos.Columns[11]].ToString();
                    string aux_7 = row[_datos.Columns[13]].ToString();
                    string aux_8 = row[_datos.Columns[4]].ToString();

                    decimal _valor = decimal.Parse(aux_2);
                    decimal _valor1 = decimal.Parse(aux_4);
                    decimal _valor2 = decimal.Parse(aux_5);
                    decimal _valor3 = decimal.Parse(aux_6);
                    decimal _valor4 = decimal.Parse(aux_7);

                    _fec1 = DateTime.Parse(aux_8);


                    //Cod Columnas de achivo VB
                    string col_1 = row[_datos.Columns[1]].ToString();     // 2
                    string col_2 = row[_datos.Columns[2]].ToString();     // 3
                    string col_3 = row[_datos.Columns[3]].ToString();     // 4   
                    string col_4 = row[_datos.Columns[4]].ToString();     // 5   
                    string col_5 = ((Int64)_valor).ToString();                     // 6   
                    string col_6 = row[_datos.Columns[6]].ToString();     // 7                   
                    string col_8 = row[_datos.Columns[8]].ToString();     // 9
                    string col_9 = (_valor2).ToString("000000000000000000");    // 10
                    string col_10 = row[_datos.Columns[10]].ToString();  // 11
                    string col_11 = (_valor3).ToString("000000000000000000");   // 12
                    string col_12 = row[_datos.Columns[12]].ToString();  // 13
                    string col_13 = ((int)_valor4).ToString("000000000000000000");   // 14
                    string col_14 = ((int)_valor1).ToString("00");               // 15                    

                    strRow = "CL ";                                      //  1. Código ISO de País
                    strRow += _fec1.ToString("yyyyMMdd");                //  2. Fecha en la que se generó la interfaz.
                    strRow += aux_1.PadRight(14, ' ');                   //  3. Código único de identificación del archivo.
                    strRow += "001";                                     //  4. Código de empresa
                    strRow += "MDIR";                                    //  5. Familia del producto
                    strRow += col_2.PadRight(4, ' ');                    //  6. Tipo de producto
                    strRow += col_1.PadRight(16, ' ');                   //  7. Código Interno de Producto
                    strRow += " ";                                       //  8. Clase del producto
                    strRow += "M";                                       //  9. Tipologia del producto
                    strRow += col_3.PadRight(20, ' ');                   // 10. Numero de operación
                    strRow += _fec1.ToString("yyyyMMdd");                // 11. Fecha Contable
                    strRow += col_5;                                     // 12. Código de Cuenta
                    strRow += aux_3.PadRight(20 - col_5.Length, ' ');    //     Relleno con Blancos del campo 12
                    strRow += col_14;                                    // 13. Moneda Contable
                    strRow += col_6;                                     // 14. Indicador debito-credito
                    strRow += "0" + aux_3.PadRight(2, ' ');              // 15. Código de Evento Contable
                    strRow += col_8;                                     // 16. Signo Balance Moneda Original
                    strRow += col_9;                                     // 17. Balance en Moneda Original                    
                    strRow += col_10;                                    // 18. Signo Balance Moneda Local
                    strRow += col_11;                                    // 19. Balance Moneda Local
                    strRow += col_12.PadRight(1, ' ');                   // 20. Signo Balance Local Agregado        
                    strRow += col_13;                                    // 21. Balance Agregado en Moneda Local
                    strRow += "1  ";                                     // 22. Código Interno de Sucursal
                    strRow += aux_3.PadRight(10, ' ');                   // 23. Código Interno de Centro de Costo                   

                    str.Append(strRow);
                    str.Append("\r\n");
                    _count++;
                }
                string _space = "";
                _count++;

                string _strFinal = "99" + _fec1.ToString("yyyyMMdd") + _count.ToString("0000000000") + _space.PadRight(158, ' ');

                str.Append(_strFinal);
            }
            #endregion

            else
            {
                int count2 = 0;
                string sp = "";
                string _strFinal = "99" + _fechap.ToString("yyyyMMdd") + count2.ToString("0000000001") + sp.PadRight(158, ' ');
                str.Append(_strFinal);
            }

            return str;
        }

    }
}
