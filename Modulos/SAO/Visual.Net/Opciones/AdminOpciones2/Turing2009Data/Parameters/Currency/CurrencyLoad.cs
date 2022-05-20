using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Currency
{

    public class CurrencyLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTCurrency;
            string _Currency;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTCurrency = new DataTable();

            _Currency = "";

            #endregion

            #region "Query"

            _Currency += "SET NOCOUNT ON\n";
            _Currency += "SELECT 'ID'            = id\n";
            _Currency += "     , 'SystemID'      = systemid\n";
            _Currency += "     , 'MNemonics'     = mnemonic\n";
            _Currency += "     , 'Description'   = description\n";
            _Currency += "     , 'DecimalPlace'  = decimalplace\n";
            _Currency += "     , 'Factor'        = factor\n";
            _Currency += "     , 'Flag'          = flag\n";
            _Currency += "  FROM dbo.tblCurrency\n";
            _Currency += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Currency, "Currency");
                _DTCurrency = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTCurrency = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTCurrency;
        }

    }

}
