using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.User
{

    public class UserLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTUser;
            string _User;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTUser = new DataTable();

            _User = "";

            #endregion

            #region "Query"

            _User = QueryUser(0);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _User, "UserTable");
                _DTUser = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTUser = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTUser;
        }

        public DataTable Load(int userID)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTUser;
            string _User;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTUser = new DataTable();

            _User = "";

            #endregion

            #region "Query"

            _User = string.Format(QueryUser(1), userID.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _User, "UserTable");
                _DTUser = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTUser = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTUser;

        }

        public DataTable Load(string userNick)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTUser;
            string _User;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTUser = new DataTable();

            _User = "";

            #endregion

            #region "Query"

            _User = string.Format(QueryUser(2), userNick);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _User, "UserTable");
                _DTUser = _Connect.Table;
                _Connect.Close();
                _Connect = null;
                return _DTUser;
            }
            catch (Exception _Error)
            {
                _DTUser = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }

            #endregion
        }

        public DataTable SaveChangePassword(int userID, string password)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTUser;
            string _User;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTUser = new DataTable();

            _User = "";

            #endregion

            #region "Query"

            _User += "SET NOCOUNT ON\n";
            _User += "UPDATE dbo.UserTable\n";
            _User += "   SET password = '{1}'\n";
            _User += " WHERE id       = '{0}'\n";
            _User += "SET NOCOUNT OFF\n";

            _User = string.Format(_User, userID, password);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _User, "UserTable");
                _DTUser = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTUser = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTUser;
        }


        private string QueryUser(int index)
        {

            string _User = "";

            _User += "SET NOCOUNT ON\n\n";

            _User += "SELECT 'UserID'      = id\n";
            _User += "     , 'UseNick'     = nick\n";
            _User += "     , 'UserName'    = [name]\n";
            _User += "     , 'Password'    = [password]\n";
            _User += "     , 'Status'      = status\n";
            _User += "     , 'UserType'    = usertype\n";
            _User += "     , 'Enabled'     = enabled\n";
            _User += "     , 'CreatorDate' = creatordate\n";
            _User += "  FROM dbo.UserTable\n";

            switch (index)
            {
                case 0:
                    break;

                case 1:
                    _User += " WHERE id = '{0}'\n\n";
                    break;

                case 2:
                    _User += " WHERE nick = '{0}'\n\n";
                    break;

                default:
                    break;

            }

            _User += "SET NOCOUNT OFF\n\n";

            return _User;

        }

    }

}
