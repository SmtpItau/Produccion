using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Rate
{

    public class RateLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTRate;
            string _Rate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTRate = new DataTable();

            _Rate = "";

            #endregion

            #region "Query"

            _Rate += "SET NOCOUNT ON\n";
            _Rate += "SELECT 'ID'               = id\n";
            _Rate += "     , 'SystemID'         = systemid\n";
            _Rate += "     , 'SystemOriginalID' = systemoriginal\n";
            _Rate += "     , 'MNemonics'        = mnemonic\n";
            _Rate += "     , 'Description'      = description\n";
            _Rate += "  FROM dbo.tblRate\n";
            _Rate += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Rate, "Rate");
                _DTRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTRate;

        }

    }

}
