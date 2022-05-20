using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;

namespace cData.Manager
{

  /// <summary>
  /// Clase encargada de construir las distintas instrucciones Command a ejecutar
  /// </summary>
  public class DataCommandHelper
  {
    DataTable dataTable_ = null;
    DataParam[] parameters_ = null;

    private string _TableName = string.Empty;
    private bool _IsSP = false;

    private StringBuilder sbSelect_ = new StringBuilder();
    private StringBuilder sbDelete_ = new StringBuilder();
    private StringBuilder sbUpdate_ = new StringBuilder();
    private StringBuilder sbInsert_ = new StringBuilder();
    private StringBuilder sbExists_ = new StringBuilder();

    private StringBuilder sbCols_ = new StringBuilder();
    private StringBuilder sbColsWhere_ = new StringBuilder();

    #region "CONSTRUCTORES"

    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="dataTable">Tabla tipada a procesar</param>
    public DataCommandHelper(DataTable dataTable)
    {
      ConectorCommandBuilder_(null, dataTable, null);
    }

    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="dataTable">Tabla tipada a procesar</param>
    /// <param name="parameters">Lista de parametros a utilizar como filtros</param>
    public DataCommandHelper(DataTable dataTable, DataParam[] parameters)
    {
      ConectorCommandBuilder_(null, dataTable, parameters);
    }

    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="storeProcedure">Procedimiento almacenado a utilizar para recuperar la informacion</param>
    public DataCommandHelper(string storeProcedure)
    {
      ConectorCommandBuilder_(storeProcedure, null, null);
    }

    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="storeProcedure">Procedimiento almacenado a utilizar para recuperar la informacion</param>
    /// <param name="parameters">Lista de parametros a utilizar como filtros</param>
    public DataCommandHelper(string storeProcedure, DataParam[] parameters)
    {
      ConectorCommandBuilder_(storeProcedure, null, parameters);
    }

    /// <summary>
    /// Constructor interno
    /// </summary>
    /// <param name="storeProcedure">Procedimiento almacenado a utilizar para recuperar la informacion</param>
    /// <param name="dataTable">Tabla tipada a procesar</param>
    /// <param name="parameters">Lista de parametros a utilizar como filtros</param>
    void ConectorCommandBuilder_(string storeProcedure
      , DataTable dataTable
      , DataParam[] parameters)
    {
      this._IsSP = !string.IsNullOrEmpty(storeProcedure);
      this.dataTable_ = dataTable;
      this.parameters_ = parameters;

      if (this.dataTable_ != null) this._TableName = this.dataTable_.TableName;
      if (_IsSP) this._TableName = storeProcedure;
    }

    #endregion

    #region "PROPIEDADES A EXPONER AL USUARIO"

    /// <summary>
    /// Nombre de la Tabla
    /// </summary>
    public string TableName
    {
      get { return _TableName; }
    }

    /// <summary>
    /// Indiciador para tratarlo como Stored Procedure
    /// </summary>
    public bool IsSP
    {
      get { return _IsSP; }
    }

    #endregion

    #region "METODOS A EXPONER AL USUARIO, COMMAND PARA SOPORTE SQL"


    /// <summary>
    /// Construye la instruccion SQL requerida (Select)
    /// </summary>
    /// <returns>String con la query de consulta</returns>
    public string getSelect()
    {
      if (this.IsSP) return TableName;

      if (sbSelect_.Length < 1)
        sbSelect_.Append(string.Format("SELECT {0} FROM {1}", this.getCols_(), this.TableName));

      StringBuilder sb_ = new StringBuilder();
      if (parameters_ != null)
      {
        sb_.Append(sbSelect_.ToString());
        sb_.Append(" WHERE ");
        for (int i = 0; i < this.parameters_.Length; i++)
        {
          if (i > 0) sb_.Append(" AND ");
          for (int pos = 0; pos < this.dataTable_.Columns.Count; pos++)
          {
            if (this.dataTable_.Columns[pos].ColumnName.ToUpper().Contains(this.parameters_[i].Name.ToUpper()))
            {
              sb_.Append(string.Format("[{0}]=@{1}", this.dataTable_.Columns[pos].ColumnName, this.parameters_[i].Name));
              break;
            }
          }
        }
      }

      return (this.parameters_ == null) ? sbSelect_.ToString() : sb_.ToString();
    }

