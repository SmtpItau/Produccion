USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSOLIDAR_CUENTAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSOLIDAR_CUENTAS]  
						(@cFecCon as Char(08))
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

select  @nTotal=0
SELECT  @dFechaPro= fechaproc,@cBanco=nombre,@nRut=rut,@cDig=' ' FROM swapgeneral       
SELECT  @nObsDia  = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=994 and vmfecha = @dFechaPro),0)
SELECT  @nUFDia   = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=998 and vmfecha = @dFechaPro),0)  

SELECT  'Cuenta'         = a.cuenta,                         --1
        'Monto'          = ABS( SUM( ISNULL(a.Monto,0.0 ) ) ) ,          
        'Tipo'           = a.Tipo_Monto                     

INTO     #tmppaso
FROM     Centraliza_Voucher a     
WHERE    a.FechaContable=@cFecCon
GROUP BY a.cuenta  ,a.Tipo_Monto   

SELECT DISTINCT  'CuentaC'       = cuenta , 
                 'Glosa'        = space(60),
                 'TDebe'         = @nTotal,
                 'THaber'        = @nTotal,
                 'Banco'         = @cBanco,
                 'Fecha'         = CONVERT(CHAR(10),@dFechaPro,103),
                 'Hora'          = CONVERT(CHAR(5),getdate(),108 )  
INTO             #tmpcuenta
FROM             #tmppaso
ORDER BY         cuenta

update #tmpcuenta set TDebe= Monto from  #tmppaso  where tipo='D' and cuentaC=cuenta  
update #tmpcuenta set Thaber=Monto from  #tmppaso where tipo='H' and cuentaC=cuenta  
update #tmpcuenta set Glosa=isnull(descripcion,'')  from  view_plan_de_cuenta where cuenta=cuentaC


	IF EXISTS( SELECT * FROM #tmpcuenta )
		SELECT * FROM #tmpcuenta
	ELSE
        SELECT  'CuentaC'       = '',   
			'Glosa'        = space(60),
			'TDebe'         = @nTotal,
			'THaber'        = @nTotal,
			'Banco'         = @cBanco,
			'Fecha'         = CONVERT(CHAR(10),@dFechaPro,103),
			'Hora'          = CONVERT(CHAR(5),GETDATE(),108 )  
		
end


-- dbo.sp_consolidar_cuentas '20010904'

GO
