USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_RECHAZA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LINEAS_RECHAZA]
   (   @dFecha         DATETIME
   ,   @cSistema       CHAR(03)
   ,   @nNumoper       NUMERIC(10)
   ,   @cOperador_Ap   CHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Codigo_Excepcion      CHAR(02)
   DECLARE @Numero_Operacion      NUMERIC(10)
   DECLARE @Numero_Documento      NUMERIC(10)
   DECLARE @Numero_Correlativo    NUMERIC(10)
   DECLARE @Rut_Cliente           NUMERIC(09)
   DECLARE @Codigo_Cliente        NUMERIC(09)
   DECLARE @Numero_Traspaso       NUMERIC(10)
   DECLARE @Codigo_Producto       CHAR(05)
   DECLARE @Tipo_Operacion        CHAR(05)
   DECLARE @Operador              CHAR(15)
   DECLARE @Monto_Autorizado      FLOAT
   DECLARE @Contador              INTEGER
   DECLARE @Total                 INTEGER
   DECLARE @Id_Sistema            CHAR(03)
   DECLARE @GlosaExcepcion        VARCHAR(100)
   DECLARE @cOperador             CHAR(10)	  -- Se agrega 
   DECLARE @nMonto_Operador	  NUMERIC(19,4)
   DECLARE @cOperador_Autoriza	  CHAR(10)
   DECLARE @nMonto_Autoriza	  NUMERIC(19,4)
   DECLARE @firma1 		  CHAR(15)

    		    -->======= Determina si es operación generada en CHile o NY =========--
		   DECLARE @EsOperacionNY as char(2)
		   SET @EsOperacionNY = 'No'
 			IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @nNumoper)
						set @EsOperacionNY = 'Si'

			IF exists (select 1 from BacSwapNY..CARTERA where numero_operacion = @nNumoper)
						set @EsOperacionNY = 'Si'

			IF exists (select * from BacFWDNY..MFCA where canumoper = @nNumoper)
						set @EsOperacionNY = 'Si'
			--===================================================================--


   /*******************************************************************************************************************************************
      LINEAS DE CLIENTES
   *******************************************************************************************************************************************/

   SET    @Contador = 1
   SELECT @Total    = COUNT(1) FROM LINEA_TRANSACCION_DETALLE WHERE numerooperacion = @nNumoper AND id_sistema = @cSistema

  

   WHILE @Contador <= @Total
   BEGIN
      SET ROWCOUNT @Contador

      SELECT @Numero_Documento   = NumeroDocumento
      ,      @Numero_Correlativo = NumeroCorrelativo
      ,      @Rut_Cliente        = Rut_Cliente
      ,      @Codigo_Cliente     = Codigo_Cliente
      ,      @Numero_Traspaso    = 0
      ,      @Codigo_Producto    = Codigo_Producto
      ,      @Tipo_Operacion     = ''
      ,      @Operador           = ''
      ,      @Monto_Autorizado   = MontoTransaccion
      ,      @Codigo_Excepcion   = 'R'
      ,      @Id_Sistema         = Id_Sistema
      FROM   LINEA_TRANSACCION_DETALLE
      WHERE  NumeroOperacion     = @nNumoper
      AND    id_sistema          = @cSIstema

      SET ROWCOUNT 0

      SELECT @Tipo_Operacion = Tipo_Operacion
      ,      @Operador       = Operador
      FROM   LINEA_TRANSACCION 
      WHERE  NumeroOperacion = @nNumoper
      AND    id_sistema      = @cSistema

      SET    @Contador       = @Contador + 1

      INSERT INTO LINEA_AUTORIZACION
      (  codigo_excepcion
      ,  FechaAutorizo
      ,  NumeroOperacion
      ,  NumeroDocumento
      ,  NumeroCorrelativo
      ,  Rut_Cliente
      ,  Codigo_Cliente
      ,  NumeroTraspaso
      ,  id_Sistema
      ,  Codigo_Producto
      ,  TipoOperacion
      ,  Operador
      ,  MontoAutorizo
      ,  UsuarioAutorizo
      ,  Activo
      ,  Hora_Autorizacion
      )
      VALUES
      (  @Codigo_Excepcion
      ,  @dFecha
      ,  @nNumoper
      ,  @Numero_Documento
      ,  @Numero_Correlativo
      ,  @Rut_Cliente
      ,  @Codigo_Cliente
      ,  @Numero_Traspaso
      ,  @Id_Sistema
      ,  @Codigo_Producto
      ,  @Tipo_Operacion
      ,  @Operador
      ,  @Monto_Autorizado
      ,  @cOperador_Ap
      ,  'S'
      ,  CONVERT(CHAR(08),GETDATE(),114)
      )
   END

   /*******************************************************************************************************************************************
      LIMITES DE USUARIO
   *******************************************************************************************************************************************/

   SET    @Contador = 1
   SELECT @Total    = COUNT(1) FROM LIMITE_TRANSACCION WHERE NumeroOperacion = @nNumoper AND ID_Sistema = @cSistema

   WHILE @Contador <= @Total
   BEGIN

      SET ROWCOUNT @Contador

  SELECT @Numero_Documento   = NumeroOperacion
      ,      @Numero_Correlativo = 0
      ,      @Rut_Cliente        = 0
      ,      @Codigo_Cliente     = 0
      ,      @Numero_Traspaso    = 0
      ,      @Codigo_Producto    = Codigo_Producto
      ,      @Tipo_Operacion     = ''
      ,      @Operador           = Operador
      ,      @Monto_Autorizado   = MontoTransaccion
      ,      @Codigo_Excepcion   = 'R'
      ,      @Id_Sistema         = Id_Sistema
      FROM   LIMITE_TRANSACCION
      WHERE  NumeroOperacion     = @nNumoper
      AND    ID_Sistema          = @cSIstema

      SET ROWCOUNT 0

      SET ROWCOUNT 1

      IF @cSistema = 'BTR'
         SELECT @Rut_Cliente     = morutcli
         ,      @Codigo_Cliente  = mocodcli
         ,      @Tipo_Operacion  = SUBSTRING(motipoper,1,2)
         FROM 	VIEW_MDMO
         WHERE	monumoper        = @nNumoper

      IF @cSistema = 'BCC'
         SELECT @Rut_Cliente     = morutcli
         ,      @Codigo_Cliente  = mocodcli
         ,      @Tipo_Operacion  = motipope
         FROM   VIEW_MEMO
         WHERE  monumope         = @nNumoper

      IF @cSistema = 'BFW'
	  BEGIN
		IF @EsOperacionNY = 'No'
				 SELECT @Rut_Cliente     = mocodigo
				 ,      @Codigo_Cliente  = mocodcli
				 ,      @Tipo_Operacion  = motipoper
				 FROM   VIEW_MFMO
				 WHERE  monumoper        = @nNumoper
		IF @EsOperacionNY = 'Si'
				 SELECT @Rut_Cliente     = mocodigo
				 ,      @Codigo_Cliente  = mocodcli
				 ,      @Tipo_Operacion  = motipoper
				 FROM   VIEW_MFMO_NY
				 WHERE  monumoper        = @nNumoper

	  END

      IF @cSistema = 'BEX'	
	  BEGIN
		IF @EsOperacionNY = 'No'
				 SELECT	@Rut_Cliente     = morutcli
				 ,      @Codigo_Cliente  = mocodcli
				 ,      @Tipo_Operacion  = motipoper
				 FROM	VIEW_TEXT_MVT_DRI 
				 WHERE 	monumoper        = @nNumoper
		IF @EsOperacionNY = 'Si'
				 SELECT	@Rut_Cliente     = morutcli
				 ,      @Codigo_Cliente  = mocodcli
				 ,      @Tipo_Operacion  = motipoper
				 FROM	VIEW_text_mvt_dri_NY
				 WHERE 	monumoper        = @nNumoper
		END

	--// ******PRD-21033 Consulta base BacBonosExtNY*********
	--IF @cSistema = 'BEX'	
 --        SELECT	@Rut_Cliente     = morutcli
 --        ,      @Codigo_Cliente  = mocodcli
 --        ,      @Tipo_Operacion  = motipoper
 --        FROM	VIEW_text_mvt_dri_NY
 --        WHERE 	monumoper        = @nNumoper
	--//***********************************************

      IF @cSistema = 'PCS'
	  BEGIN
		IF @EsOperacionNY = 'No'
			 SELECT	@Rut_Cliente     = rut_cliente
			 ,      @Codigo_Cliente  = codigo_cliente
			 ,      @Tipo_Operacion  = tipo_operacion
			 FROM	VIEW_MOVDIARIO
			 WHERE 	numero_operacion = @nNumoper
		IF @EsOperacionNY = 'Si'
			 SELECT	@Rut_Cliente     = rut_cliente
			 ,      @Codigo_Cliente  = codigo_cliente
			 ,      @Tipo_Operacion  = tipo_operacion
			 FROM	VIEW_MOVDIARIO_NY
			 WHERE 	numero_operacion = @nNumoper
	   END

      SET ROWCOUNT 0

      SET @Contador = @Contador + 1

      INSERT INTO LINEA_AUTORIZACION
      (   codigo_excepcion
      ,   FechaAutorizo
      ,   NumeroOperacion
      ,   NumeroDocumento
      ,   NumeroCorrelativo
      ,   Rut_Cliente
      ,   Codigo_Cliente
      ,   NumeroTraspaso
      ,   Id_Sistema
      ,   Codigo_Producto
      ,   TipoOperacion
      ,   Operador
      ,   MontoAutorizo
      ,   UsuarioAutorizo
      ,   Activo
      ,   Hora_Autorizacion
      )
      VALUES   
      (   @Codigo_Excepcion
      ,   @dFecha
      ,   @nNumoper
      ,   @Numero_Documento
      ,   @Numero_Correlativo
      ,   @Rut_Cliente
      ,   @Codigo_Cliente
      ,   @Numero_Traspaso
      ,   @Id_Sistema
      ,   @Codigo_Producto
      ,   @Tipo_Operacion
      ,   @Operador
      ,   @Monto_Autorizado
      ,   @cOperador_Ap
      ,   'S'
      ,   CONVERT(CHAR(08),GETDATE(),114)
      )
   END

   IF @cSistema = 'BTR'	UPDATE view_mdmo 	 SET mostatreg = 'R'            WHERE monumoper = @nNumoper
   
   IF @cSistema = 'BFW'	UPDATE view_mfmo 	 SET moestado  = 'R'            WHERE monumoper = @nNumoper
   IF @cSistema = 'BFW'	UPDATE view_mfca 	 SET caestado  = 'R'            WHERE canumoper = @nNumoper
   IF @cSistema = 'BFW'	UPDATE VIEW_MFMO_NY 	 SET moestado  = 'R'            WHERE monumoper = @nNumoper --> PRD-21033
   IF @cSistema = 'BFW'	UPDATE VIEW_MFCA_NY 	 SET caestado  = 'R'            WHERE canumoper = @nNumoper --> PRD-21033
   
   IF @cSistema = 'BCC'	UPDATE view_memo 	 SET moestatus = 'R'            WHERE monumope  = @nNumoper
   IF @cSistema = 'BEX'	UPDATE VIEW_TEXT_MVT_DRI SET mostatreg = 'R'            WHERE monumoper = @nNumoper
   IF @cSistema = 'BEX'	UPDATE VIEW_TEXT_MVT_DRI_NY SET mostatreg = 'R'            WHERE monumoper = @nNumoper --> PRD-21033 Consulta base BacBonosExtNY
   
   IF @cSistema = 'PCS'	UPDATE VIEW_MOVDIARIO	 SET Estado_oper_lineas   = 'R' WHERE numero_operacion =@nNumoper
   IF @cSistema = 'PCS'	UPDATE VIEW_cartera	 SET Estado_oper_lineas   = 'R'	WHERE numero_operacion =@nNumoper 
   IF @cSistema = 'PCS'	UPDATE VIEW_MOVDIARIO_NY	 SET Estado_oper_lineas   = 'R' WHERE numero_operacion =@nNumoper --> PRD-21033
   IF @cSistema = 'PCS'	UPDATE VIEW_CARTERA_NY	 SET Estado_oper_lineas   = 'R'	WHERE numero_operacion =@nNumoper  --> PRD-21033
   
	--+++CONTROL IDD, jcamposd rechaza la operación via control financiero
   	UPDATE Transacciones_IDD
	SET iEstadoIDD	= 'R'
	WHERE cModulo		= @cSistema
		AND nOperacion	= @nNumoper
		AND iEstadoIDD	= 'P'
   --+++CONTROL IDD, jcamposd rechaza la operación via control financiero
   

   SELECT @cOperador 		= Operador_Origen
   ,      @nMonto_Operador	= Monto_Operador
   ,      @cOperador_Autoriza	= Operador_Autoriza
   ,      @nMonto_Autoriza	= Monto_Operacion
   ,      @firma1               = Firma1
   FROM   DETALLE_APROBACIONES 
   WHERE  Numero_Operacion      = @nNumoper 

   IF @cSistema = 'PCS' 
   BEGIN
      SET @Codigo_Producto = (SELECT DISTINCT codigo_grupo FROM GRUPO_PRODUCTO WHERE Id_Sistema = @cSistema)
   END
   IF @cSistema = 'BEX' 
   BEGIN 
      SET @Codigo_Producto = (SELECT DISTINCT codigo_grupo FROM GRUPO_PRODUCTO WHERE Id_Sistema = 'BTR' AND Codigo_Producto = 'CP')
   END



   UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO 
   SET 	  Acumulado_Diario  = Acumulado_Diario - @nMonto_Autoriza
   WHERE  Usuario           = @firma1
   AND    Codigo_Producto   = @Codigo_Producto

END
--> +++ cvegasan 2017.08.08 Control Lineas IDD
GO
