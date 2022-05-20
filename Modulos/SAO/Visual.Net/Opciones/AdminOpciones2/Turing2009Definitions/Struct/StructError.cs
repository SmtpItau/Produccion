using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace Turing2009Definitions.Struct
{

    public class StructError
    {

        public StructError()
        {

            Message = "";
            Source = "";
            StackTrace = "";
        }

        public StructError(Exception error)
        {

            Message = error.Message;
            Source = "Exception";
            StackTrace = error.StackTrace;

        }

        public StructError(string message, string source, string stackTrace)
        {
            Message = message;
            Source = source;
            StackTrace = stackTrace;
        }

        public string Message { get; set; }
        public string Source { get; set; }
        public string StackTrace { get; set; }

    }

}
