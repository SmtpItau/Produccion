USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMDER_ObtieneDatosComDer]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_COMDER_ObtieneDatosComDer]
AS
BEGIN
	SELECT  'Cliente'          =  cli.Clnombre
		   ,'RutComDer'        =  c.rut_comder
		   ,'CodClienteComDer' = cli.Clcodigo 
		   ,'MetComDer'		   = cli.ClRecMtdCod 
    FROM    BDBOMESA.dbo.ComDer_Parametros AS c WITH (NOLOCK) INNER JOIN
            BacParamSuda.dbo.CLIENTE AS cli WITH (NOLOCK) ON c.rut_comder = cli.Clrut

END

GO
