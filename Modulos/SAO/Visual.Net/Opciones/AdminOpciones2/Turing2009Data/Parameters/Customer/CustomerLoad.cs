using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Customer
{

    public class CustomerLoad : InterfaceQuery
    {

        public DataTable Load(int customerType)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTCustomer;
            string _Customer;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTCustomer = new DataTable();

            _Customer = "";

            #endregion

            #region "Query"

            _Customer += "SET NOCOUNT ON\n";
            _Customer += "SELECT 'ID'       = clrut\n";
            _Customer += "     , 'VD'       = cldv\n";
            _Customer += "     , 'Code'     = clcodigo\n";
            _Customer += "     , 'Name'     = clnombre\n";
            _Customer += "     , 'Type'     = cltipcli\n";
            _Customer += "     , 'TypeName' = tbglosa\n";
            _Customer += "  FROM Cliente\n";
            _Customer += "       INNER JOIN dbo.TABLA_GENERAL_DETALLE  ON tbcateg   = 72\n";
            _Customer += "                                            AND tbcodigo1 = cltipcli\n";

            if (!customerType.Equals(0))
            {
                _Customer += string.Format(" WHERE cltipcli =  {0}\n", customerType.ToString());
            }

            _Customer += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACPARAMSUDA", _Customer, "Customer");
                _DTCustomer = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTCustomer = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTCustomer;

        }

        public DataTable Type()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTCustomerType;
            string _CustomerType;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTCustomerType = new DataTable();

            _CustomerType = "";

            #endregion

            #region "Query"

            _CustomerType += "SET NOCOUNT ON\n";
            _CustomerType += "SELECT 'Code' = CAST( tbcodigo1 as int )\n";
            _CustomerType += "     , 'Name' = tbglosa\n";
            _CustomerType += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
            _CustomerType += " WHERE tbcateg = 72\n";
            _CustomerType += " ORDER BY CAST( tbcodigo1 as int )\n";
            _CustomerType += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACPARAMSUDA", _CustomerType, "CustomerType");
                _DTCustomerType = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTCustomerType = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTCustomerType;

        }

    }

}
