USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENER_OPERACIONES_RELACIONADAS_MXCLP]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_OBTENER_OPERACIONES_RELACIONADAS_MXCLP]( @OPERACION FLOAT )
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @oper1 FLOAT
	DECLARE @OPER2 FLOAT

	CREATE TABLE #TMP6622
	(
		CANUMOPER FLOAT
	);

	if ( select 1 from BacFwdSuda..MFCA where var_moneda2 = @OPERACION and canumoper != @OPERACION ) = 1
	begin
		select @oper1=var_moneda2
		      ,@oper2=canumoper
		  from BacFwdSuda..MFCA 
		 where var_moneda2 = @OPERACION
		   and canumoper  != @OPERACION
	end
	else
	begin

		if ( select 1 from VIEW_MFCA where canumoper = @OPERACION and var_moneda2 != @OPERACION ) = 1
		begin
			select @oper1=var_moneda2
				  ,@oper2=canumoper
			  from VIEW_MFCA
			 where canumoper    = @OPERACION
			   and var_moneda2 != @OPERACION
		end 
	End
	set @oper1 = isnull(@oper1, 0)
	set @oper2 = isnull(@oper2, 0)

    	INSERT #TMP6622
	SELECT @OPER1

	INSERT #TMP6622
        SELECT @OPER2

	SELECT * FROM #TMP6622

END
GO
