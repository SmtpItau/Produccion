#pragma warning disable 1591
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebServiceFMD.Common;
using CoreBusinessObjects.Common;

namespace WebServiceFMD.Common
{

    namespace DAO
    {
        using WebServiceFMD.Common.DTO;
        using WebServiceFMD.Common.Collection;
        using CoreLib.Common;
        using CoreLib.Helpers;

        /// <summary>
        /// Data Access Object para ModuleType
        /// </summary>
        public static class ModuleTypeDao
        {
            private const string SQLCMD_SELECT = @"SP_MODULOS_RCM";
            private const string SQLCMD_PARAM1 = @"@id_reporte={0}";
            private const string SQLCMD_PARAM2 = @"@modulo={0}";


            /// <summary>
            /// Retorna coleccion de modulos por id de reporte
            /// </summary>
            /// <param name="ctx">Contexto de BD</param>
            /// <param name="id_reporte">Id de reporte para buscar los modulos</param>
            /// <returns>ModuleCollection</returns>
            public static ModuleTypeCollection<ModuleType> GetModuleTypeCollectionByIdReport(DBContext ctx, int id_reporte) {
                try
                {
                    if (id_reporte == 0) {
                        return new ModuleTypeCollection<ModuleType>();                    
                    }

                    string sqlcmd = SQLCMD_SELECT + SQLCMD_PARAM1;
                    sqlcmd = string.Format(sqlcmd, id_reporte);

                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, CommandType.Text,sqlcmd);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        ModuleTypeCollection<ModuleType> result = new ModuleTypeCollection<ModuleType>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            result.Add(new ModuleType(row));
                        }
                        return result;
                    }
                    else
                    {
                        return new ModuleTypeCollection<ModuleType>();
                    }
                }
                catch (Exception)
                {
                    
                    throw;
                }            
            }




            /// <summary>
            /// Retorna coleccion de modulos (TODOS)
            /// </summary>
            /// <param name="ctx">Contexto de aplicacion</param>
            /// <returns>ModuleTypeCollection</returns>
            public static ModuleTypeCollection<ModuleType> GetModuleTypeCollection(DBContext ctx) {
                try
                {
                    DataSet ds = SqlHelper.ExecuteDataset(ctx.StringConnection, CommandType.Text, SQLCMD_SELECT);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        ModuleTypeCollection<ModuleType> result = new ModuleTypeCollection<ModuleType>();
                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            result.Add(new ModuleType(row));
                        }
                        return result;
                    }
                    else {
                        return new ModuleTypeCollection<ModuleType>();
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
        /// <summary>
        /// Clase dto de modulo
        /// </summary>
        public class ModuleType : IDisposable
        {
            protected Guid? _UniqueID;

            /// <summary>
            /// Guid Unico de instancia
            /// </summary>
            public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }

            /// <summary>
            /// Default constructor
            /// </summary>
            public ModuleType() { }

            /// <summary>
            /// Constructor con parametros DataRow (Transforma un DataRow en objeto ModuleType) 
            /// </summary>
            /// <param name="row">DataRow</param>
            public ModuleType(DataRow row) {
                if (row != null) {
                    this._UniqueID      = Guid.NewGuid();
                    this.id_modulo      = row.Field<int>("id_modulo");
                    this.id_reporte     = row.Field<int>("id_reporte");
                    this.modulo         = row.Field<string>("modulo");
                    this.modulo_h       = row.Field<string>("modulo_h");
                    this.desc_modulo    = row.Field<string>("desc_modulo");
                    this.engine = (Engine)Enum.Parse(typeof(Engine), row.Field<string>("export_engine"));
                    this.processType    = (ProcessType)row.Field<int>("process");

                    this.require = (CheckProcess)Enum.Parse(typeof(CheckProcess),row.Field<string>("require"));

                    TimeSpan aux_start_time, aux_finish_time;
                    if (TimeSpan.TryParse(row.Field<string>("starting"), out aux_start_time)) {
                        this.starting = aux_start_time;
                    }

                    if (TimeSpan.TryParse(row.Field<string>("finish"), out aux_finish_time))
                    {
                        this.finish = aux_finish_time;
                    }
                    this.priority = row.Field<int>("priority");
                    this.active = row.Field<bool>("active");
                    this.special_mode = row.Field<bool>("special_mode");
                    this.db_context = CoreLib.Helpers.JSONHelper.Deserialize<CoreLib.Common.DBContext>(row.Field<string>("db_connection"));

                }            
            }

            /// <summary>
            /// Id de modulo
            /// </summary>
            public int id_modulo { get; set; }

            /// <summary>
            /// Id de reporte
            /// </summary>
            public int id_reporte { get; set; }

            /// <summary>
            /// nombre de modulo (AS400)
            /// </summary>
            public string modulo { get; set; }

            /// <summary>
            /// nombre de modulo homologado (FINDUR)
            /// </summary>
            public string modulo_h { get; set; }

            /// <summary>
            /// descripcion del modulo
            /// </summary>
            public string desc_modulo { get; set; }

            /// <summary>
            /// Motor de Importacion/Exportacion
            /// </summary>
            public Engine engine { get; set; }

            #region Campos Nuevos
            /// <summary>
            /// hora de inicio
            /// </summary>
            public TimeSpan starting { get; set; }

            /// <summary>
            /// Hora de fin
            /// </summary>
            public TimeSpan finish { get; set; }

            /// <summary>
            /// prioridad
            /// </summary>
            public int priority { get; set; }


            /// <summary>
            /// Tipo de proceso
            /// </summary>
            public ProcessType processType { get; set; }

            /// <summary>
            /// Dependencia de proceso 
            /// </summary>
            public CheckProcess require { get; set; }

            
            /// <summary>
            /// activo
            /// </summary>
            public bool active { get; set; }


            /// <summary>
            /// Indica si correra de manera especial en sabado o domingo
            /// </summary>
            public bool special_mode { get; set; }

            /// <summary>
            /// Conexion a bd.
            /// </summary>
            public CoreLib.Common.DBContext db_context { get; set; }

            #endregion



            #region Implementacion IDisposable
            /// <summary>
            /// Default destructor.
            /// </summary>
            ~ModuleType()
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
    namespace Collection
    {
        using DTO;
        /// <summary>
        /// Enumerador de ReportType
        /// </summary>
        /// <typeparam name="T"></typeparam>
        public class ModuleTypeEnumerator<T>
            : IEnumerator<T> where T : DTO.ModuleType
        {
            protected ModuleTypeCollection<T> _collection; //coleccion enumerada
            protected int index; //current index
            protected T _current; // current enumerated object in the collection
            public ModuleTypeEnumerator() { }
            public ModuleTypeEnumerator(ModuleTypeCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
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
        public class ModuleTypeCollection<T>
            : ICollection<T> where T : DTO.ModuleType
        {
            protected ArrayList _innerArray;
            protected bool _IsReadOnly;
            public ModuleTypeCollection() { this._innerArray = new ArrayList(); }
            public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
            public virtual T this[string ModuleTypeName]
            {
                get
                {
                    foreach (T obj in _innerArray)
                    {
                        if (obj.modulo == ModuleTypeName)
                        {
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
            public virtual bool Contains(T ModuleType)
            {
                foreach (T obj in _innerArray)
                {
                    if (obj.UniqueID == ModuleType.UniqueID) { return true; }
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


            public virtual void Add(T ReportType) { _innerArray.Add(ReportType); }
            public virtual void Clear() { _innerArray.Clear(); }
            public virtual void CopyTo(T[] ReportTypeArray, int index)
            {
                throw new Exception("Metodo no valido para esta implementacion");
            }
            public virtual IEnumerator<T> GetEnumerator()
            {
                return new ModuleTypeEnumerator<T>(this);
            }
            IEnumerator IEnumerable.GetEnumerator()
            {
                return new ModuleTypeEnumerator<T>(this);
            }
        }


    }
}