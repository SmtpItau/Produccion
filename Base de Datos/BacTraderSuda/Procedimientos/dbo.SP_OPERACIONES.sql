USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_OPERACIONES '20160210'

CREATE PROCEDURE [dbo].[SP_OPERACIONES] (@fecha char(8))
AS 
begin 

set nocount on
DECLARE @FEC_PROC DATETIME
SELECT @FEC_PROC = acfecproc FROM MDAC


select  'rutcliente'  	= a.morutcli                      --1
	,'dig_ver'	= b.Cldv                           
        ,'numero_oper'	= LTRIM(str(a.monumdocu)) +LTRIM( str(a.monumoper)) +  RIGHT('000'+CAST(a.mocorrela AS VARCHAR(3) ) , 3) --LTRIM( str(a.mocorrela)) --2
	,'xxx'		= '00047' --3
	,'codigo_oper'	= REPLICATE('0',16)
        ,'moneda_oper'	= a.momonpact --a.momonemi   --4
	,'monto_oper'	= a.movpresen    
	,'fecha_oper'	= a.mofecpro --5
	,'fecha_venc'	= a.mofecvenp --6 mofecven
	,'tipo_tasa'	= case 	when datediff(day,mofecpro,a.mofecvenp)  <= 30 then 101
				when datediff(day,mofecpro,a.mofecvenp)  >  30 and datediff(day,mofecpro,a.mofecvenp)  <=   90 then 102
				when datediff(day,mofecpro,a.mofecvenp)  >  90 and datediff(day,mofecpro,a.mofecvenp)  <=  180 then 103
				when datediff(day,mofecpro,a.mofecvenp)  > 180 and datediff(day,mofecpro,a.mofecvenp)  <=  365 then 104
				when datediff(year,mofecpro,a.mofecvenp) >   1 and datediff(year,mofecpro,a.mofecvenp) <=    3 then 105
			    else 106 
			 end 
	
	,'tasa_oper'	= a.motaspact  --a.motasemi
	,'11_xxx'	= '0000000'
	,'base_operac'	= a.mobaspact --a.mobasemi
	,'13_xxx'	= 'PCT'
	,'14_xxx'	= '0000000'
	,'15_xxx'	= '000000'
	,'16_xxx'	= '0000000000000000000'
       	,'num_docu'	=  a.monumdocu
        ,'num_oper'     =  a.monumoper
        ,'correlat'     =  a.mocorrela
        ,'nombre'       =  b.Clnombre
        ,'num_oper_rpte'     = LTRIM(str(a.monumdocu)) + '-' + LTRIM( str(a.monumoper)) + '-' + LTRIM( str(a.mocorrela))
        ,mofecvenp
        ,mofecven
        ,mocodigo
        ,moforpagi 
        ,moforpagv 
	,motipoper

        into #temporal
   from mdmo  a, view_cliente b , CARTERA_CUENTA c
	 where 	a.morutcli = b.clrut  
		and a.motipoper in('VI','CI','VP','IB') --cp
		and a.mocodcli 	= b.Clcodigo
		and a.mofecpro 	= @fecha	
		AND A.mostatreg <> 'A'
-- 		AND A.moforpagi <> 10
                AND (a.moforpagi <> 5 or a.moforpagv <> 4)
		AND (a.monumdocu = c.numdocu AND a.monumoper=c.numoper AND a.mocorrela=c.correla)
		AND A.morutcli  <> 97023000
		AND C.t_movimiento = 'MOV'  -- and C.t_movimiento <> 'DEV' 
                AND CASE WHEN (mocodigo in (4,31,32,33,300,301,888) AND SUBSTRING(motipoper,1,2) in('VI','VP')) THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 
                and momonpact  <> 994
         order by a.monumdocu ,a.monumoper

      UPDATE #temporal SET codigo_oper = C.CtaContable 
      FROM  CARTERA_CUENTA C
      WHERE  C.NumDocu         = num_docu 
            AND C.Correla      = correlat 
--            AND C. NumOper     = num_oper 
            AND C.t_movimiento = 'MOV'
            AND CASE WHEN (mocodigo in (4,31,32,33,300,301,888) AND SUBSTRING(motipoper,1,2) in('VI','VP'))  THEN 'valor_venta' ELSE 'valor_compra'  END  = variable --  variable = 'valor_venta' 
   
   
   if (select COUNT(*) from #temporal) > 0   
   begin   
			SELECT *,
			'Razon_Social' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
			 FROM #temporal
	end
	else
	begin
	 select		'	rutcliente'  		= ''                      --1
				,	'dig_ver'			= ''                           
				,	'numero_oper'		= 0
				,	'xxx'				= 0
				,	'codigo_oper'		= 0
				,	'moneda_oper'		= 0 --a.momonpact --a.momonemi   --4
				,	'monto_oper'		= 0 -- a.movpresen    
				,	'fecha_oper'		= '' --a.mofecpro --5
				,	'fecha_venc'		= '' --a.mofecvenp --6 mofecven
				,	'tipo_tasa'			= 0 --case 	when datediff(day,mofecpro,a.mofecvenp)  <= 30 then 101
				,	'tasa_oper'			= 0 --a.motaspact  --a.motasemi
				,	'11_xxx'			= '0000000'
				,	'base_operac'		= 0 --a.mobaspact --a.mobasemi
				,	'13_xxx'			= '' --'PCT'
				,	'14_xxx'			= '0000000'
				,	'15_xxx'			= '000000'
				,	'16_xxx'			= '0000000000000000000'
       			,	'num_docu'			=  0 --a.monumdocu
				,	'num_oper'		    =  0 --a.monumoper
				,	'correlat'			=  0 --a.mocorrela
				,	'nombre'			=  '' --b.Clnombre
				,	'num_oper_rpte'     =  0 --LTRIM(str(a.monumdocu)) + '-' + LTRIM( str(a.monumoper)) + '-' + LTRIM( str(a.mocorrela))
				,	'mofecvenp'			= '' --mofecvenp
				,	'mofecven'			= '' --mofecven
				,	'mocodigo'			= 0 --mocodigo
				,	'moforpagi'			= 0 --moforpagi 
				,	'moforpagv'			= 0 --moforpagv 
				,	'motipoper'			= 0 --motipoper
				,	'Razon_Social'		= (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

	end

END
GO
