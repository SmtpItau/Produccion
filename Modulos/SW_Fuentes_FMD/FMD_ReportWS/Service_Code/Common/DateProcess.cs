using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WindowsServiceFMD.Common
{
    namespace DAO
    {
        using WindowsServiceFMD.Common.DTO;
        using WindowsServiceFMD.Common.Collections;
        using CoreLib.Common;
        using CoreLib.Helpers;
        using System.Data.SqlClient;
        using System.Data;

        /// <summary>
        /// Data Access Object para obtencion de fechas de proceso
        /// </summary>
        public class DateProcessDao
        {
            private const string SQLCMD_SELECT = @"SP_FECHAPROC_RCM";            

            /// <summary>
            /// Retorna la una coleccion con las fechas de proceso de los modulo indicados
            /// </summary>
            /// <param name="ctx">Contexto de Base de Datos</param>
            /// <param name="modulo">Modulo a buscar</param>
            /// <returns>Collection de DateProcessCollection</returns>
            public static DateProcessCollection<DateProcess> GetDateProcessCollectionByModulo(DBContext ctx, string modulo)
            {
                try
                {
                    if (string.IsNullOrWhiteSpace(modulo) || string.IsNullOrEmpty(modulo))
                    {
                        return new DateProcessCollection<DateProcess>();
                    }
                                       
                    SqlParameter[] parameters = 
                    {
                    new SqlParameter() { DbType = DbType.AnsiString, Direction = ParameterDirection.Input, ParameterName = "modulo", Value = modulo }
                    ,new SqlParameter() { DbType = DbType.AnsiString, Direction = ParameterDirection.Input, ParameterName = "opcion", Value = modulo}
                    ,new SqlParameter() { DbType = DbType.AnsiString, Direction = ParameterDirection.Output, ParameterName = "fecha" }                                                
                    };

                    //DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, CommandType., SQLCMD_SELECT,parameters);
                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, SQLCMD_SELECT, parameters);
                    
                    
                    
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DateProcessCollection<DateProcess> result = new DateProcessCollection<DateProcess>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            result.Add(new DateProcess(row));
                        }
                        return result;
                    }
                    else
                    {
                        return new DateProcessCollection<DateProcess>();
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
            /// <summary>
            /// Retorna una colecction de DateProcess, con todas las fechas de proceso de todos los modulos.
            /// </summary>
            /// <param name="ctx"></param>
            /// <returns></returns>
            public static DateProcessCollection<DateProcess> GetDateProcessCollection(DBContext ctx)
            {
                try
                {                    
                    SqlParameter[] parameters = 
                    {
                    new SqlParameter() { DbType = DbType.AnsiString, Direction = ParameterDirection.Input, ParameterName = "modulo", Value = "BFW" }
                    ,new SqlParameter() { DbType = DbType.AnsiString, Direction = ParameterDirection.Input, ParameterName = "opcion", Value = "ALL" }
                    ,new SqlParameter() { DbType = DbType.AnsiString, Direction = ParameterDirection.Output, ParameterName = "fecha" }                                                
                    };

                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, SQLCMD_SELECT, parameters);

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DateProcessCollection<DateProcess> result = new DateProcessCollection<DateProcess>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            result.Add(new DateProcess(row));
                        }
                        return result;
                    }
                    else
                    {
                        return new DateProcessCollection<DateProcess>();
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }
    }

    namespace DTO
    {
        using System.Data;

        public class DateProcess : IDisposable
        {

            protected Guid? _UniqueID;

            /// <summary>
            /// Guid Unico de instancia
            /// </summary>
            public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }

            /// <summary>
            /// Default constructor
            /// </summary>
            public DateProcess() {
                this._UniqueID = Guid.NewGuid();
            }

            /// <summary>
            /// Constructor con parametros DataRow (Transforma un DataRow en objeto DateProcess) 
            /// </summary>
            /// <param name="row">DataRow</param>
            public DateProcess(DataRow row)
            {
                if (row != null)
                {
                    this._UniqueID = Guid.NewGuid();
                    this.modulo = row.Field<string>("modulo");                    
                    this.FechaAnterior = row.Field<DateTime>("fecha_anterior");
                    this.FechaProceso = row.Field<DateTime>("fecha_proceso");
                    this.FechaProxima = row.Field<DateTime>("fecha_proxima");
                }
            }

            public string modulo { get; set; }
            public DateTime FechaAnterior { get; set; }
            public DateTime FechaProceso { get; set; }
            public DateTime FechaProxima { get; set; }


            #region Implementacion IDisposable
            /// <summary>
            /// Default destructor.
            /// </summary>
            ~DateProcess()
            {
                Dispose(true);
                GC.SuppressFinalize(this);
            }

            private bool disposed = false;
            /// <summary>
            /// Dispose de objeto
            /// </summary>
            protected virtual void Dispose(bool disposing)
            {
                if (!disposed)
                {
                    if (disposing)
                    {
                        //liberacion de recursos tomados
                    }
                    disposed = true;
                }
            }

            /// <summary>
            /// Dispose de objeto
            /// </summary>
            void IDisposable.Dispose()
            {
                Dispose(true);
                GC.SuppressFinalize(this);
            }
            #endregion

        }
    }

    namespace Collections
    {
        using DTO;
        /// <summary>
        /// Enumerador de ReportType
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class DateProcessEnumerator<T>
            : IEnumerator<T> where T : DTO.DateProcess
        {
            protected DateProcessCollection<T> _collection; //coleccion enumerada
            protected int index; //current index
            protected T _current; // current enumerated object in the collection
            public DateProcessEnumerator() { }
            public DateProcessEnumerator(DateProcessCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
            public virtual T Current { get { return _current; } }
            object IEnumerator.Current { get { return _current; } }
            public virtual void Dispose() { _collection = null; _current = default(T); index = -1; }
            public virtual bool MoveNext() { if (++index >= _collection.Count) { return false; } else { _current = _collection[index]; } return true; }
            public virtual void Reset() { _current = default(T); index = -1; }
        }

        /// <summary>
        /// Coleccion de Objetos TemplateAddress
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class DateProcessCollection<T>
            : ICollection<T> where T : DTO.DateProcess
        {
            protected ArrayList _innerArray;
            protected bool _IsReadOnly;
            public DateProcessCollection() { this._innerArray = new ArrayList(); }
            public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
            public virtual T this[string modulo]
            {
                get
                {
                    foreach (T obj in _innerArray)
                    {
                        if (obj.modulo ==  modulo)
                        {
                            return obj;
                        }
                    }
                    return null;
                }
            }
            public virtual T this[DateTime FechaProceso] {
                get {
                    DateTime aux;
                    DateTime.TryParse(FechaProceso.ToString("yyyy-MM-dd"), out aux);
                    foreach (T obj in _innerArray) { 
                        if(obj.FechaProceso == aux){
                            return obj;
                        }
                    }
                    return null;
                }            
            }



            public virtual int Count { get { return _innerArray.Count; } }
            public virtual bool IsReadOnly { get { return _IsReadOnly; } }
            public virtual bool Remove(T Module)
            {
                bool result = false;
                for (int i = 0; i < _innerArray.Count; i++)
                {
                    T obj = (T)_innerArray[i];
                    if (obj.UniqueID == Module.UniqueID)
                    {
                        _innerArray.RemoveAt(i);
                        result = true;
                        break;
                    }
                }
                return result;
            }
            public virtual bool Contains(T DateProcess)
            {
                foreach (T obj in _innerArray)
                {
                    if (obj.UniqueID == DateProcess.UniqueID) { return true; }
                }
                return false;
            }
            public virtual bool Contains(string description, StringComparison compareOptions)
            {
                foreach (T obj in _innerArray)
                {
                    int result = String.Compare(obj.modulo, description, compareOptions);
                    if (result == 0)
                    {
                        return true;
                    }

                }
                return false;
            }
            public virtual void Add(T DateProcess) { _innerArray.Add(DateProcess); }
            public virtual void Clear() { _innerArray.Clear(); }
            public virtual void CopyTo(T[] DateProcess, int index)
            {
                throw new Exception("Metodo no valido para esta implementacion");
            }
            public virtual IEnumerator<T> GetEnumerator()
            {
                return new DateProcessEnumerator<T>(this);
            }
            IEnumerator IEnumerable.GetEnumerator()
            {
                return new DateProcessEnumerator<T>(this);
            }
        
        
        }


    }

}