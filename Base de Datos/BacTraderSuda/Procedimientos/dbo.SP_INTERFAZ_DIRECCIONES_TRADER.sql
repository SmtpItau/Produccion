USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DIRECCIONES_TRADER]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_INTERFAZ_DIRECCIONES_TRADER]
AS
BEGIN

	DECLARE @registros   integer
	DECLARE @FECHA       datetime
	DECLARE @max         integer

	select  @FECHA = (select acfecproc from mdac with(nolock) )
--	select	@max   = (select count(*) from mdmo)
	select	@max   = (	select	count(*)
						from	mdrs with(nolock)
						where	rsfecha = (select acfecproc from MDAC with(nolock))
					  )

	SET NOCOUNT ON

	SELECT	
			'Cod_Familia'	= 'MDIR'                                                                                                                                                     --1
		,	'T_producto'	= 'MD01'   --CASE WHEN A.motipoper = 'IB' THEN  isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = A.moinstser),'')   --2
										--ELSE isnull((select codigo_bco from Bacparamsuda..FAMILIA_PRODUCTO where sistema = 'BTR' and codigo_bac = A.motipoper),'')  END
		,	'rut'            = CONVERT(CHAR(9),A.rsrutcli)                                                                                                                                --3
		,	'dig'            = Cldv                                                                                                                                                       --4

		,	'n_operacion'    = CAST(A.rsnumdocu AS VARCHAR(6)) +  cast(A.rscorrela AS VARCHAR(4))+ CAST(A.rsnumoper AS VARCHAR(6) )                    --5
	--	,	'n_operacion'    = CAST(A.rsnumdocu AS VARCHAR(5)) +  cast(A.rscorrela AS VARCHAR(3))+ CAST(A.rsnumoper AS VARCHAR(5) )                    --5

		,	'maximo'         = @max                                                                                                                                                       --6
		,	'Direccion'      = ISNULL(B.Cldirecc,'')                                                                                                                                      --7  
		,	'Comuna'         = CASE WHEN B.Clcomuna = 0 THEN 9999 ELSE ISNULL(B.Clcomuna,0) END
		,	'Ciudad'         = CASE WHEN B.Clciudad = 0 THEN 9999 ELSE ISNULL(B.Clciudad,0) END
		,	'Fono'           = ISNULL(B.Clfono,0)                                                                                                                                         --10
		,	'fec_ult_act'    = B.Clfeculti                                                                                                                                                --11    
	into	#temporal 
	FROM	MDRS A,VIEW_CLIENTE B
	WHERE (	A.rsrutcli	= B.Clrut and A.rscodcli = B.Clcodigo)
	AND		A.rsfecha	= (select acfecproc from MDAC with(nolock))

    SELECT * FROM #TEMPORAL ORDER BY n_operacion

END

GO
