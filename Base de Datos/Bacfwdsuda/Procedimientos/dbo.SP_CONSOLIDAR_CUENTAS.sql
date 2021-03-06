USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSOLIDAR_CUENTAS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONSOLIDAR_CUENTAS]
   (   @cFecCon    Char(08)   )
AS
BEGIN
SET NOCOUNT ON
DECLARE @dFechaPro DATETIME
DECLARE @cBanco    CHAR (60)
DECLARE @nRut      NUMERIC(9)
DECLARE @nObsDia   NUMERIC(10,2)
DECLARE @nUFDia    NUMERIC(12,4)
DECLARE @cDig      CHAR(1)
Declare @nTotal    NUMERIC(21,2)
Declare @Moneda    CHAR(60)

SELECT  @dFechaPro= acfecproc, @cBanco=acnomprop FROM MFAC     

SELECT  'CuentaC'         = a.cuenta,                         --1
        'Glosa'          = convert(varchar(30), '' ),
        'TDebe'         = ABS( SUM( ( case when a.Tipo_Monto = 'D' then ISNULL(a.Monto,0.0 ) else 0 end) ) ),
        'THaber'        = ABS( SUM( ( case when a.Tipo_Monto = 'H' then ISNULL(a.Monto,0.0 ) else 0 end) ) ) ,        
        'Banco'         = @cBanco,
        'Fecha'         = CONVERT(CHAR(10),@dFechaPro,103),
        'Hora'          = CONVERT(CHAR(5),getdate(),108 )  
       ,'Moneda'         = a.moneda      
       ,'Glosa_moneda'  =  convert(varchar(10), '' ) 
	   ,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
INTO     #tmppaso
FROM     Centraliza_Voucher a     
WHERE    a.FechaContable = @cFecCon
GROUP BY cuenta  , a.moneda
order by cuenta  , a.moneda  

update #tmppaso
   set Glosa = left(isnull(descripcion,''),30)
  from view_plan_de_cuenta vi
 where CuentaC = vi.cuenta

update #tmppaso
   set Glosa_moneda = mnnemo
  from view_Moneda
 where moneda = mncodmon


 IF EXISTS( SELECT * FROM #tmppaso )
  SELECT * FROM #tmppaso
 ELSE
  SELECT  'CuentaC'       = ' ', 
   'Glosa'        = ' ',
   'TDebe'         = 0.0,
   'THaber'        = 0.0,
   'Banco'         = @cBanco,
   'Fecha'         = Convert( varchar(10), CAST( @cFecCon as DATETIME), 103 ), --CONVERT(CHAR(10),@dFechaPro,103),
   'Hora'          = CONVERT(CHAR(5),GETDATE(),108 )
  ,'Moneda'         = 0     
  ,'Glosa_moneda'  =  convert(varchar(10), '' ) 
  ,'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
end

GO
