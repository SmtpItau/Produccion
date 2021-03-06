USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_REGISTRO_LINEAS_DERIVADOS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_REGISTRO_LINEAS_DERIVADOS]
   (   @dFecPro  	 DATETIME
   ,   @cSistema 	 CHAR(03)
   ,   @cProducto 	 CHAR(05)
   ,   @nRutcli 	 NUMERIC(09,0)
   ,   @nCodigo 	 NUMERIC(09,0)
   ,   @nNumoper 	 NUMERIC(10,0)
   ,   @nNumdocu 	 NUMERIC(10,0)
   ,   @nCorrela 	 NUMERIC(10,0)
   ,   @dFeciniop 	 DATETIME
   ,   @nMonto   	 NUMERIC(19,4)
   ,   @fTipcambio 	 NUMERIC(08,4)
   ,   @dFecvctop 	 DATETIME
   ,   @cUsuario 	 CHAR(10)
   ,   @cMonedaOp 	 NUMERIC(05,00)
   ,   @cTipo_Riesgo	 CHAR(1)
   ,   @incodigo	 NUMERIC(5)
   ,   @formapago	 NUMERIC(3)
   ,   @nContraMoneda	 NUMERIC(03) = 0
   ,   @nMonedaOpera     NUMERIC(03) = 0
   --,   @SwithEjecucion   INTEGER     = 0
   ,   @Resultado        FLOAT					
   ,   @MetodoLCR        NUMERIC(5)				
   ,   @Garantia         FLOAT   			
   ,   @Id_SistemaNetting CHAR(3) 	      
   )
