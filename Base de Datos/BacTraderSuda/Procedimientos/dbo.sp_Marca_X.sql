USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Marca_X]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- Sp_Marca_X 'BFW', '2'


CREATE procedure [dbo].[sp_Marca_X] 
	(@Sistema char(5),
	--@produ   integer = 0)	
	  @produ   CHAR(5) = '0')	

AS 

BEGIN

     SET NOCOUNT ON

     SELECT mpproducto,	mpcodigo, mpestado, mpsistema, mnglosa = (SELECT mnglosa FROM MONEDA WHERE mncodmon= mpcodigo )
			FROM bacparamsuda.dbo.PRODUCTO_MONEDA
			WHERE (mpsistema  = @sistema 
			and mpproducto = @produ )   
END

-- Base de Datos -- 


GO
