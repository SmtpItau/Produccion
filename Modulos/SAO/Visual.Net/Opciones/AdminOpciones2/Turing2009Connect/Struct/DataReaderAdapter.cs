using System; 
using System.Data; 
using System.Data.Common ; 

namespace Turing2009Connect.Struct 
{ 

    public class DataReaderAdapter : DbDataAdapter 
    { 
        public int FillFromReader(DataTable dataTable, IDataReader dataReader) 
        { 
            return this.Fill(dataTable, dataReader); 
        } 

    }

}