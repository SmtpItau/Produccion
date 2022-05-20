using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;
using Turing2009Connect.Struct;
using System.Xml;
using System.Data;
using System.Data.Common;

namespace Turing2009Connect.SQL
{

    public class ConnectSQL : StructConnection
    {

        #region "Atributos Privados"

        private const int ConstCommandTimeout = 600;
        private SqlConnection mSqlConnection;

        #endregion

        #region "Constructor y Destructor"

        public ConnectSQL() : base() { }
        public ConnectSQL(string hostName, string application, string serverName, string databaseName, string userName, string password, int loginTimeOut, int queryTimeOut, enumExecuteMode executeMode, enumConnectionMode connectionMode):base(hostName, application, serverName, databaseName, userName, password, loginTimeOut, queryTimeOut, executeMode, connectionMode) { }
        public ConnectSQL(string serviceName): base(serviceName) { }

        ~ConnectSQL()
        {

            switch(base.Status)
            {
                case enumStatusSQL.Success:       // 0,
                case enumStatusSQL.Connect:       // 1005,
                case enumStatusSQL.Execute:       // 1007,
                case enumStatusSQL.ErrorExecute:        //-1007,
                    mSqlConnection.Close();
                    break;

                case enumStatusSQL.Init:
                case enumStatusSQL.DisConnect:          // 1000,
                case enumStatusSQL.ErrorConnect:        //-1005,
                case enumStatusSQL.ErrorDisConnect:         //-1006,
                    break;
            }

            mSqlConnection = null;

        }

        #endregion

        #region "Metodos Publicos"

        public override bool Open()
        {

            try
            {
                mSqlConnection = new SqlConnection(ConnectionString());
                mSqlConnection.Open();
                base.Status = enumStatusSQL.Connect;
                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorConnect;
                return false;
            }

        }

        public override bool Close()
        {

            try
            {
                mSqlConnection.Close();
                mSqlConnection = null;
                base.Status = enumStatusSQL.DisConnect;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorDisConnect;
            }

            return base.Close();
        }

        public string ConnectionString()
        {
            string _Connection;

            _Connection = "";

            switch (ConnectionMode)
            {
                case enumConnectionMode.UniqueUserSystem:
                case enumConnectionMode.UserSystem:
                    //_Connection = _Connection + "Provider=SQLOLEDB;";
                    _Connection += "Data Source=" + base.ServerName + ";";
                    _Connection += "Database=" + base.DatabaseName + ";";
                    _Connection += "User Id=" + base.UserName + ";";
                    _Connection += "Password=" + base.Password + ";";
                    _Connection += "Connect Timeout=" + base.LoginTimeOut;
                    break;

                case enumConnectionMode.UserNT:
                    //_Connection = _Connection + "Provider=SQLOLEDB;";
                    _Connection += "Integrated Security=SSPI;";
                    _Connection += "Persist Security Info=False;";
                    _Connection += "Initial Catalog=" + base.DatabaseName + ";";
                    _Connection += "Data Source=" + base.ServerName + ";";
                    _Connection += "Connect Timeout=" + base.LoginTimeOut;
                    break;
            }

            return _Connection;

        }

        #endregion

        #region "Metodos Protegidos"

        protected override bool Load(string query)
        {

            try
            {
                SqlCommand _Command = new SqlCommand(query, mSqlConnection);
                _Command.CommandTimeout = ConstCommandTimeout;
                SqlDataReader _Reader = _Command.ExecuteReader(CommandBehavior.CloseConnection);
                Table = new DataTable();
                DataReaderAdapter _DRA = new DataReaderAdapter();

                _DRA.FillFromReader(Table, _Reader); 

                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorExecute;
                return false;
            }

        }

        protected override bool Insert(string query)
        {

            try
            {
                SqlCommand _Command = new SqlCommand(query, mSqlConnection);
                _Command.CommandTimeout = ConstCommandTimeout;
                _Command.ExecuteNonQuery();

                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorExecute;
                return false;
            }

        }

        protected override bool  Delete(string query)
        {

            try
            {
                SqlCommand _Command = new SqlCommand(query, mSqlConnection);
                _Command.CommandTimeout = ConstCommandTimeout;
                _Command.ExecuteNonQuery();

                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorExecute;
                return false;
            }
        
        }

        protected override bool Update(string query)
        {

            try
            {
                SqlCommand _Command = new SqlCommand(query, mSqlConnection);
                _Command.CommandTimeout = ConstCommandTimeout;
                _Command.ExecuteNonQuery();

                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorExecute;
                return false;
            }

        }

        protected override bool Customer(string query)
        {

            try
            {
                SqlCommand _Command = new SqlCommand(query, mSqlConnection);
                _Command.CommandTimeout = ConstCommandTimeout;
                _Command.ExecuteNonQuery();

                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorExecute;
                return false;
            }

        }

        protected override bool CustomerLoad(string query)
        {

            try
            {
                SqlCommand _Command = new SqlCommand(query, mSqlConnection);
                _Command.CommandTimeout = ConstCommandTimeout;
                SqlDataReader _Reader = _Command.ExecuteReader(CommandBehavior.CloseConnection);
                Table = new DataTable();
                DataReaderAdapter _DRA = new DataReaderAdapter();

                _DRA.FillFromReader(Table, _Reader);

                return true;
            }
            catch (Exception _Error)
            {
                Error = new StructError(_Error);
                Status = enumStatusSQL.ErrorExecute;
                return false;
            }

        }

        #endregion

    }

}
