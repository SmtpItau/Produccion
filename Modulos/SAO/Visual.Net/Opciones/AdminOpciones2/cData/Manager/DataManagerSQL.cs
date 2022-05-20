using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System;

namespace cData.Manager
{
    /// <summary>
  /// Enumerador con los tipos de comandos aceptados
  /// para ser procesados
  /// </summary>
  internal enum T_CMD
  {
    SELECT,
    UPDATE,
    DELETE,
    INSERT,
    EXISTS
  };

  public class DataManagerSQL 
  {
    //variables de conexion
    string ConexionString_ = string.Empty;
    SqlConnection cnn_ = null;
    SqlTransaction tra_ = null;

    #region "CONSTRUCTOR"

    /// <summary>
    /// Constructor
    /// </summary>
    /// <param name="connectionString">ConnectionString con la informacion de conexion</param>
    public DataManagerSQL(string connectionString)
    {
      ConexionString_ = connectionString;
    }

    #endregion

    #region "METODOS HELPER (DATATABLE)"

    internal SqlCommand getCommandByDataTable(DataTable itemTbl, string storedProcedure, SqlConnection SqlConn, params DataParam[] Parameters)
    {
      SqlCommand cmd_ = SqlConn.CreateCommand();
      DataCommandHelper cb_ = null;

      if (!string.IsNullOrEmpty(storedProcedure) && Parameters != null)
        cb_ = new DataCommandHelper(storedProcedure, Parameters);
      else if (!string.IsNullOrEmpty(storedProcedure))
        cb_ = new DataCommandHelper(storedProcedure);
      else if (Parameters != null)
        cb_ = new DataCommandHelper(itemTbl, Parameters);
      else
        cb_ = new DataCommandHelper(itemTbl);

      cmd_.CommandText = cb_.getSelect();
      if (cb_.IsSP) cmd_.CommandType = CommandType.StoredProcedure;

      //pasar los parametros
      if (Parameters != null)
        for (int i = 0; i < Parameters.Length; i++)
          cmd_.Parameters.AddWithValue(string.Format("@{0}", Parameters[i].Name), Parameters[i].Value);

      return cmd_;
    }

    internal SqlDataAdapter getDataAdapter(DataTable dataTable, SqlConnection SqlConn)
    {
      string key_ = dataTable.GetType().Name;
      DataCommandHelper cb_ = null;

      //if (key_ != "DataTable" && TypeCache.CacheDataTable.ContainsKey(key_))
      //  cb_ = TypeCache.CacheDataTable[key_];
      //else
        cb_ = new DataCommandHelper(dataTable);

      SqlDataAdapter _adapter;

      _adapter = new SqlDataAdapter();
      _adapter.SelectCommand = new SqlCommand(cb_.getSelect(), SqlConn);
      _adapter.SelectCommand.Transaction = this.tra_;

      _adapter.InsertCommand = new SqlCommand(cb_.getInsert(), SqlConn);
      _adapter.InsertCommand.Transaction = this.tra_;

      _adapter.UpdateCommand = new SqlCommand(cb_.getUpdate(), SqlConn);
      _adapter.UpdateCommand.Transaction = this.tra_;

      _adapter.DeleteCommand = new SqlCommand(cb_.getDelete(), SqlConn);
      _adapter.DeleteCommand.Transaction = this.tra_;

      for (int i = 0; i < dataTable.Columns.Count; i++)
      {
        _adapter.DeleteCommand.Parameters.Add(this.CreateParam(dataTable.Columns[i], false));
        _adapter.InsertCommand.Parameters.Add(this.CreateParam(dataTable.Columns[i], false));

        if (Array.IndexOf<DataColumn>(dataTable.PrimaryKey, dataTable.Columns[i]) >=0)
          _adapter.UpdateCommand.Parameters.Add(this.CreateParam(dataTable.Columns[i], true));
        else
          _adapter.UpdateCommand.Parameters.Add(this.CreateParam(dataTable.Columns[i], false));
      }

      //mover a la cache!
      //if (key_ != "DataTable" && !TypeCache.CacheDataTable.ContainsKey(key_)) 
      //  TypeCache.CacheDataTable.Add(key_, cb_);

      //SqlCommandBuilder cmb_ = new SqlCommandBuilder(_adapter);
      //_adapter.InsertCommand = cmb_.GetInsertCommand();
      //_adapter.UpdateCommand = cmb_.GetUpdateCommand();
      //_adapter.DeleteCommand = cmb_.GetDeleteCommand();
      return _adapter;

    }

