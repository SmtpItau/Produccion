USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_INS_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVA_INS_GRB_DAT]
	(	@cod_familia		NUMERIC(5,0)
	,   @cod_nemo			CHAR(20)
	,   @nom_nemo			CHAR(50)
	,   @rut_emis			NUMERIC(09,0)
	,   @tipo_tasa			NUMERIC(03,0)
	,   @indice_basilea		NUMERIC(01,0)
	,   @per_cupones		NUMERIC(02,0)
	,   @num_cupones		NUMERIC(03,0)
	,   @fecha_emis			DATETIME
	,   @fecha_vcto			DATETIME
	,   @afecto_encaje		CHAR(1)
	,   @tasa_emis			FLOAT
	,   @base_tasa_emi		NUMERIC(03,0)
	,   @tasa_vigente		FLOAT
	,   @fecha_primer_pago	DATETIME
	,   @dias_reales		CHAR(1)
	,   @base_flujo			NUMERIC(03,0)
	,   @tasa_fija			CHAR(1)
	,   @monto_emi			NUMERIC(19,4)
	,   @monemi				NUMERIC(3,0)
	,   @monpag				NUMERIC(3,0)
	,   @tasas_bases		NUMERIC(1,0)
	,   @per_cap			NUMERIC(2,0)
	,   @cod_emis			NUMERIC(1,0)
	,   @dias				NUMERIC(3,0)
	,   @valor_spread		FLOAT
	,   @periodo_tasa		NUMERIC(05,0)	= 0
	,   @Tipo_Cartera		NUMERIC(03,0)	= 0
	,   @idCurva			VARCHAR(50)		= ''
	,	@Agencia			INT				= 0
	,	@Clasificacion		VARCHAR(20)		= ''
	--+++COLTES, jcamposd 20171206, si es uno el nemotecnico esta marcado como coltes
	,	@esInscoltes		NUMERIC(1)		= 0 
	-----COLTES, jcamposd 20171206, si es uno el nemotecnico esta marcado como coltes
	)
AS
BEGIN

	SET NOCOUNT ON

	IF EXISTS(SELECT 1 FROM TEXT_SER WHERE cod_nemo = @cod_nemo)
	BEGIN
		UPDATE	TEXT_SER
		SET		rut_emis			= @rut_emis
		,		tipo_tasa			= @tipo_tasa
		,		indice_basilea		= @indice_basilea
		,		per_cupones			= @per_cupones
		,		num_cupones			= @num_cupones
		,		fecha_emis			= @fecha_emis
		,		fecha_vcto			= @fecha_vcto
		,		afecto_encaje		= @afecto_encaje
		,		tasa_emis			= @tasa_emis
		,		base_tasa_emi		= @base_tasa_emi
		,		tasa_vigente		= @tasa_vigente
		,		fecha_primer_pago	= @fecha_primer_pago
		,		dias_reales			= @dias_reales
		,		base_flujo			= @base_flujo
		,		tasa_fija			= @tasa_fija
		,		monto_emision		= @monto_emi
		,		monemi				= @monemi
		,		monpag				= @monpag
		,		tasas_bases			= @tasas_bases
		,		per_capital			= @per_cap
		,		cod_emis			= @cod_emis
		,		dias_habiles_valor	= @dias
		,		valor_spread		= @valor_spread
		,		periodo_tasa		= @periodo_tasa
		,		Tipo_Cartera		= @Tipo_Cartera
		,		idCurva				= @idCurva
		--+++Coltes, jcamposd 20171206
		,		coltes				= @esInscoltes
		-----Coltes, jcamposd 20171206
		WHERE	cod_nemo			= @cod_nemo
   END ELSE
   BEGIN
		INSERT INTO TEXT_SER
		(		Cod_familia
		,		Cod_nemo
		,		Nom_nemo
		,		rut_emis
		,		tipo_tasa
		,		indice_basilea
		,		per_cupones
		,		num_cupones
		,		fecha_emis
		,		fecha_vcto
		,		afecto_encaje
		,		tasa_emis
		,		base_tasa_emi
		,		tasa_vigente
		,		fecha_primer_pago
		,		dias_reales
		,		base_flujo
		,		tasa_fija
		,		monto_emision
		,		monemi
		,		monpag
		,		tasas_bases
		,		per_capital
		,		cod_emis
		,		dias_habiles_valor
		,		valor_spread
		,		periodo_tasa
		,		Tipo_Cartera
		,		idCurva
		--+++Coltes, jcamposd 20171206
		,		coltes
		-----Coltes, jcamposd 20171206

		)
		VALUES
		(		@cod_familia
		,		@cod_nemo
		,		@nom_nemo
		,		@rut_emis
		,		@tipo_tasa
		,		@indice_basilea
		,		@per_cupones
		,		@num_cupones
		,		@fecha_emis
		,		@fecha_vcto
		,		@afecto_encaje
		,		@tasa_emis
		,		@base_tasa_emi
		,		@tasa_vigente
		,		@fecha_primer_pago
		,		@dias_reales
		,		@base_flujo
		,		@tasa_fija
		,		@monto_emi
		,		@monemi
		,		@monpag
		,		@tasas_bases
		,		@per_cap
		,		@cod_emis
		,		@dias
		,		@valor_spread
		,		@periodo_tasa
		,		@Tipo_Cartera
		,		@idCurva
		--+++Coltes, jcamposd 20171206
		,		@esInscoltes
		-----Coltes, jcamposd 20171206
		)
	END

	if exists( select 1 from Tbl_Clasificacion_Instrumento where Nemo = @cod_nemo )
	begin
		update	Tbl_Clasificacion_Instrumento
		set		Clasificacion	= @Clasificacion
		,		Agencia			= @Agencia
		where	Nemo			= @cod_nemo
	end else
	begin
		insert	into Tbl_Clasificacion_Instrumento
		select	Nemo			= @cod_nemo
			,	Agencia			= @Agencia
			,	Clasificacion	= @Clasificacion
	end

	SET NOCOUNT OFF
END
GO
