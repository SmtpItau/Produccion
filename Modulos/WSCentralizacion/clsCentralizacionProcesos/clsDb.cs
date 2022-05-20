using System;
using System.Data.SqlClient;
using System.Data;


namespace clsCentralizacionProcesos
{
    public class clsDb:clsLog
    {
        private SqlConnection odcConexion = new SqlConnection();
        private SqlTransaction odtTransaction = null;
        
        private string _DbUDL;

        static string sOrigen = "clsCentralizacionProcesos.clsDb";
        public string DbUDL { get => _DbUDL; set => _DbUDL = value; }
        

        public DataTable dtDatos;

        //Metodo para abrir la conexion
        public bool AbrirConexion()
        {
            try
            {
                NUMEX = 0;
                //if (odcConexion !=null && odcConexion.State == ConnectionState.Closed)
                odcConexion.ConnectionString = DbUDL;
                odcConexion.Open();
                return true;
            }
            catch (SqlException ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al abrir conexion";
                NUMEX = ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al abrir conexion";
                NUMEX = -1;// ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        //Metodo para cerrar la conexion
        public bool CerrarConexion()
        {
            try
            {
                NUMEX = 0;
                //if (odcConexion != null && odcConexion.State == ConnectionState.Open)
                odcConexion.Close();
                odcConexion.Dispose();
                //odcConexion = null;
                return true;
            }
            catch (SqlException ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al cerrar conexion";
                NUMEX = ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al cerrar conexion";
                NUMEX = -1;// ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }

        public bool IniciarTran()
        {
            try
            {
                NUMEX = 0;
                odtTransaction = odcConexion.BeginTransaction();
                return true;
            }
            catch (SqlException ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al iniciar Transaccion";
                NUMEX = ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al iniciar Transaccion";
                NUMEX = -1; //ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }
        public bool ConfirmarTran()
        {
            try
            {
                NUMEX = 0;
                //if (odtTransaction.Connection != null)
                odtTransaction.Commit();
                return true;
            }
            catch (SqlException ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al confirmar Transaccion";
                NUMEX = ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al confirmar Transaccion";
                NUMEX = -1; //ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }
        public bool CancelarTran()
        {
            try
            {
                NUMEX = 0;
                if (odtTransaction != null)
                {
                    odtTransaction.Rollback();
                    odtTransaction.Dispose();
                    odtTransaction = null;
                }
                return true;
            }
            catch (SqlException ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al cancelar Transaccion";
                NUMEX = ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al cancelar Transaccion";
                NUMEX = -1; //ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool Execute(string strSQL)
        {
            try
            {
                dtDatos = null;
                NUMEX = 0;
                //int retorno;
            
                SqlDataAdapter odaAdaptador = new SqlDataAdapter();
                odaAdaptador.SelectCommand = new SqlCommand();
                odaAdaptador.SelectCommand.CommandText = strSQL;
                odaAdaptador.SelectCommand.Connection = odcConexion;
                odaAdaptador.SelectCommand.Transaction = odtTransaction;

                //retorno = (Int32)odaAdaptador.SelectCommand.ExecuteScalar();

                DataSet dsDatos = new DataSet();
                odaAdaptador.Fill(dsDatos);

                if (dsDatos.Tables.Count > 0)
                {
                    dtDatos = dsDatos.Tables[0];
                }
               
                return true;

            }
            catch (SqlException ex)
            {
                //throw new Exception("Ha ocurrido un error ejecutando el query:\n" + strSQL + "\n\nDetalle del Error:\n" + exException.Message);
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar";
                NUMEX = ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar";
                NUMEX = -1; //ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
        }

        public bool Execute(string strSQL, object[] objParametros)
        {
            try
            {
                NUMEX = 0;
                dtDatos = null;

                SqlDataAdapter odaAdaptador = new SqlDataAdapter();
                odaAdaptador.SelectCommand = new SqlCommand();
                odaAdaptador.SelectCommand.CommandText = strSQL;
                odaAdaptador.SelectCommand.Connection = odcConexion;
                odaAdaptador.SelectCommand.Transaction = odtTransaction;
                odaAdaptador.SelectCommand.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter objParametro in objParametros)
                {
                    odaAdaptador.SelectCommand.Parameters.Add((SqlParameter)objParametro);
                }

                
                DataSet dsDatos = new DataSet();
                odaAdaptador.Fill(dsDatos);

                if (dsDatos.Tables.Count > 0)
                {
                    dtDatos = dsDatos.Tables[0];
                }

                return true;
               
            }
            catch (SqlException ex)
            {
                //throw new Exception("Ha ocurrido un error ejecutando el query:\n" + strSQL + "\n\nDetalle del Error:\n" + exException.Message);
                //MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar";
                NUMEX = ex.Number;
                MSGEX = ex.Message;

                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }
            catch (Exception ex)
            {
                MSGEX = ex.Message;
                MSGEXCTR = "Error al ejecutar";
                NUMEX = -1; //ex.Number;
                GeneraLog(sOrigen, MSGEXCTR, NUMEX, MSGEX);
                return false;
            }

        }
    }
}
