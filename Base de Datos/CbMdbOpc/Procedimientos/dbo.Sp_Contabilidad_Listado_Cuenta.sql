USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Contabilidad_Listado_Cuenta]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[Sp_Contabilidad_Listado_Cuenta]
				(
				 @F1    datetime,
				 @F2    datetime,
                                 @Usuario  char(15),
                                 @Cuenta   varchar(20)
				)
AS
BEGIN
-- dbo.Sp_Contabilidad_Listado_Cuenta '20081210' , '20081210', 'MM' , ''
-- dbo.Sp_Contabilidad_Listado_Cuenta '20091230' , '20081230', 'MM' , 'MM'
   SET NOCOUNT ON
   declare @FechaProc datetime
   select @fechaproc = fechaproc from opcionesGeneral

   /*
   SELECT  TipoReg       = convert( varchar(20) , 'Detalle' )
        ,  NumeroVoucher = convert( numeric(10) , a.Numero_Voucher )  --select * from OpcVoucher
        ,  Correlativo   = convert( NUMERIC(5)  , a.Correlativo    )
        ,  Cuenta        = convert( char(20)    , a.Cuenta         )
        ,  Moneda        = Convert( Varchar(8)  , m.mnnemo ) 
        ,  Monto_Debe    = Convert( float, Case when a.Tipo_Monto = 'D' then a.Monto else 0.0 end )
        ,  Monto_Haber   = Convert( float, Case when a.Tipo_Monto = 'D' then 0.0 else a.Monto end )
        ,  Tipo_Voucher   = Convert( varChar(1) ,   b.Tipo_Voucher  )        
        ,  Tipo_Operacion = convert( varchar(5)  ,  b.Tipo_Operacion )      
        ,  Operacion      = convert( numeric(10) ,  b.Operacion   ) 
        ,  Componente     = convert( numeric(8) ,   b.Componente )         
        ,  Glosa          = convert( varchar(70) , SUBSTRING(b.Glosa,1,50) )  
        ,  Nombre         = convert( varchar(45) , d.nombre )
        ,  Descripcion    = convert( varchar(70) , Descripcion )
        ,  Folio_Perfil   = convert( numeric(10) , Folio_Perfil )
	,  Fecha          = convert( datetime    , Fecha_Ingreso , 112  )
        ,  Usuario        = convert( varchar(15) , @Usuario )
        ,  FechaDesde     = convert( datetime    , @F1 , 112  )
        ,  FechaHasta     = convert( datetime    , @F2 , 112  )
        ,  FechaProc      = convert( datetime    , @FechaProc , 112  )
     INTO #VOUCHERS
     FROM OpcDetalleVoucher 	a,
          OpcVoucher    	b,
          lnkBac.BacParamSuda.dbo.Moneda   m,
          lnkBac.BacParamSuda.dbo.Plan_de_Cuenta		c,
          OpcionesGeneral             	d
   WHERE Fecha_Ingreso between @F1 AND @F2    AND
	  a.Numero_Voucher = b.Numero_Voucher AND
          a.Moneda         = m.MnCodMon       AND
          c.Cuenta = a.Cuenta                 AND
          ( a.Cuenta = @Cuenta or @Cuenta = '' )
   ORDER BY a.Cuenta , Fecha_Ingreso
   */
   --insert into #VOUCHERS
   SELECT  TipoReg       = convert( varchar(20) , 'Total por Cuenta' )
        ,  NumeroVoucher = convert( numeric(10) , 0 )  --select * from OpcVoucher
        ,  Correlativo   = convert( NUMERIC(5)  , 0    )
        ,  Cuenta        = convert( char(20)    , a.Cuenta         )
        ,  Moneda        = Convert( Varchar(8)  , m.mnnemo ) 
        ,  Monto_Debe    = Convert( float, sum( Case when a.Tipo_Monto = 'D' then a.Monto else 0.0 end ) )
        ,  Monto_Haber   = Convert( float, sum( Case when a.Tipo_Monto = 'D' then 0.0 else a.Monto end ) )
        ,  Tipo_Voucher   = Convert( varChar(1) ,   ''  )        
        ,  Tipo_Operacion = convert( varchar(5)  ,  '' )      
        ,  Operacion      = convert( numeric(10) ,  0   ) 
        ,  Componente     = convert( numeric(8) ,   0 )         
        ,  Glosa          = convert( varchar(70) , '' )  
        ,  Nombre         = convert( varchar(45) , '' )
        ,  Descripcion    = convert( varchar(70) , c.Descripcion )
        ,  Folio_Perfil   = convert( numeric(10) , 0 )
	,  Fecha          = convert( datetime    , @FechaProc , 112  )
        ,  Usuario        = convert( varchar(15) , @Usuario )
        ,  FechaDesde     = convert( datetime    , @F1 , 112  )
        ,  FechaHasta     = convert( datetime    , @F2 , 112  )
        ,  FechaProc      = convert( datetime    , @FechaProc , 112  )
   into #VOUCHERS
     FROM OpcDetalleVoucher 	a,
          OpcVoucher    	b,
         lnkBac.BacParamSuda.dbo.Moneda   m,
          lnkBac.BacParamSuda.dbo.Plan_de_Cuenta		c
    WHERE Fecha_Ingreso between @F1 AND @F2 AND
	  a.Numero_Voucher = b.Numero_Voucher AND
          a.Moneda         = m.MnCodMon       AND
          c.Cuenta = a.Cuenta                -- AND 
         --( a.Cuenta = @Cuenta or @Cuenta = '' )
    Group BY  a.Moneda , m.mnnemo, a.Cuenta , c.Descripcion

    IF (SELECT COUNT(*) FROM #VOUCHERS) = 0
       INSERT INTO #VOUCHERS 
       SELECT TipoReg    = convert( varchar(20) , 'Sin Dato' ) 
        ,  NumeroVoucher = convert( numeric(10) , 0 )  --select * from OpcVoucher
        ,  Correlativo   = convert( NUMERIC(5)  , 0    )
        ,  Cuenta        = convert( char(20)    , 'SIN DATOS'         )
        ,  Moneda        = Convert( Varchar(8)  , '' ) 
        ,  Monto_Debe    = Convert( float, 0.0 )
        ,  Monto_Haber   = Convert( float, 0.0 )
        ,  Tipo_Voucher   = Convert( varChar(1) ,   ''  )        
        ,  Tipo_Operacion = convert( varchar(5)  ,  '' )      
        ,  Operacion      = convert( numeric(10) ,  0   ) 
        ,  Componente     = convert( numeric(8) ,   0 )         
        ,  Glosa          = convert( varchar(70) , '' )  
        ,  Nombre         = convert( varchar(45) , '' )
        ,  Descripcion    = convert( varchar(70) , '' )
        ,  Folio_Perfil   = convert( numeric(10) , 0 )
	,  Fecha          = convert( datetime , @FechaProc, 112  )
        ,  Usuario        = convert( varchar(15) , @Usuario )
        ,  FechaDesde     = convert( datetime    , @F1 , 112  )
        ,  FechaHasta     = convert( datetime    , @F2 , 112  )
        ,  FechaProc      = convert( datetime    , @FechaProc , 112  )
		
    
	SELECT *, 'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)  FROM #VOUCHERS order by  Cuenta , TipoReg 

END

--select * from lnkBac.BacParamSuda.dbo.Moneda

GO
