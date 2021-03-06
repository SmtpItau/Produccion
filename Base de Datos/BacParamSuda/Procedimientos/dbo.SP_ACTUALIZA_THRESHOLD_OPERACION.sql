USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_THRESHOLD_OPERACION]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACTUALIZA_THRESHOLD_OPERACION]
   (   @Sistema       		CHAR(3)
   ,   @CodProducto	  	    VARCHAR(5)
   ,   @Numero_Operacion  	NUMERIC(9)
   ,   @ValorAplicado  		FLOAT--NUMERIC(14,4)
   ,   @MensajeLineas       VARCHAR(150) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso    DATETIME
       SET @dFechaProceso    = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   DECLARE @oThreshold       CHAR(1)

     --> Para determinar si la operación fue generada en Chile o en NY --
	DECLARE @EsOperacionNY as varchar(2)
	set @EsOperacionNY = 'No'
	IF exists (select 1 from BacSwapNY..cartera where numero_operacion = @Numero_Operacion)
				set @EsOperacionNY = 'Si'

	IF exists (select 1 from BacFWDNY..cartera where canumoper = @Numero_Operacion)
				set @EsOperacionNY = 'Si'


	IF @EsOperacionNY = 'No'
		begin

			   IF @Sistema = 'BFW'
				  SET @oThreshold       = (SELECT Threshold FROM BacFwdSuda.dbo.MFCA with(nolock) WHERE canumoper = @Numero_Operacion)
			   ELSE
				  SET @oThreshold       = (SELECT DISTINCT Threshold FROM BacSwapSuda.dbo.CARTERA with(nolock) WHERE numero_operacion = @Numero_Operacion)

	END

	IF @EsOperacionNY = 'Si'
		begin

			   IF @Sistema = 'BFW'
				  SET @oThreshold       = (SELECT Threshold FROM BacFWDNY.dbo.MFCA with(nolock) WHERE canumoper = @Numero_Operacion)
			   ELSE
				  SET @oThreshold       = (SELECT DISTINCT Threshold FROM BacSwapNY.dbo.CARTERA with(nolock) WHERE numero_operacion = @Numero_Operacion)

	END



   UPDATE BacParamsuda.dbo.TBL_THRESHOLD_OPERACION
   SET    Threshold_Aplicado = @ValorAplicado
   WHERE  Sistema            = @Sistema
   AND    Producto           = @CodProducto
   AND    Numero_Operacion   = @Numero_Operacion

   DECLARE @nRec            NUMERIC(21,4)
   DECLARE @nPropuesto      NUMERIC(21,4)

   SELECT  @nRec            = isnull(Rec, 0.0)
   ,       @nPropuesto      = isnull(Threshold_Propuesto, 0.0)
   FROM    BacParamsuda.dbo.TBL_THRESHOLD_OPERACION with(nolock)
   WHERE   sistema          = @Sistema
   AND     numero_operacion = @Numero_Operacion


   DECLARE @MensajeMontos   VARCHAR(250)
       SET @MensajeMontos   = ltrim(rtrim( @MensajeLineas ))
                            + ' REC : '    + ltrim(rtrim( round(@nRec, 0) ))
   IF @oThreshold = 'S'
       SET @MensajeMontos   = @MensajeMontos
                            + ', PROP. : ' + ltrim(rtrim( round(@nPropuesto, 0) )) 

   IF CHARINDEX('exenta', @MensajeLineas) = 0
       SET @MensajeMontos   = @MensajeMontos
                            + ', THRESHOL : ' + ltrim(rtrim( round(@ValorAplicado, 0) )) 
   DECLARE @IdMensaje      INTEGER
       SET @IdMensaje      = ISNULL((SELECT ISNULL(MAX(Id_Mensaje), -1)
                                       FROM BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD
                                      WHERE Id_Sistema   = @Sistema
                                        AND Num_Contrato = @Numero_Operacion), -1)

   IF @IdMensaje = -1
   BEGIN
      SET @IdMensaje = 1
      INSERT INTO BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD
      SELECT @Sistema, @CodProducto, @Numero_Operacion, 1, @MensajeMontos, @dFechaProceso, 'N'

      RETURN      
   END ELSE
   BEGIN
      UPDATE BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD
         SET Mensaje      = @MensajeMontos
       WHERE Id_Sistema   = @Sistema
         AND Num_Contrato = @Numero_Operacion
         AND Id_Mensaje   = @IdMensaje

      /*
      SET @IdMensaje = @IdMensaje + 1 

      INSERT INTO BacParamSuda.dbo.TBL_MENSAJES_OPERACION_THRESHOLD
      SELECT @Sistema, @CodProducto, @Numero_Operacion, @IdMensaje, @MensajeMontos, @dFechaProceso, 'N'
      */

      RETURN
   END

   SELECT 0, 'OK'

END

GO