AS
BEGIN

   SET NOCOUNT ON


   DECLARE @cNombre            CHAR(60)
   DECLARE @nCorrDet		   INTEGER   
   DECLARE @cTipoMov		   VARCHAR(1)
   DECLARE @cTipoLinea		   VARCHAR(1)
   DECLARE @cTipoControl	   VARCHAR(1)

   DECLARE @nDisponible		   NUMERIC(19,4)
   DECLARE @dFecvctolineaGen   DATETIME
   DECLARE @dFecvctolineaSis   DATETIME
   DECLARE @cBloqueado		   CHAR(01)

   DECLARE @nExceso		       NUMERIC(19,4)
   DECLARE @nMontoLinGen	   NUMERIC(19,4)
   DECLARE @nMontoLinSis	   NUMERIC(19,4)
   DECLARE @nMontoLinPro	   NUMERIC(19,4)
   DECLARE @cCtrlplazo		   CHAR(01)
   DECLARE @nPlazoDesde		   NUMERIC(10,0) 
   DECLARE @nPlazoHasta		   NUMERIC(10,0)
   DECLARE @cError       	   VARCHAR(1)
   DECLARE @cMensaje		   VARCHAR(255)
   DECLARE @TotalOcupado	   NUMERIC(19,4)

   DECLARE @FactorCnvLinGen    NUMERIC(19,4)
   DECLARE @FactorCnvLinSis    NUMERIC(19,4)

   DECLARE @nDisponibleLinSis  NUMERIC(19,4)
   DECLARE @nDisponibleLinGen  NUMERIC(19,4)


   IF @nCodigo = 0
      SELECT @cNombre = clnombre
      ,	     @nCodigo = clcodigo
      FROM   BacParamSuda.dbo.CLIENTE
      WHERE  clrut    = @nRutcli
   ELSE
      SELECT @cNombre = clnombre
      FROM   BacParamSuda.dbo.CLIENTE
      WHERE  clrut    = @nRutcli
      AND    clcodigo = @nCodigo

   SET @nCorrDet      = 0  
   SET @cTipoMov      = 'S'   -- S.suma R.resta
   SET @cTipoLinea    = 'L'   -- L.linea
   SET @cTipoControl  = 'C'   -- C.control


   -- 8800 no debe usar tomar familias tipo FFMM
   -- Se elimina busqueda previa por que se logra la misma 
   -- funcionalidad mas eficiente
   --IF EXISTS( SELECT 1 FROM CLIENTE_RELACIONADO WHERE clrut_hijo = @nRutcli AND clcodigo_hijo = @nCodigo )
   --BEGIN
         SELECT @nRutcli      = clrut_padre		
         ,      @nCodigo      = clcodigo_padre
         FROM   BacLineas..CLIENTE_RELACIONADO 
         WHERE  clrut_hijo    = @nRutcli	
         AND    clcodigo_hijo = @nCodigo
   ---END



   SET @FactorCnvLinGen = 1.0
   Set @nDisponibleLinGen = 0.0
   SELECT @nDisponibleLinGen     = TotalAsignado 
   ,	  @cBloqueado            = bloqueado  		
   ,	  @dFecvctolineaGen      = fechavencimiento
   ,      @FactorCnvLinGen       = isnull( VMC.Tipo_Cambio, 1 )
   FROM   LINEA_GENERAL  LinGen     
      left Join  BacTraderSuda..Mdac Con ON 1=1   --- select acfecante from BacTraderSuda..Mdac
      left Join  BacParamSuda..Valor_Moneda_Contable VMC ON VMC.Fecha = Con.acfecante  -- select * from BacParamSuda..Valor_Moneda_Contable where fecha = (select acfecante from BacTraderSuda..Mdac)
                                                        and VMC.Codigo_Moneda = case when LinGen.Moneda = 13 then 994 else LinGen.Moneda end 

   WHERE  rut_cliente  	  = @nRutcli	
   AND	  codigo_cliente  = @nCodigo


   SET  @nMontoLinGen = CASE WHEN @MetodoLCR = 5 THEN case when @Resultado - @Garantia > 0 then
                                                                                             @Resultado - @Garantia
                                                                                           else
                                                                                             0.0
                                                                                           end
                                                                         ELSE @Resultado END 
   SET  @nMontoLinSis = CASE WHEN @MetodoLCR = 5 THEN case when @Resultado - @Garantia > 0 then
                                                                                             @Resultado - @Garantia
                                                                                           else
                                                                                             0.0
                                                                                           end
                                                                         ELSE @Resultado END


      --*************************************
      --*************** 
      --*************** LINEA SISTEMA
      --*************** 
      --*************************************
      SET @nDisponibleLinSis = 0.00000  
      SET @FactorCnvLinSis = 1
      SELECT @nDisponibleLinSis   = TotalAsignado     , 
             @cBloqueado          = bloqueado  		  ,
             @dFecvctolineaSis    = fechavencimiento  ,
             @FactorCnvLinSis     = isnull( VMC.Tipo_Cambio, 1 ) 
      FROM   LINEA_SISTEMA  LinGen     
      left Join  BacTraderSuda..Mdac Con ON 1=1
      left Join  BacParamSuda..Valor_Moneda_Contable VMC ON VMC.Fecha = Con.acfecante 
                                                        and VMC.Codigo_Moneda = case when LinGen.Moneda = 13 then 994 else LinGen.Moneda end 

      WHERE  rut_cliente    = @nRutcli
      AND    codigo_cliente = @nCodigo
      AND    id_sistema     = @Id_SistemaNetting  --  @cSistema PRD8800


      IF @cBloqueado = 'S'  --** Linea Sistema Bloqueada para operar **--
      BEGIN
         SELECT @cMensaje = 'Linea Sistema Bloqueada Para ' + @cNombre,
                @cError   = 'S'	,
		        @nExceso  = 0	,
		        @nCorrDet = @nCorrDet + 1
        
         INSERT INTO LINEA_TRANSACCION_DETALLE
         (   NumeroOperacion	,
             NumeroDocumento	,
             NumeroCorrelativo	,
             NumeroCorre_Detalle,
             Rut_Cliente	,
             Codigo_Cliente	,
             Id_Sistema		,
             Codigo_Producto	,
             Tipo_Detalle	,
      Tipo_Movimiento	,
             Linea_Transsaccion	,
             MontoTransaccion	,
             MontoExceso	,
             PlazoDesde		,
             PlazoHasta		,
             Actualizo_Linea	,
Error   		,
 Mensaje_Error	,
             instrumento	,
             moneda		,
             forma_pago 
         )
         SELECT	@nNumoper	,
                @nNumdocu	,
                @nCorrela	,
                @nCorrDet	,
                @nRutcli	,
                @nCodigo	,
                @cSistema	,
                @cProducto	,
                @cTipoControl	,
                @cTipoMov	,
                'LINSIS'	,
                @nMontoLinSis   ,
                @nExceso	,
                0		,
                0		,
                'S'		,
                @cError		,
                @cMensaje	,
                0     ,
                @cMonedaOp	,
                @formapago
      END


      IF @dFecPro>@dFecvctolineaSis
      BEGIN
         SELECT @cMensaje = 'Linea Sistema Vencida Para ' + @cNombre  ,
                @cError   = 'S'	                               ,
                @nExceso  = 0	                     ,
                @nCorrDet = @nCorrDet + 1                 
      
         INSERT INTO LINEA_TRANSACCION_DETALLE
         (   NumeroOperacion	,
             NumeroDocumento	,
             NumeroCorrelativo	,
             NumeroCorre_Detalle,
             Rut_Cliente	,
             Codigo_Cliente	,
             Id_Sistema		,
             Codigo_Producto	,
             Tipo_Detalle	,
             Tipo_Movimiento	,
             Linea_Transsaccion	,
             MontoTransaccion	,
             MontoExceso	,
             PlazoDesde		,
             PlazoHasta		,
             Actualizo_Linea	,
             Error   		,
             Mensaje_Error	,
             instrumento	,
             moneda		,
             forma_pago 
      )   
         SELECT	@nNumoper	,
                @nNumdocu	,
                @nCorrela	,
                @nCorrDet	,
                @nRutcli	,
                @nCodigo	,
                @cSistema	,
                @cProducto	,
                @cTipoControl	,
                @cTipoMov	,
                'LINSIS'	,
                @nMontoLinSis	,
                @nExceso	,
                0		,
                0		,
                'S'		,
                @cError		,
                @cMensaje	,
                0           ,
                @cMonedaOp	,
                @formapago
      END


      
      -- MAP: Conversion del Monto que viene en CLP 
      Set @nMontoLinSis = round( ( @nMontoLinSis / @FactorCnvLinSis ) * 1.000000000 
                                 , case when @FactorCnvLinSis = 1 then 0 else 4 end ) 

      -- @nDisponibleLinSis viene con el TotalAsignado linea Sistema
      Set @nDisponibleLinSis  = @nDisponibleLinSis  - @nMontoLinSis

      Set @nExceso        = case when @nDisponibleLinSis < 0 then -@nDisponibleLinSis else 0 end
     
      UPDATE LINEA_SISTEMA -- select * from LINEA_SISTEMA
      SET    totalocupado    = @nMontoLinSis      
      ,      totaldisponible = case when @nExceso > 0 then  0   else @nDisponibleLinSis end 
      ,      TotalExceso     = @nExceso
      WHERE  rut_cliente     = @nRutcli	
      AND    codigo_cliente  = @nCodigo	
      AND    id_sistema      = @Id_SistemaNetting  --  @cSistema PRD8800

      IF @nExceso <> 0
         SELECT @cMensaje = 'Limite Sistema Excedido Para ' + @cNombre,
                @cError   = 'S',
                @nExceso  = @nExceso 
      ELSE           
         SELECT @cMensaje = '' ,
                @cError   = 'N',
                @nExceso  = 0
       

      SET @nCorrDet = @nCorrDet + 1


      INSERT INTO LINEA_TRANSACCION_DETALLE
      (   NumeroOperacion	,
          NumeroDocumento	,
          NumeroCorrelativo	,
          NumeroCorre_Detalle	,
          Rut_Cliente		,
          Codigo_Cliente	,
          Id_Sistema		,
          Codigo_Producto	,
          Tipo_Detalle		,
          Tipo_Movimiento	,
          Linea_Transsaccion	,
          MontoTransaccion	,
          MontoExceso		,
          PlazoDesde		,
          PlazoHasta		,
          Actualizo_Linea	,
          Error			,
          Mensaje_Error		,
          instrumento		,
          moneda		,
          forma_pago
      )
      SELECT @nNumoper	   ,
             @nNumdocu	   ,
             @nCorrela	   ,
             @nCorrDet	   ,
             @nRutcli	   ,
             @nCodigo	   ,
             @cSistema	   ,
             @cProducto	   ,
             @cTipoLinea   ,
             @cTipoMov	   ,
             'LINSIS'	   ,
             @nMontoLinSis ,
             @nExceso	   ,
             0		   ,
             0		   ,
             'S'	   ,
             @cError	   ,
             @cMensaje	   ,
             0        ,
             @cMonedaOp	  ,
             @formapago


      --*************************************
      --*************** 
      --*************** LINEA POR PRODUCTO PLAZO
      --*************** 
      --*************************************

      SET @cCtrlplazo = 'S'

      IF @cCtrlplazo = 'S'
      BEGIN
         SELECT @ndisponible = 0
         SET @incodigo = 0
         SET @formapago = 0
         SET @cMonedaOp = 0

         

         DECLARE @nnPlazoProdPla   NUMERIC(9)
         SET @nnPlazoProdPla   = DATEDIFF(DAY, @dFecPro, @dFecvctop)

         EXECUTE dbo.SP_VALIDA_LINPRODUCTO_PLAZO @nRutcli, @nCodigo, @Id_SistemaNetting, @Id_SistemaNetting, @incodigo, @nnPlazoProdPla

         SET ROWCOUNT 1
         SELECT @nPlazoDesde    = ISNULL(PlazoDesde,0)
         ,      @nPlazoHasta    = ISNULL(PlazoHasta,0)
         ,      @nDisponible    = TotalAsignado 
         FROM   LINEA_PRODUCTO_POR_PLAZO
         WHERE  rut_cliente	= @nRutcli
         AND    codigo_cliente	= @nCodigo
         AND    id_sistema	=  @Id_SistemaNetting    -- @cSistema   PRD08800
