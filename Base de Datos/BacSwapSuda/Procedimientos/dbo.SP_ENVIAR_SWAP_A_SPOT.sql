USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIAR_SWAP_A_SPOT]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ENVIAR_SWAP_A_SPOT]
  (   @NumOpe   NUMERIC(8)   )  
AS   
BEGIN  
  
  SET NOCOUNT ON  
  
   DECLARE @moentidad numeric(10)   ,  
           @monumope  numeric( 7)  ,  
           @motipmer  char (4)  ,  
           @motipope  char (1)  ,  
           @morutcli  numeric( 9)  ,  
           @mocodcli  numeric( 9)  ,  
           @monomcli  char(35)  ,  
           @mocodmon  char (3)  ,  
           @mocodcnv  char (3)  ,  
           @momonmo   numeric(19,4) ,  
           @moticam   numeric(19,4) ,  
           @moparme   numeric(19,8) ,  
           @moprecio  numeric(19,4) ,  
           @moussme   numeric(19,4) ,  
           @momonpe   numeric(19,4) ,  
           @moentre   numeric( 3)  ,  
           @morecib   numeric( 3)  ,  
           @movaluta1 datetime  ,     -- Entregamos  
           @movaluta2 datetime  ,     -- Recibimos  
           @mooper    char (15)  ,    
           @mofech    datetime  ,  
           @mohora    char ( 8)  ,  
           @moterm    char (12)  ,  
           @motipcar  numeric( 3)  ,  
           @monumfut  numeric( 8)  ,  
           @mofecini  datetime     ,  
           @fecha     char (8)     ,
           @TipCli            NUMERIC(01) ,
           @dFechaAnterior DATETIME ,   
           @dFechaProceso  DATETIME ,
           @dFechaProxima DATETIME 
  
   --------------------------<< Valida existencia de Swap


  SELECT     @dFechaAnterior   = fechaant  
       ,     @dFechaProceso    = fechaproc  
       ,     @dFechaProxima    = fechaprox
  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock)  


   SET @fecha = (SELECT CONVERT(CHAR(8),FechaLiq,112) FROM FLUJOS_VCTOS_SPOT with (nolock) WHERE FechaProceso = @dFechaProceso AND NumeroOperacion = @NumOpe )  

  
   IF @fecha IS NULL  
   BEGIN  
      SET NOCOUNT OFF  
      RETURN -1  
   END  
 


   --------------------------<< Valida Fecha SPOT v/s solicitud FORWARD  -- se debe sacar comentario
/*
   IF NOT (@fecha = (SELECT acfecpro FROM baccamsuda..meac with (nolock) )  
       OR  @fecha = (SELECT acfecprx FROM baccamsuda..meac with (nolock) ))  
   BEGIN            
      SET NOCOUNT OFF    
      RETURN -2  
  
   END  
*/
  
   /*********************************************************************************/  
   --BEGIN TRANSACTION  
   --------------------------<< Transfiere Flujos Swap a tbVencimientosForward  
  
   SET @moentidad = (SELECT accodigo FROM baccamsuda..meac with (nolock) )  
  
   --------------------------<< Operacion Swap
/*
   SELECT @moticam  = CASE WHEN venta_moneda = 999             THEN 0  
                           WHEN venta_moneda = 998 THEN CONVERT(NUMERIC(19,4), ROUND( ROUND( ((venta_amortiza + venta_interes) * vmvalor), 0 ) / (compra_amortiza + compra_interes), 4) ) --> ((camtomon2 * vmvalor) / camtomon1)                           



                           ELSE D.vmvalor   
                      END      
   FROM   CARTERA                       with (nolock)  
          LEFT JOIN VIEW_VALOR_MONEDA D with (nolock) ON D.vmfecha = FechaLiquidacion AND D.vmcodigo = 994 --> CASE WHEN cacodpos1 = 2 THEN 994 ELSE 998 END  
          LEFT JOIN VIEW_VALOR_MONEDA U with (nolock) ON U.vmfecha = FechaLiquidacion AND U.vmcodigo = 998 --> CASE WHEN cacodpos1 = 2 THEN 994 ELSE 998 END  
   WHERE  numero_operacion  = @NumOpe  
     and  tipo_flujo = 2 
  


   SELECT @moprecio = CASE WHEN venta_moneda = 999             THEN 0  
                           WHEN venta_moneda = 998 THEN CONVERT(NUMERIC(19,4), ROUND( ROUND( ((venta_amortiza + venta_interes) * vmvalor), 0 ) / (compra_amortiza + compra_interes), 4) ) --> ((camtomon2 * vmvalor) / camtomon1)                           



                           ELSE D.vmvalor   
                      END   
   FROM  CARTERA     with (nolock)  
          LEFT JOIN VIEW_VALOR_MONEDA with (nolock) ON vmfecha = FechaLiquidacion AND vmcodigo = 998  
   WHERE  numero_operacion  = @NumOpe  
     and  tipo_flujo = 2 
  
*/  
 -------->> tipo de mercado   
    SET @TipCli   = (SELECT cltipcli FROM VIEW_CLIENTE with (nolock) WHERE clrut = @morutcli AND clcodigo = @mocodcli)             
    -- Criterio aplicado nuevamente al cargar operación  en BacCambio(SP_CAPTURAFORWARD)

  
   SELECT @motipcar  = TipoSwap ,
          @motipope  = TipoOperacion,  
          @monumfut  = NumeroOperacion, 
          @mofecini  = FechaInicio,  
          @motipmer  = CASE WHEN (@TipCli > 0 AND @TipCli < 4) AND @mocodmon <> 'USD' THEN 'ARBI'  
                            WHEN (@TipCli > 0 AND @TipCli < 4) AND @mocodmon  = 'USD' THEN 'PTAS'  
                              ELSE                                                         'EMPR' -- corredoras tipcli = 4  
                       END ,  
          @morutcli  = RutCliente,  
          @mocodcli  = CodCliente,  
          @mocodmon  = CONVERT(CHAR(3),Moneda),  
          @mocodcnv  = CONVERT(CHAR(3),MonedaCNV), 
          @momonmo   = (Monto) ,  
          @moparme   = Paridad ,
          @moussme   = Monto * Paridad , 
          @momonpe   = MontoCNV , 
          @moticam   = TipoCambio,
          @moprecio  = TipoCambio,                     
          @moentre   = ForPagEntre ,  
          @morecib   = ForPagRecib,   
          @movaluta1 = FechaLiq,  
          @movaluta2 = FechaLiq,  
          @mooper    = Operador,  
          @mofech    = CONVERT(CHAR(8),@fecha,112),  
          @mohora    = CONVERT(CHAR(8),getdate(),108),  
          @moterm    = 'SWAP'  
     FROM FLUJOS_VCTOS_SPOT   with (nolock)  
    WHERE NumeroOperacion  =  @NumOpe   

