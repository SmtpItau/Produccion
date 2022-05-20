using System;
using System.Configuration;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Collections;

namespace cConnectionDB
{

    #region "ENUM"

    public enum enumConnectionMode
    {
        UniqueUserSystem = 0,
        UserSystem = 1,
        UserNT = 2
    }

    public enum enumExecuteMode
    {
        ConnectForever = 0,
        ConnectExecute = 1
    }

    public enum enumSQLStatus
    {
        // OK
        StatusSuccess = 0,

        // ESTADO
        StatusBase = 1000,
        StatusInitClass = 1001,
        StatusExitClass = 1002,
        StatusInitSQL = 1003,
        StatusExitSQL = 1004,
        StatusConnect = 1005,
        StatusDisConnect = 1006,
        StatusExecute = 1007,
        StatusFetch = 1008,

        // ERRRORES
        ErrorBase = -1000,
        ErrorInitClass = -1001,
        ErrorExitClass = -1002,
        ErrorInitSQL = -1003,
        ErrorExitSQL = -1004,
        ErrorConnect = -1005,
        ErrorDisConnect = -1006,
        ErrorExecute = -1007,
        ErrorFetch = -1008
    }

    #endregion

    public class SqlConnectionDB
    {

        #region "Definición de Variables"

        private SqlConnection mConnection;
        private DataSet mDataSet;

        private enumExecuteMode mExecuteMode;
        private enumConnectionMode mConnectionMode;
        private string mHostName;
        private string mApplication;
        private string mServerName;
        private string mDatabaseName;
        private string mUserName;
        private string mPassword;
        private int mLoginTimeOut;
        private int mQueryTimeOut;
        private enumSQLStatus mStatus;

        #endregion

        #region "Constructores"

        public SqlConnectionDB()
        {
            mConnection = new SqlConnection();
            mDataSet = new DataSet();

            SetValue("", "", enumConnectionMode.UniqueUserSystem, enumExecuteMode.ConnectExecute, "", "", "", "", 0, 0);

        }

        public SqlConnectionDB(string HostName, string Application, string ServerName, string DatabaseName, string UserName, string Password, int LoginTimeOut, int QueryTimeOut, enumExecuteMode ExecuteMode, enumConnectionMode ConnectionMode)
        {
            mConnection = new SqlConnection();
            mDataSet = new DataSet();

            SetValue(HostName, Application, ConnectionMode, ExecuteMode, ServerName, DatabaseName, UserName, Password, LoginTimeOut, QueryTimeOut);
        }

        public SqlConnectionDB(string NameServiceDataBase)
        {
            //string _NameConfig = ConfigurationManager.AppSettings[NameServiceDataBase];
            string _AppConfig = ConfigurationManager.AppSettings[NameServiceDataBase];
            string _HostName;
            string _Application;
            string _ServerName;
            string _DatabaseName;
            string _UserName;
            string _Password;
            int _LoginTimeOut;
            int _QueryTimeOut;
            enumExecuteMode _ExecuteMode;
            enumConnectionMode _ConnectionMode;

            mConnection = new SqlConnection();
            mDataSet = new DataSet();
            char[] _Separator = { ',' };

            string[] _Config = _AppConfig.Split(_Separator);

            _ExecuteMode = enumExecuteMode.ConnectExecute;
            _HostName = _Config[0].ToString();
            _Application = _Config[1].ToString();

            if (_Config[2].Equals("0"))
            {
                _ConnectionMode = enumConnectionMode.UniqueUserSystem;
            }
            else if (_Config[2].Equals("1"))
            {
                _ConnectionMode = enumConnectionMode.UserSystem;
            }
            else
            {
                _ConnectionMode = enumConnectionMode.UserNT;
            }

            if (_Config[3].Equals("0"))
            {
                _ExecuteMode = enumExecuteMode.ConnectForever;
            }
            else
            {
                _ExecuteMode = enumExecuteMode.ConnectExecute;
            }

            _ServerName = _Config[4].ToString();
            _DatabaseName = _Config[5].ToString();
            _UserName = _Config[6].ToString();
            _Password = _Config[7].ToString();
            _LoginTimeOut = int.Parse(_Config[8].ToString());
            _QueryTimeOut = int.Parse(_Config[9].ToString());

            SetValue(_HostName, _Application, _ConnectionMode, _ExecuteMode, _ServerName, _DatabaseName, _UserName, _Password, _LoginTimeOut, _QueryTimeOut);

            mStatus = enumSQLStatus.StatusBase;
        }