--         AND    codigo_producto = @Id_SistemaNetting -- @cProducto  PRD08800
--         AND   (incodigo	= @incodigo) -->  or incodigo = 0 or @incodigo = 0)
--         AND    plazodesde     <= @nnPlazoProdPla
--         AND    plazohasta     >= @nnPlazoProdPla
            SET ROWCOUNT 0
/*
         IF @nplazodesde = null
         BEGIN
            EXECUTE Sp_Lineas_Actualiza
            RETURN
         END

         IF @nplazohasta = null
         BEGIN
            EXECUTE Sp_Lineas_Actualiza
            RETURN
         END
*/

         SET @nDisponible = @nDisponible - @nMontoLinSis 
         IF @nDisponible < 0
            Begin
               SET @nExceso = @nDisponible * (-1)
               SET @nDisponible = 0
            end 
         ELSE            
            SET @nExceso = 0

         UPDATE  LINEA_PRODUCTO_POR_PLAZO   
         SET     totalocupado 	 = @nMontoLinSis ,                   -- totalocupado    + @nMontoLinSis,
                 totaldisponible = @nDisponible ,   
                 TotalExceso     = @nExceso
         WHERE   rut_cliente	 = @nRutcli				
         AND     codigo_cliente	 = @nCodigo				
         AND     id_sistema	 = @Id_SistemaNetting     -- @cSistema   PRD8800			
         AND     codigo_producto = @Id_SistemaNetting -- @cProducto	 PRD8800 			
         AND     (incodigo	 = @incodigo)

          IF @nExceso <> 0
             SELECT  @cMensaje = 'Limite Plazo desde ' + RTRIM(LTRIM((CONVERT(CHAR(06),@nplazodesde)))) + ' Hasta ' +  RTRIM(LTRIM((CONVERT(CHAR(06),@nplazohasta)))) 
                              + ' Exedido Para ' + @cNombre, @cError   = 'S'    , @nExceso  = @nExceso 
          ELSE
             SELECT @cMensaje = '', @cError  = 'N', @nExceso  = 0


     SET @nCorrDet  = @nCorrDet + 1

         INSERT INTO LINEA_TRANSACCION_DETALLE
         (   NumeroOperacion	,
             NumeroDocumento	,
             NumeroCorrelativo	,
             NumeroCorre_Detalle,
             Rut_Cliente	,
             Codigo_Cliente	,
             Id_Sistema		,
             Codigo_Producto	,
             Tipo_Detalle	,
             Tipo_Movimiento	,
             Linea_Transsaccion	,
             MontoTransaccion	,
             MontoExceso	,
             PlazoDesde		,
             PlazoHasta		,
             Actualizo_Linea	,
             Error		,
             Mensaje_Error	,
             instrumento	,
             moneda		,
             forma_pago 
         )
         SELECT @nNumoper	,
                @nNumdocu	,
                @nCorrela	,
                @nCorrDet	,
                @nRutcli	,
                @nCodigo	,
                @cSistema	,
                @cProducto	,
                @cTipoLinea	,
                @cTipoMov	,
                'LINPZO'	,
                @nMontoLinSis   ,
                @nExceso	,
                ISNULL(@nPlazoDesde,0)  , -- VB +- 14/01/2010
                ISNULL(@nPlazoDesde,0)	, -- VB +- 14/01/2010
                'S'		,
                @cError		,
                @cMensaje	,
                0               ,
                @cMonedaOp	,
                @formapago
      END
  

      --*************************************
      --***************
      --*************** LINEA GENERAL
      --***************
      --*************************************

   
   IF @cBloqueado = 'S' 
   BEGIN --** Linea General Bloqueada para operar **--
     SELECT @cMensaje = 'Linea General Bloqueada Para ' + @cNombre  
         ,  @cError   = 'S'	
         ,  @nExceso  = 0 	
		 ,  @nCorrDet = @nCorrDet + 1

         INSERT INTO LINEA_TRANSACCION_DETALLE
         (      NumeroOperacion		
         ,      NumeroDocumento		
         ,      NumeroCorrelativo	
         ,      NumeroCorre_Detalle	
         ,      Rut_Cliente		
         ,      Codigo_Cliente		
         ,      Id_Sistema		
        ,      Codigo_Producto		
         ,      Tipo_Detalle		
         ,      Tipo_Movimiento		
         ,      Linea_Transsaccion	
         ,      MontoTransaccion	
         ,      MontoExceso		
         ,      PlazoDesde		
         ,      PlazoHasta		
         ,      Actualizo_Linea		
         ,      Error			
         ,      Mensaje_Error		
         ,      instrumento		
         ,      moneda			
         ,      forma_pago 
         )
         SELECT	@nNumoper	
         ,	@nNumdocu      	
         ,	@nCorrela	
         ,	@nCorrDet	
         ,	@nRutcli   	
         ,	@nCodigo   	
         ,	@cSistema 	
         ,	@cProducto     	
         ,	@cTipoControl  	
         ,	@cTipoMov      	
         ,	'LINGEN'      	
         ,	@nMontoLinGen	
         ,	@nExceso   	
         ,	0         	
         ,	0         	
         ,	'S'        	
         ,	@cError		
         ,	@cMensaje	
         ,	0               
         ,	@cMonedaOp	
         ,	@formapago
      END

      IF @dFecPro > @dFecvctolineaGen
      BEGIN
         SELECT  @cMensaje = 'Linea General Vencida Para ' + @cNombre,
                 @cError   = 'S',
                 @nExceso  = 0,
                 @nCorrDet = @nCorrDet + 1

         INSERT INTO LINEA_TRANSACCION_DETALLE
         (   NumeroOperacion	,
             NumeroDocumento	,
             NumeroCorrelativo	,
             NumeroCorre_Detalle,
             Rut_Cliente	,
             Codigo_Cliente	,
             Id_Sistema		,
             Codigo_Producto	,
             Tipo_Detalle	,
             Tipo_Movimiento	,
             Linea_Transsaccion	,
             MontoTransaccion	,
             MontoExceso	,
             PlazoDesde		,
             PlazoHasta		,
             Actualizo_Linea	,
             Error   		,
             Mensaje_Error	,
             instrumento	,
             moneda		,
             forma_pago 
         )
         SELECT	@nNumoper	,
                @nNumdocu	,
                @nCorrela	,
                @nCorrDet	,
                @nRutcli	,
                @nCodigo      	,
                @cSistema	,
                @cProducto	,
                @cTipoControl	,
                @cTipoMov	,
                'LINGEN'	,
                @nMontoLinGen	,
                @nExceso	,
                0		,
                0		,
                'S'		,
                @cError		,
                @cMensaje	,
                0               ,
                @cMonedaOp	,
                @formapago
    END

      ---------------------------------------------------
      Set @TotalOcupado = 0
      SELECT @TotalOcupado   = isnull( SUM(TotalOcupado * isnull( VMC.Tipo_Cambio, 1 ) ), 0 ) 
      FROM LINEA_SISTEMA  LinSis
         left Join  BacTraderSuda..Mdac Con ON 1=1
         left Join  BacParamSuda..Valor_Moneda_Contable VMC ON VMC.Fecha = Con.acfecante 
                                                        and VMC.Codigo_Moneda = case when LinSis.Moneda = 13 then 994 else LinSis.Moneda end 

	  WHERE  rut_cliente     = @nRutcli
	  AND    codigo_cliente  = @nCodigo      
      AND    Id_Sistema  IN (SELECT DISTINCT Id_Grupo FROM BACLINEAS..TBL_AGRPROD where Id_Sistema = Id_Grupo ) 

      /* Para activas seguimiento de variables  
      insert into DEBUG_VALORES -- truncate table DEBUG_VALORES  -- select * from DEBUG_VALORES
      select  Variable01 = '@TotalOcupado'
      	  , Valor01 = @TotalOcupado
      	  , Variable02 = '@nMontoLinGen'
      	  , Valor02    = @nMontoLinGen
      */ 

      -- Conversión a CLP
      -- MAP: Conversion del Monto que viene en CLP
      Set @nMontoLinGen = round( ( @nMontoLinGen / @FactorCnvLinGen ) * 1.000000000 
                                 , case when @FactorCnvLinGen = 1 then 0 else 4 end )    

      Set @TotalOcupado = round( ( @TotalOcupado / @FactorCnvLinGen ) * 1.0000000
                                 , case when @FactorCnvLinGen = 1 then 0 else 4 end )    

      Set @TotalOcupado = @TotalOcupado + @nMontoLinGen
  
      Set @nDisponibleLinGen = @nDisponibleLinGen - @TotalOcupado

      IF @nDisponibleLinGen < 0   begin
         SET @nExceso = @nDisponibleLinGen * (-1)  -- @nMontoLinGen * (-1)
         SET @nDisponibleLinGen = 0
      end
      ELSE   
         SET @nExceso = 0
   
      UPDATE LINEA_GENERAL
      SET    totalocupado    = ISNULL(@TotalOcupado,0) ,                 -- totalocupado    + @nMontoLinGen,
             totaldisponible = @nDisponibleLinGen ,
             TotalExceso     = @nExceso
      WHERE  rut_cliente     = @nRutcli
     AND    codigo_cliente  = @nCodigo  
      
   --------------------------------------------------------

      IF @nExceso <> 0
         SELECT @cMensaje = 'Limite General Excedido Para ' + @cNombre ,
                @cError   = 'S'      ,
		@nExceso  = @nExceso 
      ELSE
         SELECT @cMensaje = '' 	,
                @cError   = 'N'	,
		@nExceso  = 0

      SET @nCorrDet = @nCorrDet + 1

      INSERT INTO LINEA_TRANSACCION_DETALLE
      (     NumeroOperacion	,
            NumeroDocumento	,
            NumeroCorrelativo	,
            NumeroCorre_Detalle	,
            Rut_Cliente		,
            Codigo_Cliente	,
            Id_Sistema		,
            Codigo_Producto	,
            Tipo_Detalle	,
            Tipo_Movimiento	,
            Linea_Transsaccion	,
            MontoTransaccion	,
            MontoExceso		,
            PlazoDesde		,
            PlazoHasta		,
            Actualizo_Linea	,
            Error   		,
            Mensaje_Error	,
            instrumento		,
            moneda		,
            forma_pago 
      )
      SELECT @nNumoper	,
             @nNumdocu	,
             @nCorrela	,
             @nCorrDet	,
             @nRutcli	,
             @nCodigo	,
             @cSistema	,
             @cProducto	,
             @cTipoLinea,
             @cTipoMov	,
             'LINGEN'	,
             @nMontoLinGen ,   
             @nExceso	,
             0		,
             0         	,
             'S'	,
             @cError	,
             @cMensaje	,
             0          ,
             @cMonedaOp	,
             @formapago	

      -- EXECUTE Sp_Lineas_Actualiza  

   SET NOCOUNT OFF

END
GO
