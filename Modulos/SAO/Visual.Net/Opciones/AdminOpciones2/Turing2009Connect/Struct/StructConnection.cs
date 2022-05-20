using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Connect.Struct
{

    public class StructConnection
    {

        #region "Constructor y Destructor"

        public StructConnection()
        {
            QueryType = enumQueryType.Init;
            _Set("", "", "", "", "", "", 0, 0, enumExecuteMode.ConnectExecute, enumConnectionMode.UniqueUserSystem);
        }

        public StructConnection(string hostName, string application, string serverName, string databaseName, string userName, string password, int loginTimeOut, int queryTimeOut, enumExecuteMode executeMode, enumConnectionMode connectionMode)
        {
            QueryType = enumQueryType.Init;
            _Set(hostName, application, serverName, databaseName, userName, password, loginTimeOut, queryTimeOut, executeMode, connectionMode);
        }

        public StructConnection(string serviceName)
        {
            QueryType = enumQueryType.Init;
            _Service(serviceName);
        }

        ~StructConnection()
        {
            Error = null;
        }

        #endregion

        #region "Atributos"

        private string mPassword { get; set; }
        public string HostName { get; set; }
        public string Application { get; set; }
        public string ServerName { get; set; }
        public string DatabaseName { get; set; }
        public string UserName { get; set; }

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

        public int LoginTimeOut { get; set; }
        public int QueryTimeOut { get; set; }
        public enumExecuteMode ExecuteMode { get; set; }
        public enumConnectionMode ConnectionMode { get; set; }
        public enumStatusSQL Status { get; set; }
        public StructError Error { get; set; }
        public enumQueryType QueryType { get; set; }

        public DataTable Table { get; set; }

        #endregion

        #region "Metodos"

        #region "Metodos Publicos"

        public virtual bool Open()
        { 
            return false;
        }

        public virtual bool Close()
        { 
            return false;
        }

        public bool Execute(string query)
        {

            bool _Status = false;

            if (!ServerName.Equals(""))
            {

                switch (Status)
                {
                    // OK
                    case enumStatusSQL.Success:
                    case enumStatusSQL.Connect:
                    case enumStatusSQL.Execute:
                        _ExecuteQuery(query);
                        _Status = true;
                        break;

                    // ESTADO
                    case enumStatusSQL.Init:
                    case enumStatusSQL.DisConnect:
                        Open();
                        _ExecuteQuery(query);
                        Close();
                        _Status = true;
                        break;

                    // ERRRORES
                    case enumStatusSQL.ErrorConnect:
                    case enumStatusSQL.ErrorDisConnect:
                    case enumStatusSQL.ErrorExecute:
                        _Status = false;
                        break;
                }

            }
            else
            {
                Error = new StructError("No se envio el nombre del servicio a ejecutar", "Query", "Turing2009Connect.Struct.StructConnection.Execute");
                Status = enumStatusSQL.ErrorExecute;
            }

            return _Status;

        }

        public bool Execute(string serviceName, string query)
        {
            bool _Status = false;

            try
            {
                _Service(serviceName);

                if (Open())
                {
                    if (_ExecuteQuery(query))
                    {
                        _Status = Close();
                    }
                }

            }
            catch
            {
                Error = new StructError("Error no definido", "Query Service", "Turing2009Connect.Struct.StructConnection.Execute");
                Status = enumStatusSQL.ErrorExecute;
                _Status = false;
            }

            return _Status;

        }

        public bool Execute(string serviceName, string query, string tableName)
        {
            bool _Status = false;

            try
            {
                //Log(serviceName, query, tableName);
                _Service(serviceName);

                if (Open())
                {
                    if (_ExecuteQuery(query))
                    {
                        Table.TableName = tableName;
                        _Status = Close();
                    }
                }

            }
            catch
            {
                Error = new StructError("Error no definido", "Query Service", "Turing2009Connect.Struct.StructConnection.Execute");
                Status = enumStatusSQL.ErrorExecute;
                _Status = false;
            }

            return _Status;

        }

        private void Log(string serviceName, string query, string tableName)
        {
            enumQueryType _QueryType = QueryType;
            string _Query = "";
            
            QueryType = enumQueryType.Insert;

            _Query += "SET NOCOUNT ON\n";
            _Query += string.Format(
                                     "INSERT INTO dbo.LogQuery ( tableName, query, creatordate ) VALUES ( '{0}', '{1}', GetDate() )\n",
                                     tableName,
                                     query.Replace("\n", "").Replace("'", "\"")
                                   );
            _Query += "SET NOCOUNT OFF\n";

            Execute("Turing", _Query);

            QueryType = _QueryType;
        }

        #endregion

        #region "Metodos privados"

        private bool _ExecuteQuery(string query)
        {
            bool _Status = false;

            switch (QueryType)
            {
                case enumQueryType.Init:
                    Error = new StructError("No se inicializo el parametro tipo de Query", "", "Turing2009Connect.Struct.StructConnection.ExecuteQuery");
                    Status = enumStatusSQL.Error;
                    break;
                case enumQueryType.Insert:
                    _Status = _Insert(query);
                    break;
                case enumQueryType.Delete:
                    _Status = _Delete(query);
                    break;
                case enumQueryType.Update:
                    _Status = _Update(query);
                    break;
                case enumQueryType.Customer:
                    _Status = _Customer(query);
                    break;
                case enumQueryType.Load:
                    _Status = _Load(query);
                    break;
                case enumQueryType.CustomerLoad:
                    _Status = _CustomerLoad(query);
                    break;
            }

            return _Status;

        }

        private void _Set(string hostName, string application, string serverName, string databaseName, string userName, string password, int loginTimeOut, int queryTimeOut, enumExecuteMode executeMode, enumConnectionMode connectionMode)
        {

            HostName = hostName;
            Application = application;
            ServerName = serverName;
            DatabaseName = databaseName;
            UserName = userName;
            Password = password;
            LoginTimeOut = loginTimeOut;
            QueryTimeOut = queryTimeOut;
            ExecuteMode = executeMode;
            ConnectionMode = connectionMode;
            Status = enumStatusSQL.Init;
            Error = new StructError();

        }

        private void _Service(string serviceName)
        {

            //string _ServiceConnect = ConfigurationManager.AppSettings[serviceName];
            string _ConfigConnect = ConfigurationManager.AppSettings[serviceName];

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

            char[] _Separator = { ',' };

            String[] _Config = _ConfigConnect.Split(_Separator);

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

            _Set(_HostName, _Application, _ServerName, _DatabaseName, _UserName, _Password, _LoginTimeOut, _QueryTimeOut, _ExecuteMode, _ConnectionMode);

        }

        private bool _Load(string query)
        {
            // Grabar Log de Consulta
            return Load(query);
        }

        private bool _Insert(string query)
        {
            return  Insert(query);
        }

        private bool _Delete(string query)
        {
            return Delete(query);
        }

        private bool _Update(string query)
        {
            return Update(query);
        }

        private bool _Customer(string query)
        {
            return Customer(query);
        }

        private bool _CustomerLoad(string query)
        {
            return CustomerLoad(query);
        }

        #endregion

        #region "Metodos SobreEscribible"

        protected virtual bool Load(string query)
        {
            return false;
        }

        protected virtual bool Insert(string query)
        {
            return false;
        }

        protected virtual bool Delete(string query)
        {
            return false;
        }

        protected virtual bool Update(string query)
        {
            return false;
        }

        protected virtual bool Customer(string query)
        {
            return false;
        }

        protected virtual bool CustomerLoad(string query)
        {
            return false;
        }

        #endregion

        #endregion

    }
}
