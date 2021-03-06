USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEO_AUTOMATICO_CLIENTE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BLOQUEO_AUTOMATICO_CLIENTE]
   (   @nRutCliente          NUMERIC(9)
   ,   @nCodCliente          INTEGER
   ,   @NuevaClasificacion   CHAR(5)   
   )
AS
BEGIN

   SET NOCOUNT ON

   -->     1.0 Determina la Fecha de Proceso
   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = GETDATE() -->(SELECT acfecproc FROM BactraderSuda.dbo.MDAC with(nolock))

   -->     2.0 Lee la clasificacion actual del cliente
   DECLARE @Clasificacion   CHAR(5)
       SET @Clasificacion   = (SELECT clclsbif FROM BacParamSuda.dbo.CLIENTE with(nolock)
                                              WHERE clrut    = @nRutCliente
                                                and clcodigo = @nCodCliente)

   -->     2.1 Lee la Garantia total del cliente
   DECLARE @GarantiaTotal NUMERIC(14)
	SET  @GarantiaTotal  = (SELECT GARANTIATOTAL FROM BacParamSuda.dbo.CLIENTE with(nolock)
		                    WHERE clrut    = @nRutCliente AND clcodigo = @nCodCliente)


   -->     3.0 Segun tabla de Categorias lee los puntero para determina si bajo de categoria al cambiar el valor
   IF @Clasificacion <> @NuevaClasificacion
   BEGIN
      -->     3.1 Lee puntero de la Cladificacion Actual
      DECLARE @PunteroActual   INTEGER
          SET @PunteroActual   = (SELECT tbvalor FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
                                                WHERE tbcateg = 103 and tbcodigo1 = @Clasificacion)

      -->     3.2 Lee puntero de la nueva Cladificacion
      DECLARE @NuevoPuntero    INTEGER
          SET @NuevoPuntero    = (SELECT tbvalor FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
                                                WHERE tbcateg = 103 and tbcodigo1 = @NuevaClasificacion)


      -->     3.3  Suma de los excesos de Threshold
      DECLARE @SumThreshold NUMERIC(14)
	  SET @SumThreshold = (SELECT SUM(Threshold_Aplicado) 
				 FROM BacParamSuda.dbo.TBL_THRESHOLD_OPERACION with(nolock)
				WHERE  Rut_Cliente = @nRutCliente AND Cod_Cliente = @nCodCliente)

      -->     Mide el Tramo del Cuadro de Reduccion de Threshold	
      DECLARE @nControl	    CHAR(1)
	  SET @nControl     = CASE WHEN @NuevoPuntero = 5 OR @NuevoPuntero = 6 THEN 'SI' ELSE 'NO' END --> Validar 2° Tramo (75%)

     -->     3.3 Bloquea al Cliente si baja su categoria ------> 
      IF @NuevoPuntero > @PunteroActual
      BEGIN

         UPDATE BacParamSuda.dbo.CLIENTE 
            SET Bloqueado      = 'S'
            ,   motivo_bloqueo = CASE WHEN @nControl = 'S' AND @SumThreshold > @GarantiaTotal THEN 'Baja en la Clasificación de Riesgo y Garantia Insuficiente'
				      WHEN @NuevaClasificacion = 'SC'	 		      THEN 'Cliente dejo de Clasificar'
				      WHEN @GarantiaTotal> 0 		 		      THEN 'Cliente sin Garantía Suficiente'
				      ELSE 				       			   'Baja en la Clasificación de Riesgo.'
				 END
          WHERE clrut          = @nRutCliente
            AND clcodigo       = @nCodCliente

      END

      -->    4.0  graba un historico de su clasificacion en base a su nuevo valor 
      INSERT INTO dbo.TBLCLASIFICARIESGO
      (   RutCliente
      ,   CodCliente
      ,   Fecha
      ,   Valor
      ) 
      VALUES
      (   @nRutCliente
      ,   @nCodCliente
      ,   @dFechaProceso
      ,   @NuevaClasificacion
      )

   END

END
GO