    /// <summary>
    /// Construye la instruccion SQL requerida (Update)
    /// </summary>
    /// <returns>String con la query de actualizacion</returns>
    public string getUpdate()
    {
      if (this.IsSP) return TableName;

      if (sbUpdate_.Length < 1)
      {
        for (int i = 0; i < this.dataTable_.Columns.Count; i++)
        {
          if (Array.IndexOf<DataColumn>(this.dataTable_.PrimaryKey, this.dataTable_.Columns[i]) >= 0) continue;

          if (sbUpdate_.Length > 0) sbUpdate_.Append(", ");
          sbUpdate_.Append(string.Format("[{0}]=@{0}", this.dataTable_.Columns[i].ColumnName));
        }
        sbUpdate_.Insert(0, string.Format("UPDATE {0} SET ", TableName));
        sbUpdate_.Append(string.Format(" WHERE {0} ", this.getColsWhere_()));
      }
      return sbUpdate_.ToString();
    }

    /// <summary>
    /// Construye la instruccion SQL requerida (Delete)
    /// </summary>
    /// <returns>String con la query de eliminacion</returns>
    public string getDelete()
    {
      if (this.IsSP) return TableName;

      if (sbDelete_.Length < 1)
        sbDelete_.Append(string.Format("DELETE FROM {0} WHERE {1}", TableName, this.getColsWhere_()));

      return sbDelete_.ToString();
    }

    /// <summary>
    /// Construye la instruccion SQL requerida (Insert)
    /// </summary>
    /// <returns>String con la query de creacion</returns>
    public string getInsert()
    {
      if (this.IsSP) return TableName;

      if (sbInsert_.Length < 1)
      {
        sbInsert_.Append(string.Format("INSERT INTO {0} ( {1} ) VALUES ( ", TableName, this.getCols_()));
        for (int i = 0; i < this.dataTable_.Columns.Count; i++)
        {
          if (i > 0) sbInsert_.Append(", ");
          sbInsert_.Append(string.Format("@{0}", this.dataTable_.Columns[i].ColumnName));
        }
        sbInsert_.Append(" )");
      }
      return sbInsert_.ToString();
    }

    /// <summary>
    /// Construye la instruccion SQL requerida (Find)
    /// </summary>
    /// <returns>String con la query de busqueda</returns>
    public string getExists()
    {
      if (this.IsSP) return TableName;

      if (sbExists_.Length < 1)
        sbExists_.Append(string.Format("SELECT 1 FROM {0} WHERE {1}", TableName, this.getColsWhere_()));

      return sbExists_.ToString();
    }

    #endregion

    #region "METODOS INTERNOS PROPIOS DE LA IMPLEMENTACION"

    /// <summary>
    /// Formar la lista de columnas de seleccion
    /// </summary>
    /// <returns></returns>
    internal string getCols_()
    {
      if (sbCols_.Length > 0) return sbCols_.ToString();

      for (int i = 0; i < this.dataTable_.Columns.Count; i++)
      {
        if (sbCols_.Length > 0) sbCols_.Append(", ");
        sbCols_.Append(string.Format("[{0}]", this.dataTable_.Columns[i].ColumnName));
      }
      return sbCols_.ToString();
    }

    /// <summary>
    /// Formar la lista de columnas de identificacion
    /// </summary>
    /// <returns></returns>
    internal string getColsWhere_()
    {
      if (sbColsWhere_.Length > 0) return sbColsWhere_.ToString();

      for (int i = 0; i < this.dataTable_.PrimaryKey.Length; i++)
      {
        if (sbColsWhere_.Length > 0) sbColsWhere_.Append(" AND ");
        sbColsWhere_.Append(string.Format("[{0}]=@{0}", this.dataTable_.PrimaryKey[i].ColumnName));
      }
      return sbColsWhere_.ToString();
    }

    #endregion

  }
}
