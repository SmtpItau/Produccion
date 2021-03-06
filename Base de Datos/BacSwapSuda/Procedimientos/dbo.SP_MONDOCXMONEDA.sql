USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONDOCXMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MONDOCXMONEDA]( @sistema CHAR(3) )  
AS
BEGIN
	SELECT	View_Moneda_Forma_de_Pago.mfcodmon,
		View_Moneda_Forma_de_Pago.mfmonpag,
		View_Moneda.mnglosa,
		View_Moneda_Forma_de_Pago.mfcodfor,
		View_Forma_de_Pago.glosa    

        FROM    View_Moneda_Forma_de_Pago,
		View_Forma_de_Pago,
		View_Moneda

        WHERE   View_Moneda_Forma_de_Pago.mfsistema	= @sistema	AND
		View_Moneda_Forma_de_Pago.mfestado	= '1'		AND
		View_Moneda_Forma_de_Pago.mfmonpag	= View_Moneda.mncodmon AND
		View_Moneda_Forma_de_Pago.mfcodfor	= View_Forma_de_Pago.codigo     

        ORDER BY View_Moneda_Forma_de_Pago.mfcodmon,
		 View_Moneda.mnglosa,
		 View_Forma_de_Pago.glosa
END
GO
