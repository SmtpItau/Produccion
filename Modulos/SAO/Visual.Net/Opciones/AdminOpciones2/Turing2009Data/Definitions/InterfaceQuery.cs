using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Definitions
{

    public class InterfaceQuery
    {

        #region "Constructor y destructor"

        public InterfaceQuery()
        {

            Status = enumStatus.Initialize;
            Error = new StructError();

        }

        ~InterfaceQuery()
        {

            Error = null;

        }

        #endregion

        #region "Atributos Publicos"

        public enumStatus Status { get; set; }
        public StructError Error { get; set; }

        #endregion

        #region "Metodos"

        public string Message(enumStatus status, int code)
        {
            string _Message;

            switch (Status)
            {
                case enumStatus.ErrorSystem:
                    _Message = "";
                    break;
                case enumStatus.ErrorExecute:
                    _Message = "";
                    break;
                case enumStatus.ErrorExecuting:
                    _Message = "";
                    break;
                case enumStatus.Execute:
                    _Message = "";
                    break;
                case enumStatus.Executing:
                    _Message = "";
                    break;
                case enumStatus.Initialize:
                    _Message = "";
                    break;
                default:
                    _Message = "";
                    break;
            }

            return _Message;

        }

        #endregion

    }

}
