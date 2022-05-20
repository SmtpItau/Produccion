using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Convention
{

    public class ConventionLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTConvention;
            string _Convention;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTConvention = new DataTable();

            _Convention = "";

            #endregion

            #region "Query"

            _Convention += "SET NOCOUNT ON\n";
            _Convention += "SELECT 'ID'               = id\n";
            _Convention += "     , 'Description'      = description\n";
            _Convention += "     , 'SystemID'         = systemid\n";
            _Convention += "     , 'SystemOriginalID' = systemoriginal\n";
            _Convention += "  FROM dbo.tblConvention\n";
            _Convention += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Convention, "Convention");
                _DTConvention = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTConvention = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTConvention;
        }


    }

}
