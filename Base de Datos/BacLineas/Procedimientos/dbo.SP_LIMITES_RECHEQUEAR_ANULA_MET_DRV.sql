USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_RECHEQUEAR_ANULA_MET_DRV]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LIMITES_RECHEQUEAR_ANULA_MET_DRV]
   (	@dFecPro     DATETIME
   ,	@cSistema    CHAR(03)
   ,	@nNumoper    NUMERIC(10,0) 
   )
AS
BEGIN


   SET NOCOUNT ON


   

   DECLARE @Contador  INTEGER
   DECLARE @sw        CHAR(1)

   DECLARE @ctranssaccion  	   CHAR(15)
   DECLARE @ctipo_detalle  	   CHAR(1)
   DECLARE @cactualizo_linea 	   CHAR(1)
   DECLARE @nmontotransaccion 	   NUMERIC(19,4)
   DECLARE @ctipo_movimiento 	   CHAR(1)
   DECLARE @nrutcli  		   NUMERIC(09,0)
   DECLARE @ncodigo  		   NUMERIC(09,0)
   DECLARE @nplazodesde  	   NUMERIC(09,0)
   DECLARE @nplazohasta  	   NUMERIC(09,0)
   DECLARE @csistematras  	   CHAR(03)
   DECLARE @nmonto   		   NUMERIC(19,4)
   DECLARE @dfecvctop  		   DATETIME
   DECLARE @ccontrolaplazo  	   CHAR(01)
   DECLARE @nRutcasamatriz  	   NUMERIC(09,0)
   DECLARE @nCodigocasamatriz 	   NUMERIC(09,0)
   DECLARE @cProducto  		   CHAR(05)
   DECLARE @nMontoSpo  		   NUMERIC(19,4)
   DECLARE @nMontoFwd  		   NUMERIC(19,4)
   DECLARE @nPlazo   		   NUMERIC(10)
   DECLARE @nCodigo_pais	   NUMERIC(05)
   DECLARE @instrumento 	   NUMERIC(03)
   DECLARE @moneda  		   NUMERIC(05)
   DECLARE @forma_pago 		   NUMERIC(03)
   DECLARE @Codigo_Producto	   CHAR(05)
   DECLARE @Grupo_Emisor	   CHAR(05)
   DECLARE @cOperador 		   CHAR(10)
   DECLARE @nMonto_Operador	   NUMERIC(19,4) 
   DECLARE @cOperador_Autoriza	   CHAR(10)
   DECLARE @nMonto_Autoriza	   NUMERIC(19,4)
   DECLARE @Codigo_Producto_Aux    CHAR(05)
   DECLARE @nMtoGrp 		   NUMERIC(19,4)
   DECLARE @nCorrela		   NUMERIC(4)
   DECLARE @firma1 		   CHAR(15)
   DECLARE @Codigo_Producto_Icap   CHAR(05)

   DECLARE @Imputo                 CHAR(01)

   SELECT @cOperador 		    = Operador_Origen
   ,      @nMonto_Operador	    = Monto_Operador
   ,      @cOperador_Autoriza	= Operador_Autoriza
   ,      @nMonto_Autoriza	    = Monto_Operacion
   ,      @firma1               = Firma1     
   FROM   DETALLE_APROBACIONES                                     --- select * from DETALLE_APROBACIONES where Numero_Operacion = 38273
   WHERE Id_Sistema            = case when @cSistema = 'BEX' then 'BTR' else @cSistema  end -- 15 Oct. 2009 
   -- MAP 21 Oct. 2011 va a quedar la crema cuando grabe en los dos sistemas
   -- no se corregira nada en este ambito por haber otro tema relacionado en 
   -- certificación: Oct. 2011
   AND   Numero_Operacion      = @nNumoper -- va aser necesairo el nùmero de la operacion.


   SELECT @Codigo_Producto = Codigo_Grupo
   FROM   GRUPO_PRODUCTO
   WHERE  Id_Sistema       = @cSistema
 

   IF NOT EXISTS(SELECT 1 FROM LINEA_AUTORIZACION WHERE Id_Sistema  = @cSistema AND NumeroOperacion= @nNumoper AND FechaAutorizo = @dFecPro And codigo_excepcion = 'R')  
   BEGIN

      -- 10967 Se corrige la des-imputacion de límites
      IF @cSistema = 'BEX'
      BEGIN
         SET @Codigo_Producto = '03'
      END

      IF @cSistema = 'PCS'
      BEGIN 
         SET @Codigo_Producto = (SELECT Max( Codigo_Grupo ) FROM GRUPO_PRODUCTO with (nolock) WHERE Id_Sistema = @cSistema )
      END

      IF @cSistema = 'BFW' AND (@cProducto = '10' OR @cProducto = '12' OR @cProducto = '13' OR @cProducto = '11')
      BEGIN 
         SET @Codigo_Producto = (SELECT Max( Codigo_Grupo ) FROM GRUPO_PRODUCTO with (nolock) WHERE Id_Sistema = @cSistema )
      END 
      -- 10967 Se corrige la des-imputacion de límites


      UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO 
      SET    Acumulado_Diario  = Acumulado_Diario - @nMonto_Autoriza
      WHERE  Usuario           = @firma1	
      AND    Codigo_Producto   = @Codigo_Producto
   END

   DELETE LINEA_TRANSACCION
   WHERE  Id_Sistema      = @cSistema
   AND    NumeroOperacion = @nNumoper

   DELETE LIMITE_TRANSACCION
   WHERE  Id_Sistema      = @cSistema 
   AND    NumeroOperacion = @nNumoper 
   AND    FechaOperacion  = @dFecPro 

   
END
GO