        #endregion

        #region "Propiedades"

        public enumExecuteMode ExecuteMode
        {
            get
            {
                return mExecuteMode;
            }
            set
            {
                mExecuteMode = value;
            }
        }

        public enumConnectionMode ConnectionMode
        {
            get
            {
                return mConnectionMode;
            }
            set
            {
                mConnectionMode = value;
            }
        }

        public string HostName
        {
            get
            {
                return mHostName;
            }
            set
            {
                mHostName = value;
            }
        }

        public string Application
        {
            get
            {
                return mApplication;
            }
            set
            {
                mApplication = value;
            }
        }

        public string ServerName
        {
            get
            {
                return mServerName;
            }
            set
            {
                mServerName = value;
            }
        }

        public string DatabaseName
        {
            get
            {
                return mDatabaseName;
            }
            set
            {
                mDatabaseName = value;
            }
        }

        public string UserName
        {
            get
            {
                return mUserName;
            }
            set
            {
                mUserName = value;
            }
        }

        public string Password
        {
            get
            {
                if (mPassword.Equals(""))
                {
                    return "";
                }
                else
                {
                    return AdminOpcionesEncript.Encript.DesEcrypt(mPassword);
                }
            }
            set
            {
                mPassword = value;
            }
        }

        public int LoginTimeOut
        {
            get
            {
                return mLoginTimeOut;
            }
            set
            {
                LoginTimeOut = value;
            }
        }

        public int QueryTimeOut
        {
            get
            {
                return mQueryTimeOut;
            }
            set
            {
                mQueryTimeOut = value;
            }
        }

        public enumSQLStatus Status
        {
            get
            {
                return mStatus;
            }
        }

        #endregion

        #region "Funciones publicas"

        public bool Connection()
        {

            string _ConnectionString = ConnectionString();
            mDataSet = new DataSet();

            // Conecci�n con la Base de Datos
            try
            {

                //SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

                //builder[""]


                mConnection = new SqlConnection(_ConnectionString);
                mConnection.Open();
                //mConnection.ConnectionTimeout = 600;
                mStatus = enumSQLStatus.StatusConnect;
            }
            catch
            {
                mStatus = enumSQLStatus.ErrorConnect;
            }

            return true;

        }

        public bool DedicatedExecution(string QueryString)
        {

            // Ejecución del Query
            if (!(mStatus.Equals(enumSQLStatus.ErrorConnect)) || !(mStatus.Equals(enumSQLStatus.ErrorDisConnect)))
            {
                // Ejecuta el Query en SQLServer
                try
                {

                    mStatus = enumSQLStatus.ErrorFetch;

                    SqlCommand _SqlCommand = new SqlCommand(QueryString, mConnection);
                    _SqlCommand.CommandType = CommandType.Text;
                    _SqlCommand.CommandTimeout = 600;

                    SqlDataAdapter _SqlDataAdapter = new SqlDataAdapter(_SqlCommand);
                    _SqlDataAdapter.Fill(mDataSet);

                    if (mDataSet.Tables.Count > 0)
                    {
                        mDataSet.Tables[0].TableName = "Query";
                    }

                    //mDataSet.Tables.Add(this.GetTable(_SqlDataReader));
                    //ds.Tables.Add(this.GetTable(_SqlDataReader));
                    //da.Fill(mDataSet, _SqlDataReader, "Query");
                    mStatus = enumSQLStatus.StatusFetch;

                }
                catch (Exception _Error)
                {
                    mStatus = enumSQLStatus.ErrorExecute;
                    string _ErrorMessage = _Error.Message;
                    if (QueryString.IndexOf("Log_Auditoria") < 0)
                    {
                        LogAuditoria(_Error.Message, QueryString);
                    }
                }

            }

            return true;

        }

