USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACIONESMX]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEEROPERACIONESMX]     
   (  
     @nnumoper NUMERIC(9) 
   )    
AS    
BEGIN
 SET NOCOUNT ON; 
    SELECT 
	canumoper,
	cacodpos1,
	var_moneda2
	FROM mfca
	where var_moneda2= @nnumoper
END
GO
