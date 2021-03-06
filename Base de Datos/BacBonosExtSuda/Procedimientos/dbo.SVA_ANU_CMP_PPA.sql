USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ANU_CMP_PPA]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_ANU_CMP_PPA]
(	
	@NUMDOCU  NUMERIC(9)	
)
AS
BEGIN
	SET NOCOUNT ON

	declare @fec_pago 	datetime	


	select @fec_pago = mofecpago from text_mvt_dri where @NUMDOCU  = MONUMOPER


	IF @fec_pago >= (select acfecproc from text_arc_ctl_dri) BEGIN

		if exists( select monumdocu from text_mvt_dri where monumdocu = @NUMDOCU and mostatreg ='' and motipoper='VP'  )
		 BEGIN	 
		     select '1','la operaci½n de compras registra tener ventas asocidas al instrumento que compone la operacion que esta anulando'
		 END
		 ELSE
		 BEGIN
				DELETE 
			FROM 	TEXT_CTR_INV 
			where	@NUMDOCU = cpnumdocu


			UPDATE  text_mvt_dri
			SET	MOSTATREG = 'A'
			WHERE	@NUMDOCU  = MONUMOPER


			UPDATE  text_ctr_cpr
			SET	MOSTATREG = 'A'
			WHERE	@NUMDOCU  = MONUMOPER

			select '2', 'Operación Anulada Con Exito'
		end




	end else begin
		Select '1', 'Esta Operación Ya No Se Puede Anular'
	END

	SET NOCOUNT OFF
END

GO
