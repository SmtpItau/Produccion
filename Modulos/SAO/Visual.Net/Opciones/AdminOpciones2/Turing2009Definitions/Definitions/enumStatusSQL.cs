namespace Turing2009Definitions.Definitions
{

    public enum enumStatusSQL
    {

        // OK
        Success = 0,

        // ESTADO
        Init = 1000,
        Connect = 1001,
        DisConnect = 1002,
        Execute = 1003,

        // ERRRORES
        Error = -1000,
        ErrorConnect = -1001,
        ErrorDisConnect = -1002,
        ErrorExecute = -1003,
    }

}
