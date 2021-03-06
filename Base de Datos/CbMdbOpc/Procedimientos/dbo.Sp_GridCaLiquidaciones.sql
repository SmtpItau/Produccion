USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GridCaLiquidaciones]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_GridCaLiquidaciones]
                 (
                   @Rut      numeric(9)
                 , @Codigo   numeric(1)
                 , @f1       datetime
                 , @f2       datetime
                 , @Estado   varchar(1)  -- 'V': Vigente 'H': Historico 'T' : Tod
                 , @Usuario  varchar(15)
                 )  
AS
BEGIN			

    SET NOCOUNT ON

    DECLARE @HayErrorValidacion numeric(10)
    
    -- En este proceso no habrá validación
    SET @HayErrorValidacion = 0

    SELECT *
      INTO #Moneda
      FROM LNKBAC.bacparamsuda.dbo.Moneda

    SELECT *
      INTO #Formas_Pago
      FROM LNKBAC.bacparamsuda.dbo.Forma_de_Pago 


    -- Solo se cargarán Clientes de opciones
    -- cargados al cierre de mesa
    SELECT ClRut
         , ClCodigo
         , ClDv
         , ClNombre 
      INTO #Cliente
      FROM lnkbac.bacparamsuda.dbo.View_ClienteParaOpc 

    -- Tabla Base de la consulta
    -- Se cargara la cartera a nivel de contrato y despues la fecha en que se hizo el pago
    -- toda liquidacion sera identificada y por ende construida con el numero de contrato y la fecha de pago-ejercicio
    SELECT Estado = ' '
         , *
      INTO #Caja
      FROM CaCaja
     WHERE Canumcontrato = 0

    IF @Estado IN ( 'V', 'T' )
    BEGIN
        INSERT INTO #Caja
               SELECT Estado = 'V'
                    , *
                 FROM CaCaja
                WHERE CaCajFecPago between @f1 and @f2
                 
    END ELSE IF @Estado IN ( 'H', 'T' )
    BEGIN 
        INSERT INTO #Caja
               SELECT Estado = 'H'
                    , *
                 FROM CaVenCaja
                WHERE CaCajFecPago between @f1 and @f2
    END

    SELECT * 
      INTO #Encabezado
      FROM dbo.CaEncContrato 
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )
    UNION
    SELECT *
      FROM dbo.CaVenEncContrato
     WHERE CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )

    SELECT DET.*
      INTO #Detalle
      FROM dbo.CaDetContrato            DET
     WHERE DET.CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )
    UNION
    SELECT DET.*
      FROM CaVenDetContrato                DET
     WHERE DET.CaNumContrato IN ( SELECT CaNumContrato FROM #Caja )

    SELECT Pantalla           = CONVERT(   varchar(40), 'LIQUIDACION' )
         , NumContrato        = CONVERT(   numeric(8), Caja.CaNumContrato )
         , FechaEjercicio     = CONVERT(   datetime,  Caja.CaCajFecPago )
         , FechaContrato      = CONVERT(   datetime,  Enc.CaFechaContrato )
         , CliRut             = CONVERT(   numeric(9), Enc.CaRutCliente )
         , CliDv              = CONVERT(   varchar(1), ISNULL( Cliente.ClDv, ' ' ) )
         , CliCod             = CONVERT(   numeric(5), Enc.CaCodigo )
         , CliNom             = CONVERT(   varchar(100), ISNULL( Cliente.ClNombre, 'Cliente No Existe' )  )
         , Estado             = CONVERT(   varchar(9), CASE 
														 WHEN Caja.Estado = 'V' THEN 'Vigente' 
														 ELSE 'Historico' 
                                                         END )
         , Contrapartida      = CONVERT(   varchar(15), Enc.CaTipoContrapartida ) 
         , Operador           = CONVERT(   varchar(15), Enc.CaOperador )
         , ModalidadCod       = CONVERT(   varchar(1), Det.CaModalidad )
         , ModalidadDsc       = CONVERT(   varchar(15), CASE 
														 WHEN Caja.CaCajOrigen = 'PP' THEN 'N/A' 
                                                         WHEN Det.CaModalidad  = 'C'  THEN 'Compensacion' 
                                                         ELSE 'Entrega Fisica'
                                                         END )
         , OrigenCod          = CONVERT(   varchar(2), Caja.CaCajOrigen )
         , OrigenDsc          = CONVERT(   varChar(16), CASE 
														 WHEN CaCajOrigen = 'PP' THEN 'Pago Prima' 
														 ELSE 'Pago Vencimiento' 
                                                         END )
         , Mda1Cod            = CONVERT(   numeric(5), Caja.CaCajMdaM1 )
         , Mda1Dsc            = CONVERT(   varchar(35), ISNULL( MdaM1.MnGLosa , 'Moneda no Existe' ) )
         , Mda1Mto            = CONVERT(   numeric(21,4), SUM( Caja.CaCajMtoMon1 ) )
         , Mda2Cod            = CONVERT(   numeric(5), Caja.CaCajMdaM2 )
         , Mda2Dsc            = CONVERT(   varchar(35), ISNULL( MdaM2.MnGLosa , 'Moneda no Existe' ) )
         , Mda2Mto            = CONVERT(   numeric(21,4), SUM( Caja.CaCajMtoMon1 ) )
		 , CodEstructura	  = CONVERT(   numeric(10,0), Enc.CaCodEstructura )
         , Usuario            = @Usuario
         , TipoTransaccion	  = CONVERT(   varchar(10),Enc.CaTipoTransaccion)--PRD_12567 Papeleta productos Asiáticos
         , TipoPayOff		  = CONVERT(   varchar(2),Det.CaTipoPayOff)--PRD_12567 Papeleta productos Asiáticos
         , TipoBfwOpt         = CONVERT(   varchar(3), CASE WHEN  Enc.CaCodEstructura IN (4,5,6,8,13) THEN 'BFW'ELSE 'OPT'END)--PRD_12567
      INTO #Pagos
      FROM #Caja Caja 
            LEFT JOIN  #Detalle    Det      ON Caja.CaNumContrato   = Det.CaNumContrato 
                                           AND Caja.CaNumEstructura = Det.CaNumEstructura
            LEFT JOIN  #Moneda     MdaM1    ON MdaM1.MnCodMon       = Caja.CaCajMdaM1 
            LEFT JOIN  #Moneda     MdaM2    ON MdaM2.MnCodMon       = Caja.CaCajMdaM2 
            INNER JOIN #Encabezado Enc      ON Enc.CaNumContrato    = Det.CaNumContrato
                                           AND Enc.CaEstado        <> 'C'
            LEFT JOIN  #Cliente    Cliente  ON Cliente.ClRut        = Enc.CaRutCliente
                                           AND Enc.CaCodigo         = Cliente.ClCodigo 
      WHERE Caja.CaNumContrato = Enc.CaNumContrato
        AND(Enc.CaRutCliente   = @Rut
        AND Enc.CaCodigo       = @Codigo 
         OR @Rut               = 0
        AND @Codigo            = 0 )
       GROUP BY  
             Caja.CaNumContrato
           , Caja.CaCajFecPago
           , Enc.CaFechaContrato
           , Enc.CaRutCliente
           , Cliente.ClDv
           , Enc.CaCodigo
           , Cliente.ClNombre
           , Caja.Estado
           , Enc.CaTipoContrapartida
           , Enc.CaOperador
           , Det.CaModalidad
           , CaCajOrigen
           , CaCajMdaM1
           , CaCajMdaM2
           , MdaM1.MnGLosa
           , MdaM2.MnGLosa
		   , Enc.CaCodEstructura
		   , Enc.CaTipoTransaccion
		   , Det.CaTipoPayOff
           	
    IF NOT EXISTS( SELECT (1) FROM #Pagos )
    BEGIN 
        SELECT Pantalla           = CONVERT(    varchar(40), 'LIQUIDACION' )
             , NumContrato        = CONVERT(    numeric(8), 0 )
             , FechaEjercicio	= CONVERT(      datetime, '19000101' )
             , FechaContrato      = CONVERT(    datetime, '19000101' )
             , CliRut             = CONVERT(    numeric(9), 0 )
             , CliDv              = CONVERT(    varchar(1), '' )
             , CliCod             = CONVERT(    numeric(5), 0 )
             , CliNom             = CONVERT(    varchar(100), 'SIN DATOS'  )
             , Estado             = CONVERT(    varchar(9), '' )
             , Contrapartida      = CONVERT(    varchar(15), '' ) 
             , Operador           = CONVERT(    varchar(15), '' )
             , ModalidadCod       = CONVERT(    varchar(1), '' )
             , ModalidadDsc       = CONVERT(    varchar(15), '' )
             , OrigenCod          = CONVERT(    varchar(2), '' )
             , OrigenDsc          = CONVERT(    varchar(16), '' )
             , Mda1Cod            = CONVERT(    numeric(5), 0 )
             , Mda1Dsc            = CONVERT(    varchar(35), '' )
             , Mda1Mto            = CONVERT(    numeric(21,4), 0 )
             , Mda2Cod            = CONVERT(    numeric(5), 0 )
             , Mda2Dsc            = CONVERT(    varchar(35), '' )
             , Mda2Mto            = CONVERT(    numeric(21,4), 0 )
			 , CodEstructura	  = CONVERT(    numeric(10,0), 0 ) --0 no es el mejor default para este caso, ya que es un código de estructura válido.
             , Usuario            = @Usuario
             , TipoTransaccion	  = CONVERT(varchar(10),'')
             , TipoPayOff		  = CONVERT(varchar(2),'')
             , TipoBfwOpt         = CONVERT(varchar(3),'')

    END ELSE
    BEGIN
        SELECT * FROM #Pagos
        
    END

    DROP TABLE #Pagos
    DROP TABLE #Caja
    DROP TABLE #Detalle
    DROP TABLE #Encabezado
    DROP TABLE #Cliente
    DROP TABLE #Formas_Pago
    DROP TABLE #Moneda

    RETURN 0     			

END

GO
