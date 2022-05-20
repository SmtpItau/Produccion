using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.XML
{

    public class ManagementXML : InterfaceQuery
    {

        private const int LongSaveXML = 5000;

        public DataTable Save(string xml, int userID)
        {
            #region Definición de Variables

            Turing2009Connect.Connect _Connect;
            DataTable _DTXML;
            string _XML;
            string _SaveXML;
            string _Save;

            #endregion

            #region Inicialización de Variables

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTXML = new DataTable();

            _XML = xml;
            _SaveXML = "";
            _Save = "";

            #endregion

            #region Query

            _Save += "SET NOCOUNT ON\n\n";

            _Save += "DECLARE @keyID INT\n\n";

            _Save += "SELECT @keyID = ISNULL( MAX( keyID ), 0 ) + 1\n";
            _Save += "  FROM dbo.SaveXML\n\n";

            while (_XML != "")
            {
                if (_XML.Length > LongSaveXML)
                {
                    _SaveXML = _XML.Substring(0, LongSaveXML);
                    _XML = _XML.Substring(LongSaveXML);
                }
                else
                {
                    _SaveXML = _XML;
                    _XML = "";
                }

                _Save += string.Format(
                                        "INSERT INTO dbo.SaveXML ( keyid, comment, userID ) VALUES ( @keyID, '{0}', {1} )\n",
                                        _SaveXML.Replace("'","\""),
                                        userID.ToString()
                                      );

            }

            _Save += "SELECT 'KeyID' = @keyID\n\n";

            _Save += "SET NOCOUNT OFF\n";

            #endregion

            #region Ejecución del Query
            try
            {
                _Connect.Execute("Turing", _Save, "SaveXML");
                _DTXML = _Connect.Table;
                _Connect.Close();
                _Connect = null;
                return _DTXML;
            }
            catch (Exception _Error)
            {
                _DTXML = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }
            #endregion
        }

        public DataTable Load(string id)
        {
            #region Definición de Variables

            Turing2009Connect.Connect _Connect;
            DataTable _DTXML;
            string _XML;

            #endregion

            #region Inicialización de Variables

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTXML = new DataTable();

            _XML = "";

            #endregion

            #region Query

            _XML += "SET NOCOUNT ON\n\n";

            _XML += "SELECT id\n";
            _XML += "     , keyID\n";
            _XML += "     , comment\n";
            _XML += "     , userID\n";
            _XML += "  FROM dbo.SaveXML\n";
            _XML += " WHERE keyID  = 1\n\n";

            _XML += "SET NOCOUNT OFF\n";

            #endregion

            #region Ejecución del Query

            try
            {
                _Connect.Execute("Turing", _XML, "LoadXML");
                _DTXML = _Connect.Table;
                _Connect.Close();
                _Connect = null;
                return _DTXML;
            }
            catch (Exception _Error)
            {
                _DTXML = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }

            #endregion
        }

        public void Delete(string id)
        {
            #region Definición de Variables

            Turing2009Connect.Connect _Connect;
            string _XML;

            #endregion

            #region Inicialización de Variables

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _XML = "";

            #endregion

            #region Query

            _XML += "SET NOCOUNT ON\n\n";

            _XML += "DELETE dbo.SaveXML\n";
            _XML += " WHERE keyID  = " + id.ToString() + "\n\n";

            _XML += "SET NOCOUNT OFF\n";


            #endregion

            #region Ejecución del Query

            try
            {
                _Connect.QueryType = enumQueryType.Delete;
                _Connect.Execute("Turing", _XML, "LoadXML");
                _Connect.Close();
                _Connect = null;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }

            #endregion
        }

    }

}
