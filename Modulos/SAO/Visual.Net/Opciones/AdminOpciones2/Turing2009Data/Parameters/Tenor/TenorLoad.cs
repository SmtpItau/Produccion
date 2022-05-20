using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Tenor
{

    public class TenorLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTStandarTenor;
            string _StandarTenor;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTStandarTenor = new DataTable();

            _StandarTenor = "";

            #endregion

            #region "Query"

            _StandarTenor += "SET NOCOUNT ON\n";
            _StandarTenor += "SELECT 'ID'    = ID\n";
            _StandarTenor += "     , 'Tenor' = Term\n";
            _StandarTenor += "     , 'Name'  = Description\n";
            _StandarTenor += "  FROM dbo.StandardTerm\n";
            _StandarTenor += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _StandarTenor, "StandarTenor");
                _DTStandarTenor = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTStandarTenor = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTStandarTenor;

        }


    }

}