-- SELECT  *  FROM  FLUJOS_VCTOS_SPOT 
  

   --------------------------<< Valutas para Formas de Pago  
   DECLARE @feriado   INTEGER  
  
   DECLARE @diasvalor INTEGER  
       SET @diasvalor = (SELECT diasvalor FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = @moentre )  
  
    
   WHILE (@diasvalor > 0)  ------------------ Valuta Entregamos  
   BEGIN  
      SET @movaluta1 = DATEADD(DAY, 1, @movaluta1)  
      EXECUTE BacFwdSuda.dbo.SP_FERIADO @movaluta1, 6, @feriado OUTPUT    
  
      IF @feriado = 0  
         SET @diasvalor = @diasvalor -1  
   END  
  
   SET @diasvalor = (SELECT diasvalor FROM VIEW_FORMA_DE_PAGO with (nolock) WHERE codigo = @morecib )  
  
   WHILE (@diasvalor > 0)  ------------------ Valuta Recibimos  
   BEGIN  
      SET @movaluta2 = DATEADD(DAY, 1, @movaluta2)  
      EXECUTE BacFwdSuda.dbo.SP_FERIADO @movaluta2, 6, @feriado OUTPUT    
  
      IF @feriado = 0  
         SET @diasvalor = @diasvalor -1  
   END  
  
   --------------------------<< Monedas  
   SET @mocodmon = (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = CONVERT(NUMERIC(3),@mocodmon) )  
   SET @mocodcnv = (SELECT mnnemo FROM VIEW_MONEDA with (nolock) WHERE mncodmon = CONVERT(NUMERIC(3),@mocodcnv) )  
   
  
   --------------------------<< Atualización Valutas en tabla FLUJOS_VCTOS_SPOT 
   UPDATE FLUJOS_VCTOS_SPOT 
   SET   FechaValuta1 = @movaluta1
      ,  FechaValuta2 = @movaluta2
   WHERE NumeroOperacion  =  @NumOpe   
  

   --------------------------<< Agregando a tbVencimientosSwap
   IF EXISTS (SELECT monumfut FROM BacCamSuda..TBVENCIMIENTOSFORWARD with (nolock) WHERE monumfut = @NumOpe)  
      DELETE FROM BacCamSuda..TBVENCIMIENTOSFORWARD  
            WHERE monumfut = @NumOpe  

   
 
   INSERT INTO BacCamSuda..TBVENCIMIENTOSFORWARD  
   VALUES ( @moentidad ,  
            @motipmer  ,  
            @motipope  ,  
            @morutcli  ,  
            @mocodcli  ,  
            @mocodmon  ,  
            @mocodcnv  ,  
            @momonmo   ,  
            @moticam   ,  
            @moparme   ,  
            @moprecio  ,  
   @moussme   ,  
            @momonpe   ,  
            @moentre   ,  
            @morecib   ,  
            @movaluta1 ,     -- Entregamos  
            @movaluta2 ,     -- Recibimos  
            @mooper    ,  
            @mofech    ,  
            @mohora    ,  
            @moterm    ,  
            @motipcar  ,  
            @monumfut  ,  
            @mofecini  
         )  


            UPDATE FLUJOS_VCTOS_SPOT 
	        SET   Estado = 1
               ,  EstadoEnvio = 1
		    WHERE NumeroOperacion  =  @NumOpe   
            AND   FechaProceso     =  @dFechaProceso
     
        IF  @@ROWCOUNT <> 0
        BEGIN
            SELECT 'SI',@NumOpe
            RETURN 0
        END
        ELSE 
        BEGIN 
            SELECT 'NO',@NumOpe
            RETURN -3
        END


END  
GO
