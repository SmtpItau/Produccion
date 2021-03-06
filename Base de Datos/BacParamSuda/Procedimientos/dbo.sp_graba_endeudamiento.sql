USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_graba_endeudamiento]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_graba_endeudamiento]
             (@Activo_Circulante	NUMERIC(19,2),
              @Pend_Inst_Finan		NUMERIC(05,2),
              @Pmax_End_Inst_Finan	NUMERIC(05,2),
              @PFwp_Perd_Dif		NUMERIC(05,2))
AS 
/*LD1-COR-035 CARGA ENDEUDAMIENTO --> CONSULTA LIMITE ENDEUDAMIENTO*/

BEGIN
SET NOCOUNT ON
	DELETE endeudamiento

	INSERT INTO endeudamiento
             (Activo_Circulante		,
              Pend_Inst_Finan		,
              Pmax_End_Inst_Finan	,
              PFwp_Perd_Dif		)
	VALUES
             (@Activo_Circulante	,
              @Pend_Inst_Finan		,
              @Pmax_End_Inst_Finan	,
              @PFwp_Perd_Dif		)
SET NOCOUNT OFF
END

GO
