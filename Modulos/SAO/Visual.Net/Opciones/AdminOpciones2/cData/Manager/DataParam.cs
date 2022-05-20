
namespace cData.Manager
{

  /// <summary>
  /// Clase empleada para la asignacion de parametros en las 
  /// operaciones realizadas por el Conector de datos.
  /// </summary>
  public class DataParam
  {
    string _Name;
		object _Value;

    #region "CONSTRUCTOR"

    public DataParam(string Name, object Value)
		{
			this._Name = Name;
			this._Value = Value;
    }

    #endregion

    #region Miembros de IDataParam

    /// <summary>
    /// Nombre del parametro (sin @)
    /// </summary>
    public string Name
    {
      get { return _Name; }
    }

    /// <summary>
    /// Valor del parametro
    /// </summary>
    public object Value
    {
      get { return _Value; }
    }

    #endregion

  }

}