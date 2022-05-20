using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect.SQL;
using Turing2009Definitions.Definitions;

namespace Turing2009Connect
{

    public class Connect : ConnectSQL
    {

        public Connect() : base() { }
        public Connect(string hostName, string application, string serverName, string databaseName, string userName, string password, int loginTimeOut, int queryTimeOut, enumExecuteMode executeMode, enumConnectionMode connectionMode) : base(hostName, application, serverName, databaseName, userName, password, loginTimeOut, queryTimeOut, executeMode, connectionMode) { }
        public Connect(string serviceName) : base(serviceName) { }

    }

}
