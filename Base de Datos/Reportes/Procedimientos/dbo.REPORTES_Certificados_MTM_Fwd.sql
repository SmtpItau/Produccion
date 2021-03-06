USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[REPORTES_Certificados_MTM_Fwd]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--REPORTES_Certificados_MTM_Fwd 82982300, 1, '20140228', 'PMOYA'

--select * from Reportes_Conexion


CREATE PROCEDURE [dbo].[REPORTES_Certificados_MTM_Fwd]
(
		@nRut AS NUMERIC(11)
	,	@nCod AS INT
	,	@dFecha varchar(10)
	,   @Usuario VARCHAR(40)

	)
AS  BEGIN

SET NOCOUNT ON



		--declare @dFecha		datetime
		--	set @dFecha		= '20140228'

		--declare @nRut		numeric(11)
		--	set	@nRut		= 82982300

		--declare @nCod		int
		--	set @nCod		= 1

		DECLARE @dia			VARCHAR(02)   
		DECLARE @mes			VARCHAR(20)
        DECLARE @año			VARCHAR(04)
        DECLARE @fecha_Consulta VARCHAR(20)

		DECLARE @Conta NUMERIC(10)
		
		SET @Conta = (SELECT charindex('-', (SELECT nombre FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)))

		 /*Format fecha*************************************************************/
   SELECT @dia  = SUBSTRING(@dFecha,7,2)
   select @mes  = SUBSTRING(@dFecha,5,2)
   SELECT @año	= SUBSTRING(@dFecha,1,4) 

   SELECT @fecha_Consulta = @dia + '-' + @mes + '-' + @año 


		select	'N° Contrato'       = Fwd.canumoper
             ,  'Fecha Inicio'      = convert(char(10), Fwd.cafecha, 103)
             ,  'Tipo Contrato'     = CASE WHEN Fwd.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END
             ,  'Modalidad'         = case when Fwd.catipmoda = 'C' then 'COMPENSADO' ELSE 'FISICO' END
             ,  'Monedas'           = ltrim(rtrim( mac.mnnemo )) + '-' + ltrim(rtrim( mps.mnnemo ))
             ,  'Monto Mx'			= Fwd.camtomon1
             ,	'Precio Fwd'		= Fwd.catipcam
             ,	'Equivalente'		= Fwd.camtomon2
             ,  'Fecha Vcto'        = convert(char(10), Fwd.cafecvcto, 103)
             ,  'Valor MTM'			= Fwd.fres_obtenido
             ,  'Observacion'       = case when Fwd.fres_obtenido >= 0 then 'A Favor Corpbanca' else 'A Favor Cliente' end
			   , 'Cliente'			= (select Clnombre from BacParamSuda..cliente where clrut = @nRut and clcodigo = @nCod)	
			 , 'Fecha_Consulta'		= @fecha_Consulta
			  , 'FirmaBanco'		= (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario) 
			  , 'Usuario_Banco'		= 
										CASE WHEN @Conta = 0 THEN
										( SELECT substring(nombre, 1, 80) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario) 
											
										ELSE
												( SELECT substring(nombre, 1, charindex('-', nombre)-1) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario) 
												--(select substring(@Usuario, 1, 80))
										END
										
		from	(
					select	canumoper, cafecha,	catipoper, catipmoda, cacodmon1, cacodmon2,	camtomon1, catipcam, camtomon2, cafecvcto, fres_obtenido
					from	BacFwdSuda.dbo.MfcaRes with(nolock)
					where	CaFechaProceso	= @dFecha
					and		(	cacodigo	= @nRut	and	 cacodcli = @nCod	) 
						union
					select	canumoper, cafecha,	catipoper, catipmoda, cacodmon1, cacodmon2,	camtomon1, catipcam, camtomon2, cafecvcto, fres_obtenido
					from	BacFwdSuda.dbo.Mfca with(nolock)
					where	@dFecha			= (select acfecproc from bacFwdSuda.dbo.Mfac with(nolock) )
					and		(	cacodigo	= @nRut	and	 cacodcli = @nCod	) 
				)	Fwd		
				left join BacparamSuda.dbo.Moneda mac On mac.mncodmon = Fwd.cacodmon1
				left join BacparamSuda.dbo.Moneda mps On mps.mncodmon = Fwd.cacodmon2

END


GO
