USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TOTAL_POR_CUENTAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TOTAL_POR_CUENTAS]
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
Declare @cAcnombre CHAR(20)

select  @nTotal=0
SELECT  @dFechaPro= acfecpro FROM meac
SELECT  @cAcnombre= acnombre FROM meac
SELECT  @nObsDia  = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=994 and vmfecha = @dFechaPro),0)
SELECT  @nUFDia   = isnull((Select vmvalor from VIEW_VALOR_MONEDA where vmcodigo=998 and vmfecha = @dFechaPro),0)  

SELECT  'Cuenta'         = a.cuenta				,--1
        'Monto'          = ABS( SUM( ISNULL(a.Monto,0.0 ) ) ) 	,          
	'moneda'	 = a.Valor_Campo			,
	'Tipo' 		 = a.Tipo_Monto				
INTO     #tmppaso --drop table #tmppaso
FROM     bac_cnt_detalle_voucher a     
        ,bac_cnt_voucher b
WHERE    b.Fecha_Contable = @dFechaPro 
  And    b.Numero_Voucher = a.Numero_Voucher  
  And    b.Tipo_Operacion = a.Tipo_Operacion
GROUP BY a.cuenta,a.Valor_Campo,b.Tipo_Operacion,a.Tipo_Monto


SELECT distinct  'Filtro'	 = LTRIM(RTRIM(cuenta)) + SPACE(11) + LTRIM(RTRIM(Moneda)) ,
		 'CuentaC'       = cuenta,
		 'MonedaC'	 = Moneda , 
                 'Glosa'         = space(70),
                 'TDebe'         = @nTotal,
                 'THaber'        = @nTotal,
                 'Banco'         = ISNULL(@cBanco,' '),
                 'Fecha'         = CONVERT(CHAR(10),@dFechaPro,103),
		 'Nombre'	 = @cAcnombre,
                 'Hora'          = CONVERT(CHAR(8),getdate(),108 ),
				 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)  
INTO             #tmpcuenta --drop table #tmpcuenta
FROM             #tmppaso
ORDER BY         cuenta,Moneda


select Cuenta , moneda,Monto=sum(Monto),tipo
Into #tmpGrupo
from #tmppaso 
Group By Cuenta,moneda,tipo


update #tmpcuenta set TDebe = Monto from #tmpGrupo where tipo='D' and cuentaC = cuenta AND monedaC = Moneda
update #tmpcuenta set Thaber= Monto from #tmpGrupo where tipo='H' and cuentaC = cuenta AND monedaC = Moneda

update #tmpcuenta set Glosa = isnull(LTRIM(RTRIM(descripcion)),'')  from  view_plan_de_cuenta where cuenta=cuentaC 

update #tmpcuenta set TDebe = ROUND(TDebe,0)  where MonedaC = 'CLP'
update #tmpcuenta set Thaber= ROUND(Thaber,0) where MonedaC = 'CLP'

	IF EXISTS( SELECT * FROM #tmpcuenta )
		SELECT * FROM #tmpcuenta
	ELSE
		SELECT  'CuentaC'       = '', 
			'Glosa'        = space(70),
			'TDebe'         = @nTotal,
			'THaber'        = @nTotal,
			'Banco'         = @cBanco,
			'Fecha'         = CONVERT(CHAR(10),@dFechaPro,103),
	   		'Nombre'	= @cAcnombre,
			'Hora'          = CONVERT(CHAR(8),GETDATE(),108 ),  
		    'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
end



GO