        private void LogAuditoria(string message, string query)
        {
            string _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            _Query += "DECLARE @FechaProceso    DATETIME\n";
            _Query += "SELECT @FechaProceso = fechaproc FROM dbo.OpcionesGeneral\n";
            _Query += "INSERT INTO dbo.Log_Auditoria ( Entidad, FechaProceso, FechaSistema, HoraProceso, Terminal, Usuario, Id_Sistema, CodigoMenu, Codigo_Evento, DetalleTransac, Query )\n";
            _Query += string.Format(
                                     "       VALUES                 ( '1', @FechaProceso, CONVERT(VARCHAR(10), GETDATE(), 103 ), LEFT( CONVERT(VARCHAR(10), GETDATE(), 114 ), 8), '{0}', '{1}', 'OPT', '', '09', '', '{2}' )\n",
                                     this.ServerName,                       // 00
                                     this.UserName,                         // 01
                                     query.Replace("'", "\"")                                 // 02
                                   );
            try
            {
                _Connect.Execute(_Query);
            }
            catch
            {
            }

        }

        public bool Disconnection()
        {

            if (mStatus != enumSQLStatus.ErrorConnect)
            {
                try
                {
                    mConnection.Close();
                    mConnection = null;
                }
                catch
                {
                    mStatus = enumSQLStatus.ErrorDisConnect;
                }
            }

            return true;

        }

        public bool Execute(string QueryString)
        {

            Connection();

            DedicatedExecution(QueryString);

            Disconnection();

            return true;

        }

        public DataSet QueryDataSet()
        {
            //mRecordSet.Fields(1)
            return mDataSet;
        }

        public DataTable QueryDataTable()
        {
            return mDataSet.Tables["Query"];
        }

        public String DataString()
        {
            //mRecordSet.Fields(1)
            return mDataSet.Tables["Query"].ToString();
        }

        #endregion

        #region "Funciones Protegidas"

        protected string ConnectionString()
        {
            string _Connection = "";

            switch (ConnectionMode)
            {
                case enumConnectionMode.UniqueUserSystem:
                case enumConnectionMode.UserSystem:
                    //_Connection = _Connection + "Provider=SQLOLEDB;";
                    _Connection += "Data Source=" + ServerName + ";";
                    _Connection += "Database=" + DatabaseName + ";";
                    _Connection += "User Id=" + UserName + ";";
                    _Connection += "Password=" + Password + ";";
                    _Connection += "Connect Timeout=" + LoginTimeOut;
                    break;

                case enumConnectionMode.UserNT:
                    //_Connection = _Connection + "Provider=SQLOLEDB;";
                    _Connection += "Integrated Security=SSPI;";
                    _Connection += "Persist Security Info=False;";
                    _Connection += "Initial Catalog=" + DatabaseName + ";";
                    _Connection += "Data Source=" + ServerName + ";";
                    _Connection += "Connect Timeout=" + LoginTimeOut;
                    break;
            }

            return _Connection;
        }

        protected void SetValue(string HostName, string Application, enumConnectionMode ConnectionMode, enumExecuteMode ExecuteMode, string ServerName, string DatabaseName, string UserName, string Password, int LoginTimeOut, int QueryTimeOut)
        {
            mExecuteMode = ExecuteMode;
            mConnectionMode = ConnectionMode;
            mHostName = HostName;
            mApplication = Application;
            mServerName = ServerName;
            mDatabaseName = DatabaseName;
            mUserName = UserName;
            mPassword = Password;
            mLoginTimeOut = LoginTimeOut;
            mQueryTimeOut = QueryTimeOut;
            mStatus = enumSQLStatus.StatusBase;
        }

        #endregion

    }

}