    internal SqlParameter CreateParam(DataColumn column, bool IsUpd)
    {
      SqlParameter sqlParam = new SqlParameter();
      sqlParam.ParameterName = "@" + column.ColumnName;
      sqlParam.SourceColumn = column.ColumnName;
      if (IsUpd) sqlParam.SourceVersion = DataRowVersion.Original;

      return sqlParam;
    }


    internal void FillDataTable_(DataTable dataTable, string storedProcedure, params DataParam[] parameters)
    {
      dataTable.Rows.Clear(); //limpiar informacion anterior
      if (tra_ == null || tra_.Connection == null)
      {
        using (cnn_ = new SqlConnection(ConexionString_))
        {
          using (SqlCommand cmd_ = this.getCommandByDataTable(dataTable, storedProcedure, cnn_, parameters))
          {
            cnn_.Open();
            using (SqlDataReader dr = cmd_.ExecuteReader())
            {
              if (dr.HasRows) dataTable.Load(dr);
            }
          }
        }
      }
      else
      {
        using (SqlCommand cmd_ = this.getCommandByDataTable(dataTable, storedProcedure, cnn_, parameters))
        {
          cmd_.Transaction = this.tra_;
          using (SqlDataReader dr = cmd_.ExecuteReader())
          {
            if (dr.HasRows) dataTable.Load(dr);
          }
        }
      }
    }

    internal int UpdateDataTable_(DataTable dataTable)
    {
      //valor a retornar
      int retorno_ = 0;
      bool traForce_ = false;

      if (tra_ == null || tra_.Connection == null)
      {
        traForce_ = true;
        this.TransactionBegin();
      }

      using (SqlDataAdapter da_ = this.getDataAdapter(dataTable, cnn_))
      {
        DataTable dt_ = dataTable.GetChanges(DataRowState.Deleted);
        if (dt_!=null) retorno_ += da_.Update(dt_);

        dt_ = dataTable.GetChanges(DataRowState.Modified);
        if (dt_ != null) retorno_ += da_.Update(dt_);

        dt_ = dataTable.GetChanges(DataRowState.Added);
        if (dt_ != null) retorno_ += da_.Update(dt_);

      }

      if (traForce_) this.TransactionCommit();

      return retorno_;
    }

    #endregion

    #region IDataManager Members

    public void TransactionBegin()
    {
      if (cnn_ != null && cnn_.State == ConnectionState.Open) cnn_.Close();
      if (cnn_ == null) cnn_ = new SqlConnection(ConexionString_);
      if (string.IsNullOrEmpty(cnn_.ConnectionString)) cnn_.ConnectionString = this.ConexionString_;

      cnn_.Open();
      tra_ = cnn_.BeginTransaction();
    }

    public void TransactionCommit()
    {
      if (cnn_ != null && tra_ != null) tra_.Commit();
      if (cnn_.State == ConnectionState.Open) cnn_.Close();
    }

    public void TransactionRollback()
    {
      if (cnn_ != null && tra_ != null) tra_.Rollback();
      if (cnn_.State == ConnectionState.Open) cnn_.Close();
    }

    public void Fill(DataTable dataTable)
    {
      this.FillDataTable_(dataTable, null, null);
    }

    public void Fill(DataTable dataTable, params DataParam[] parameters)
    {
      this.FillDataTable_(dataTable, null, parameters);
    }

    public void Fill(DataTable dataTable, string storedProcedure)
    {
      this.FillDataTable_(dataTable, storedProcedure, null);
    }

    public void Fill(DataTable dataTable, string storedProcedure, params DataParam[] parameters)
    {
      this.FillDataTable_(dataTable, storedProcedure, parameters);
    }

    public int Update(DataTable dataTable)
    {
        return this.UpdateDataTable_(dataTable);
    }


    #endregion

  }
}
