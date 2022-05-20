#pragma warning disable 1591
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebServiceFMD.Common;

namespace WebServiceFMD.Common
{
    
    namespace DAO
    {
        using WebServiceFMD.Common.DTO;
        using WebServiceFMD.Common.Collection;
        using CoreLib.Common;
        using CoreLib.Helpers;
        /// <summary>
        /// Data Access Object para ReportType
        /// </summary>
        public static class ReportTypeDao
        {
            private const string SQLCMD_SELECT = @"select * from (
                                        select id_reporte,desc_reporte,error_code
                                        from TBL_REPORTES_FUSION  with(nolock) where id_reporte =  150
                                        union
                                        Select 9999 as id_reporte,'MANTENCION-LOG' as desc_reporte,0 as error_code 
                                        union
                                        Select 9999 as id_reporte,'MANTENCION' as desc_reporte,0 as error_code
                                        ) as t1";

            /// <summary>
            /// Busca ReportType por Descripcion
            /// </summary>
            /// <param name="ctx">Contexto de aplicacion</param>
            /// <param name="reportDescription">Descripcion a buscar</param>
            /// <returns>ReportType object</returns>
            public static ReportType FindByDescription(DBContext ctx, string reportDescription) {

                if (string.IsNullOrEmpty(reportDescription)) {
                    throw new ArgumentNullException("Debe ingresar la descripcion para buscar", "reportDescription");
                }

                string sqlcmd = SQLCMD_SELECT + " where desc_reporte='{0}'";
                sqlcmd = string.Format(sqlcmd, reportDescription);

                try
                {
                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, CommandType.Text, sqlcmd);

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow row = ds.Tables[0].Rows[0];
                        return new ReportType(row);
                    }
                    else {

                        return null;
                    }
                }
                catch (Exception)
                {                    
                    throw;
                }
            }

            
            /// <summary>
            /// Retorna objeto ReportType por su id
            /// </summary>
            /// <param name="ctx">Contexto de aplicacion</param>
            /// <param name="id">Identificador por cual se busca</param>
            /// <returns>ReportType object</returns>
            public static ReportType FindByID(DBContext ctx, int id)
            {
                if (id == 0) {
                    return new ReportType();
                }
                
                
                string sqlcmd = SQLCMD_SELECT + " where id={0}";
                sqlcmd = string.Format(sqlcmd, id);

                try
                {
                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, CommandType.Text, sqlcmd);

                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow row = ds.Tables[0].Rows[0];
                        return new ReportType(row);
                    }
                    else
                    {

                        return null;
                    }
                }
                catch (Exception)
                {
                    throw;
                }
            }

            /// <summary>
            /// Retorna una colletion de ReportType
            /// </summary>
            /// <param name="ctx">Contexto de Aplicacion</param>
            /// <returns></returns>
            public static ReportTypeCollection<ReportType> GetReportTypeCollection(DBContext ctx)
            {
                try
                {
                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, CommandType.Text, SQLCMD_SELECT);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        ReportTypeCollection<ReportType> result = new ReportTypeCollection<ReportType>();
                        foreach (DataRow row in ds.Tables[0].Rows) {
                            result.Add(new ReportType(row));
                        }
                        return result;
                    }
                    else {
                        return new ReportTypeCollection<ReportType>();
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

        public class ReportType : IDisposable
        {
            protected Guid? _UniqueID;
            /// <summary>
            /// Unique GUID de instancia 
            /// </summary>
            public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }

            /// <summary>
            /// Default constructor
            /// </summary>
            public ReportType() { }

            /// <summary>
            /// Constructor con parametros DataRow (Transforma un DataRow en objeto ReportType) 
            /// </summary>
            /// <param name="row">DataRow</param>
            public ReportType(DataRow row)
            {
                if (row != null) {
                    this._UniqueID = new Guid();
                    this.desc_reporte = row.Field<string>("desc_reporte");
                    this.id_reporte = row.Field<int>("id_reporte");
                    this.error_coding = row.Field<int>("error_code");
                }                
            }
            /// <summary>
            /// Id de reporte
            /// </summary>
            public int id_reporte { get; set; }
            /// <summary>
            /// Descripcion de reporte
            /// </summary>
            public string desc_reporte { get; set; }


            /// <summary>
            /// Codificación de Errores /Log
            /// </summary>
            public int error_coding { get; set; }

            #region Implementacion IDisposable

            /// <summary>
            /// Default destructor
            /// </summary>
            ~ReportType()
            {
                Dispose(true);
                GC.SuppressFinalize(this);
            }

            private bool disposed = false;
            /// <summary>
            /// Implementacion de Dispose
            /// </summary>
            /// <param name="disposing">indica si esta haciendo GC</param>
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
            /// Implementacion IDisposable.Dispose
            /// </summary>
            void IDisposable.Dispose()
            {
                Dispose(true);
                GC.SuppressFinalize(this);
            }
        }

            #endregion
    }
    
    namespace Collection
    {
        using DTO;
        /// <summary>
        /// Enumerador de ReportType
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class ReportTypeEnumerator<T>
            : IEnumerator<T> where T : DTO.ReportType
        {
            protected ReportTypeCollection<T> _collection; //coleccion enumerada
            protected int index; //current index
            protected T _current; // current enumerated object in the collection
            public ReportTypeEnumerator() { }
            public ReportTypeEnumerator(ReportTypeCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
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
        public class ReportTypeCollection<T>
            : ICollection<T> where T : DTO.ReportType
        {
            protected ArrayList _innerArray;
            protected bool _IsReadOnly;
            public ReportTypeCollection() { this._innerArray = new ArrayList(); }
            //public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
            public virtual T this[int report_id] {
                get {
                    foreach (T obj in _innerArray) {
                        if (obj.id_reporte == report_id) {
                            return obj;
                        }
                    }
                    return null;
                }                
            }
            public virtual T this[string ReportTypeName] {
                get {
                    foreach (T obj in _innerArray) {
                        if (obj.desc_reporte == ReportTypeName) {
                            return obj;
                        }
                    }
                    return null;
                }
            }

            public virtual int Count { get { return _innerArray.Count; } }
            public virtual bool IsReadOnly { get { return _IsReadOnly; } }
            public virtual bool Remove(T ReportType)
            {
                bool result = false;
                for (int i = 0; i < _innerArray.Count; i++)
                {
                    T obj = (T)_innerArray[i];
                    if (obj.UniqueID == ReportType.UniqueID)
                    {
                        _innerArray.RemoveAt(i);
                        result = true;
                        break;
                    }
                }
                return result;
            }
            public virtual bool Contains(T ReportType)
            {
                foreach (T obj in _innerArray)
                {
                    if (obj.UniqueID == ReportType.UniqueID) { return true; }
                }
                return false;
            }

            public virtual bool Contains(string description, StringComparison compareOptions)
            {
                foreach (T obj in _innerArray)
                {
                    int result = String.Compare(obj.desc_reporte, description, compareOptions);
                    if (result == 0)
                    {
                        return true;
                    }

                }
                return false;
            }


            public virtual void Add(T ReportType) { _innerArray.Add(ReportType); }
            public virtual void Clear() { _innerArray.Clear(); }
            public virtual void CopyTo(T[] ReportTypeArray, int index)
            {
                throw new Exception("Metodo no valido para esta implementacion");
            }
            public virtual IEnumerator<T> GetEnumerator()
            {
                return new ReportTypeEnumerator<T>(this);
            }
            IEnumerator IEnumerable.GetEnumerator()
            {
                return new ReportTypeEnumerator<T>(this);
            }
        }



    }

}