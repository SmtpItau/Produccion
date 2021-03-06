USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SOLICITUD_SDA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_CON_SOLICITUD_SDA]
     (
       @CliRut              NUMERIC(10)
     , @CliCodigo           NUMERIC(1)
     , @TipoContrato        VARCHAR(12)
     )
AS
BEGIN

    SET NOCOUNT ON             
     
    DECLARE @Nombre         CHAR(120)
          , @Dv             CHAR(1)
          , @FechaProceso   DATETIME
       
		 SELECT	'Objeto'                = CONVERT( VARCHAR(40) ,'CONSULTA MOVIMIENTOS' )
         ,		'NumContrato'           = CONVERT( NUMERIC(8)  , NUM_CONTRATO ) 
         ,		'TipoTransaccion'       = CONVERT( VARCHAR(10) , TRANSACCION )
		 ,		'NumFolio'              = CONVERT( NUMERIC(8)  , NUM_SOLICITUD )
         ,		'FechaContrato'         = CONVERT( DATETIME    , FECHA_INGRESO ,112)
         ,		'ConOpcEstCod'          = CONVERT( VARCHAR(1)  , ESTADO_SOLICITUD )
         ,		'ConOpcEstDsc'          = CONVERT( VARCHAR(30) , case when ESTADO_SOLICITUD = 'V'THEN 'VIGENTE' when ESTADO_SOLICITUD = 'P'THEN 'PREPARADA'
          		                                                      when ESTADO_SOLICITUD = 'A'THEN 'ANULADA' when ESTADO_SOLICITUD = 'E'THEN 'EJERCIDA'END )
         ,		'CliRut'                = CONVERT( NUMERIC(13) , ISNULL(CaEnc.CaRutCliente,0) )
         ,		'CliCod'                = CONVERT( NUMERIC(5)  , ISNULL(CaEnc.CaCodigo,0) )
         ,		'CliDv'                 = CONVERT( VARCHAR(1)  , ISNULL((SELECT Cldv FROM lnkbac.bacparamsuda.dbo.cliente WHERE Clrut = CaEnc.CaRutCliente AND  Clcodigo = CaEnc.CaCodigo), ' '   )  )
         ,		'CliNom'                = CONVERT( VARCHAR(100), ISNULL((SELECT Clnombre  FROM lnkbac.bacparamsuda.dbo.cliente WHERE Clrut = CaEnc.CaRutCliente AND  Clcodigo = CaEnc.CaCodigo), 'Cliente no existe Crear en BAC'  )    )
         ,		'Operador'              = CONVERT( VARCHAR(15) , CaOperador )
         ,		'OpcEstCod'             = CONVERT( VARCHAR(2)  , ISNULL(CacodEstructura, 'Estructura no Existe'  ))
         ,		'OpcEstDsc'             = CONVERT( VARCHAR(20) , ISNULL((SELECT OpcEstDsc FROM OpcionEstructura WHERE CacodEstructura = OpcEstCod), 'Estructura no Existe'))  
         ,		'Contrapartida'         = CONVERT( VARCHAR(8)  , 'INTERNA ' )
         ,		'FechaCreacionRegistro' = CONVERT( DATETIME    , FECHA_ACTIVACION,112)
         ,		'Impreso'               = CONVERT( VARCHAR(1)  , 'N')
         INTO	#Encabezado
         FROM	TBL_SOLICITUD_SDA
				INNER JOIN CaEncContrato CaEnc ON CaEnc.CaNumContrato = NUM_CONTRATO

    IF EXISTS( SELECT (1) FROM #ENCABEZADO )
    BEGIN
         SELECT *
         FROM #encabezado
         WHERE	(CliRut	= @CliRut	OR @CliRut	= 0)
         AND	(CliCod	= @CliCodigo	OR @CliCodigo	= 0)
         ORDER BY NumContrato
              , NumFolio

    END ELSE
    BEGIN
        SELECT 'Objeto'                = CONVERT( VARCHAR(40) , 'CONSULTA MOVIMIENTOS SIN DATOS' )
             , 'NumContrato'           = CONVERT( NUMERIC(8)  , 0 ) 
             , 'TipoTransaccion'       = CONVERT( VARCHAR(10) , '' )
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
