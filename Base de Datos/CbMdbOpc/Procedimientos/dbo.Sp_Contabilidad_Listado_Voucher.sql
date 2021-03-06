USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Contabilidad_Listado_Voucher]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Contabilidad_Listado_Voucher]
				(
				 @Fecha    datetime,	
                                 @Usuario  char(15)
				)
AS
BEGIN
-- dbo.Sp_Contabilidad_Listado_Voucher '20081205' ,  'MM'
-- dbo.Sp_Contabilidad_Listado_Voucher '20081209' ,  'MM' 
-- dbo.Sp_Contabilidad_Listado_Voucher '20091230' , '20081230', 'MM' 
-- 17 Septiembre se corrige el orden de presentacion
-- 14 Octubre    se elimina orden inservible que hacia lento el reporte
   SET NOCOUNT ON
   SELECT  NumeroVoucher = convert( numeric(10) , a.Numero_Voucher )  --select * from OpcVoucher
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
	,  Fecha          = convert( datetime , @Fecha , 112  )
        ,  Usuario        = convert( varchar(15) , @Usuario )
     INTO #VOUCHERS
     FROM OpcDetalleVoucher 	a,
          OpcVoucher    	b,
          lnkbac.BacParamSuda.dbo.Moneda   m,
          lnkbac.BacParamSuda.dbo.Plan_de_Cuenta		c,
          OpcionesGeneral             	d
    WHERE Fecha_Ingreso = @Fecha AND 
	  a.Numero_Voucher = b.Numero_Voucher AND
          a.Moneda         = m.MnCodMon and
          c.Cuenta = a.Cuenta 
    --ORDER BY b.Operacion, b.Componente 

    IF (SELECT COUNT(*) FROM #VOUCHERS) = 0
       INSERT INTO #VOUCHERS 
       SELECT  NumeroVoucher = convert( numeric(10) , 0 )  --select * from OpcVoucher
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
	,  Fecha          = convert( datetime , @Fecha, 112  )
        ,  Usuario        = convert( varchar(15) , @Usuario )

    SELECT *, 'BannerLargo' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)  FROM #VOUCHERS order by Operacion, Tipo_Operacion

END

GO
