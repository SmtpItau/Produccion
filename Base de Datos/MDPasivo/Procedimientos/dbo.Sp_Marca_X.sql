USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Marca_X]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Marca_X](@Sistema char(5),
			    --@produ   integer = 0)	
			    @produ   CHAR(5) = '0')	
AS
BEGIN

     SET NOCOUNT ON
     SET DATEFORMAT dmy

     SELECT mpproducto           ,
            mpcodigo             ,
	    mpestado	         ,  
            mpsistema            
       FROM PRODUCTO_MONEDA
       WHERE (mpsistema  = @sistema 
	  and mpproducto = @produ )   
END




GO
