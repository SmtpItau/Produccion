USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZANUMOPEMXCLP]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZANUMOPEMXCLP](
	@NroOpeMxClp     INT, 
	@nNroOpeOriginal INT
)
AS 
BEGIN

      UPDATE mfca 
	 SET var_moneda2 = @NroOpeMxClp
       WHERE canumoper = @nNroOpeOriginal

      UPDATE mfmo
         SET moNroOpeMxClp = @NroOpeMxClp
       WHERE monumoper     = @nNroOpeOriginal	

	  
END

GO
