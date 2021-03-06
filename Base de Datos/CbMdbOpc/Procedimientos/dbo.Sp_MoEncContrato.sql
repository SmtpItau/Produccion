USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MoEncContrato]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[Sp_MoEncContrato]

     (
       @CliRut              NUMERIC(10)
     , @CliCodigo           NUMERIC(1)
     , @TipoContrato        VARCHAR(8)
	 , @Anticipo			VARCHAR(1) = 'N' --> PRD-20559 PARA MODULO SGRU
     )
AS
BEGIN

    SET NOCOUNT ON             
     
    DECLARE @Nombre         CHAR(120)
          , @Dv             CHAR(1)
          , @FechaProceso   DATETIME

    -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente  
    -- Sp_MoEncContrato 0,0, ''

       
    SELECT *
      INTO #Moneda
      FROM bacparamsuda.dbo.Moneda

     -- Reducir el contenido de la tabla Cliente
    SELECT *
      INTO #Cliente
      FROM  bacparamsuda.dbo.View_ClienteParaOpc  
     WHERE ( @CliRut  = 0 AND ClRut IN ( SELECT MoRutCliente FROM MoEncContrato )  )
        OR ( @CliRut <> 0 AND ClRut  = @CliRut AND @CliCodigo IN ( ClCodigo, 0 ) )

     -- Validar si existe el cliente que viene del parámetro
    SET @Nombre = ''

    IF @CliRut <> 0
    BEGIN
        SET @Nombre = 'Cliente no existe, crear en BAC'

    END

    SELECT @Nombre     = ClNOmbre
      FROM #Cliente
     WHERE @CliRut    <> 0
       AND ClRut       = @CliRut
       AND @CliCodigo IN ( ClCodigo, 0 )

    SELECT 'Objeto'                = CONVERT( VARCHAR(40) , 'CONSULTA MOVIMIENTOS' )
         , 'NumContrato'           = CONVERT( NUMERIC(8)  , Movimiento.MoNumContrato ) 
         , 'TipoTransaccion'       = CONVERT( VARCHAR(10) , Movimiento.MoTipoTransaccion )
         , 'NumFolio'              = CONVERT( NUMERIC(8)  , Movimiento.MoNumFolio )
         , 'FechaContrato'         = CONVERT( DATETIME    , Movimiento.MoFechaContrato,112)
         , 'ConOpcEstCod'          = CONVERT( VARCHAR(1)  , Movimiento.MoEstado )
         , 'ConOpcEstDsc'          = CONVERT( VARCHAR(30) , ISNULL( Estado.ConOpcEstDsc,  'Estado no Existe' ) )
         , 'CliRut'                = CONVERT( NUMERIC(13) , Movimiento.MoRutCliente )
         , 'CliCod'                = CONVERT( NUMERIC(5)  , Movimiento.MoCodigo )
         , 'CliDv'                 = CONVERT( VARCHAR(1)  , ISNULL( Cliente.ClDv, ' '   ) )
         , 'CliNom'                = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )
         , 'Operador'              = CONVERT( VARCHAR(15) , Movimiento.MoOperador )
         , 'OpcEstCod'             = CONVERT( VARCHAR(2)  , Movimiento.MoCodEstructura  )
         , 'OpcEstDsc'             = CONVERT( VARCHAR(20) , ISNULL( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )  
         , 'Contrapartida'         = CONVERT( VARCHAR(8)  , Movimiento.MoTipoContrapartida )
         , 'FechaCreacionRegistro' = CONVERT( DATETIME    , Movimiento.MoFechaCreacionRegistro,112)
         , 'Impreso'               = CONVERT( VARCHAR(1)  , Movimiento.MoImpreso)            
      INTO #Encabezado
      FROM MoEncContrato Movimiento
           LEFT JOIN #Cliente Cliente            ON Movimiento.MoRutCliente = Cliente.ClRut AND Movimiento.MoCodigo = Cliente.ClCodigo
           LEFT JOIN OpcionEstructura Estructura ON Estructura.OpcEstCod    = Movimiento.MoCodEstructura 
           LEFT JOIN ConOpcEstado     Estado     ON Estado.ConOpcEstCod     = Movimiento.MoEstado
    -- Filtros del procedimiento
     WHERE (( @CliRut  = 0 AND ClRut IN ( SELECT MoRutCliente FROM MoEncContrato )  )
        OR ( @CliRut <> 0 AND ClRut = @CliRut AND @CliCodigo IN ( ClCodigo, 0 )))
       AND ( @TipoContrato IN ( Movimiento.MoTipoContrapartida, 'Todos' ) )

    -- select 'Debug', * from #Encabezado

    IF EXISTS( SELECT (1) FROM #ENCABEZADO )
    BEGIN
	    IF @Anticipo <> 'S'
		BEGIN
			SELECT *
			   FROM #encabezado
			  ORDER BY NumContrato
				  , NumFolio
		END ELSE
		BEGIN
			 SELECT *
			   FROM #encabezado WHERE TipoTransaccion IN ('ANTICIPA', 'EJERCE', 'SOLICITUD', 'LEASING')
			  ORDER BY NumContrato
				  , NumFolio
		END

    END ELSE
    BEGIN
        SELECT 'Objeto'                = CONVERT( VARCHAR(40) , 'CONSULTA MOVIMIENTOS SIN DATOS' )
             , 'NumContrato'           = CONVERT( NUMERIC(8)  , 0 ) 
             , 'TipoTransaccion'       = CONVERT( VARCHAR(10) , ' ' )
         , 'NumFolio'              = CONVERT( NUMERIC(8)  , 0 )
             , 'FechaContrato'         = CONVERT( DATETIME    , '19000101' ,112)
             , 'ConOpcEstCod'          = CONVERT( VARCHAR(1)  , ' ' )
             , 'ConOpcEstDsc'          = CONVERT( VARCHAR(30) , ' ' )
             , 'CliRut'                = CONVERT( NUMERIC(13) , 0 )
             , 'CliCod'                = CONVERT( NUMERIC(5)  , 0 )
             , 'CliDv'                 = CONVERT( VARCHAR(1)  ,  ' '    )
             , 'CliNom'                = CONVERT( VARCHAR(100),  ' '    )
             , 'Operador'              = CONVERT( VARCHAR(15) , ' ' )
             , 'OpcEstCod'             = CONVERT( VARCHAR(2)  , '  '  )
             , 'OpcEstDsc'             = CONVERT( VARCHAR(20) , ' ' )  
             , 'Contrapartida'         = CONVERT( VARCHAR(8)  , ' ' )
             , 'FechaCreacionRegistro' = CONVERT( DATETIME    , '19000101 00:00:00',112)
             , 'Impreso'               = CONVERT( VARCHAR(1)  , ' ')

    END
                
END

GO
