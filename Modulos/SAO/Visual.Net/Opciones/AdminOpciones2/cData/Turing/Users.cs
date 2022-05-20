using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.Turing
{

    public class Users
    {

        #region "Atributos privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public Users()
        {
            Set(enumSource.System);
        }

        public Users(enumSource _ID)
        {
            Set(_ID);
        }

        #endregion

        #region "Atributos publicos"

        public enumStatus Status
        {
            get
            {
                return mStatus;
            }
        }

        public String Message
        {
            get
            {
                return ReadMessage(mStatus);
            }
        }

        public String Error
        {
            get
            {
                return mError;
            }
        }

        public String Stack
        {
            get
            {
                return mStack;
            }
        }
        
        #endregion

        #region "Metodos publicos"

        public String ReadMessage(enumStatus status)
        {
            String _Message;

            switch (status)
            {
                case enumStatus.Already:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "";
                    break;
                case enumStatus.Initialize:
                    _Message = "";
                    break;
                case enumStatus.Loaded:
                    _Message = "";
                    break;
                case enumStatus.Loading:
                    _Message = "";
                    break;
                case enumStatus.NotFound:
                    _Message = "";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "";
                    break;
                default:
                    _Message = "";
                    break;
            }
            return _Message;
        }

        public DataTable LoadUser(string userNick)
        {

            DataTable _UsersData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _UsersData = _System.LoadUser(userNick);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _UsersData = _Bloomberg.LoadUser(userNick);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _UsersData = _Excel.LoadUser(userNick);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _UsersData = _XML.LoadUser(userNick);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _UsersData;

        }

        public DataTable LoadPrivilege(string userNick)
        {

            DataTable _UsersData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _UsersData = _System.LoadPrivilege(userNick);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _UsersData = _Bloomberg.LoadPrivilege(userNick);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _UsersData = _Excel.LoadPrivilege(userNick);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _UsersData = _XML.LoadPrivilege(userNick);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _UsersData;

        }

        #endregion

        #region "Metodos privados"

        protected void Set(enumSource id)
        {
            mStatus = enumStatus.Initialize;
            mSource = id;
        }

        #endregion

        #region "Clases para obtener la información"

        #region "Clase Source"

        private class Source
        {

            private enumStatus mStatus;
            private String mError;
            private String mStack;

            public enumStatus Status
            {
                get
                {
                    return mStatus;
                }
                set
                {
                    mStatus = value;
                }
            }

            public String Error
            {
                get
                {
                    return mError;
                }
                set
                {
                    mError = value;
                }
            }

            public String Stack
            {
                get
                {
                    return mStack;
                }
                set
                {
                    mStack = value;
                }
            }

            public Source()
            {
                mStatus = enumStatus.Initialize;
                mError = "";
                mStack = "";
            }

            public virtual DataTable LoadUser(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

            public virtual DataTable LoadPrivilege(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataTable LoadUser(string userNick)
            {

                String _QueryRate = "SELECT id, nick, [name], [password], status, usertype, creatordate FROM UserTable WHERE nick = '" + userNick + "'";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");
                DataTable _UsersData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _UsersData = _Connect.QueryDataTable();
                    _UsersData.TableName = "UsersList";

                    if (_UsersData.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _UsersData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _UsersData;
            }

            public override DataTable LoadPrivilege(string userNick)
            {

                String _QueryRate = "SELECT 'PrivilegeID' = P.id " +
                                    "     , 'UserID'      = P.userID " +
                                    "     , 'MenuID'      = P.menuID " +
                                    "     , 'Menu'        = M.menu " +
                                    "     , 'Description' = M.[description] " +
                                    "     , 'Order'       = M.[order] " +
                                    "     , 'MenuCode'    = M.menuID " +
                                    "     , 'MenuFather'  = M.menufather " +
                                    "     , 'LinkURL'     = linkurl " +
                                    "     , 'Status'      = P.status " +
                                    "     , 'CreatorDate' = P.creatordate " +
                                    "  FROM PrivilegeTable P, " +
                                    "       MenuTable      M, " +
                                    "       UserTable      U " +
                                    " WHERE P.menuid = M.id " +
                                    "   AND P.userid = U.id " +
                                    "   AND U.nick   = '" + userNick + "'" +
                                    " ORDER BY M.[order]";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");
                DataTable _UsersData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _UsersData = _Connect.QueryDataTable();
                    _UsersData.TableName = "PrivilegeList";

                    if (_UsersData.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _UsersData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _UsersData;
            }

        }

        #endregion

        #region "Datos que se obtinen del Bloomberg"

        private class SourceBloomberg : Source
        {

            public override DataTable LoadUser(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

            public override DataTable LoadPrivilege(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

        }

        #endregion

        #region "Datos que se obtinen de Excel"

        private class SourceExcel : Source
        {

            public override DataTable LoadUser(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

            public override DataTable LoadPrivilege(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

        }

        #endregion

        #region "Datos que se obtinen de XML"

        private class SourceXML : Source
        {

            public override DataTable LoadUser(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

            public override DataTable LoadPrivilege(string userNick)
            {
                DataTable _UsersData = new DataTable();

                return _UsersData;
            }

        }

        #endregion

        #endregion

    }

}
